//
//  KeyWordViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/14.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "KeyWordViewController.h"
#import "HotWordHeaderView.h"
@interface KeyWordViewController ()
{
    UIButton*  btnSearch;
    UIButton*  btnBack;
    UITextField *txtSearch;
    NSMutableArray<WordEntity*> *searchHistoryList;
    NSMutableArray<WordEntity*> *hotWordList;
}
@end

@implementation KeyWordViewController

- (void)viewDidLoad {
    [self loadData];
  
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(_rootView.frame.size.width ,50.0f);  //设置head大小
    [_collectionView registerNibClass:[KeyWordViewCell class] withCellIdentifier:cellReuseIdentifier ];
    [_collectionView registerNibClass:[HotWordHeaderView class] withHeaderIdentifier:headerReuseIdentifier];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.collectionViewLayout=flowLayout;
     self.loadingView=[[LoadingView new]init];
    [_rootView addSubview:self.loadingView];
     
    btnSearch=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0, 0, 30, 30);
    [btnSearch addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem new]initWithCustomView:btnSearch];
    
    btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 25, 25);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem new]initWithCustomView:btnBack];
     [btnBack addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    
    txtSearch=[[UITextField new]init];
    txtSearch.font=[UIFont systemFontOfSize:11 weight:11];
    [txtSearch setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    txtSearch.placeholder = @"搜索小说或作者"; //默认显示的字
    txtSearch.frame=CGRectMake(0, 0, _rootView.frame.size.width-90, 25);
    self.navigationItem.titleView=txtSearch;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
     txtSearch.frame=CGRectMake(0, 0, _rootView.frame.size.width-90, 25);
}
-(void)loadData
{ 
    [self loadSearchHistory];
    [self loadHotWord];

}

-(void)loadSearchHistory
{
    NSMutableArray<WordEntity*>* array1 = [WordEntity searchWithWhere:@" wordType=0 " orderBy:@"dateTime desc" offset:0 count:8];
    if(searchHistoryList==nil)
    {
        searchHistoryList=[[NSMutableArray new] init];
    }
    
    [searchHistoryList removeAllObjects];
    [searchHistoryList addObjectsFromArray:array1];
    
    [array1 removeAllObjects];
}

-(void)loadHotWord
{
    NSMutableArray<WordEntity*>* array = [WordEntity searchWithWhere:@" wordType=1 " orderBy:@"dateTime desc" offset:0 count:100];
    if(hotWordList==nil)
    {
        hotWordList=[[NSMutableArray new] init];
    }
    
    [hotWordList removeAllObjects];
    [hotWordList addObjectsFromArray:array];
    for (WordEntity* item in  array ) {
        [item deleteToDB];
    }
    [array removeAllObjects];
    
    if(hotWordList.count==0)
    {
        [self doQueryHotWord];
    }
}
-(void)doSearch
{
    if([txtSearch.text isNullOrWhiteSpaceEmpty])
    {
        return;
    }
    WordEntity *item=[searchHistoryList findItem:^BOOL(WordEntity *item) {
        return [item.word isEqualToString:[txtSearch.text trim]];
    }];
    if (!item) {
        if(searchHistoryList.count>10)
        {
            [searchHistoryList removeAtIndex:searchHistoryList.count-1];
        }
        WordEntity * word=[[WordEntity new]init];
        word.word=[txtSearch.text trim];
        [word saveToDB];
    }
    else
    {
        item.dateTime=[NSDate new];
        [item saveToDB];
    }
    [self loadSearchHistory];
    [_collectionView reloadData];
    if (self.navigationController.visibleViewController==self) {
        [BookManager setQueryWord:txtSearch.text];
        [self performSegueWithIdentifier:@"ToSearchView" sender:self];
    }
    
}
-(void)doBack
{
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) doQueryHotWord
{
    for (NSInteger i=0; i<hotWordList.count; i++) {
         WordEntity* item=[hotWordList objectAtIndex:i];
         [item deleteToDB];
    }
    [hotWordList removeAllObjects];
    [self.loadingView show];
    NSInteger pn=arc4random() % 5;
    NSString *urlStr=[NSString  stringWithFormat:GetHotWordUrl ,pn];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[urlStr toURL]];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    //  NSError *error = [request error];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.loadingView hide];
    NSString *responseString = [request responseString];
    NSError *error = [request error];
    if(error!=nil)
    {
        return;
    }
    HotWordResponse * hotWord =   [HotWordResponse yy_modelWithJSON:responseString];
    
    if (hotWord==nil||hotWord.hotWord==nil||hotWord.hotWord.count==0) {
        return;
    }
   
    NSInteger index=0;
    for ( NSString *item in hotWord.hotWord ) {
        WordEntity *entity=[WordEntity initWithWord:item andSortId:index];
        entity.wordType=1;
        //  [WordList add: entity];
        [entity saveToDB];
        index++;
        [hotWordList addObject:entity];
    }
    
    [self.collectionView reloadData];
    //NSLog(responseString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configTheme
{
    [btnSearch setBackgroundImage:[UserSetting imgWithName:@"search"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
    [_rootView setBackgroundColor:[UserSetting getIntance].backColor];
    [_collectionView setBackgroundColor:[UserSetting getIntance].backColor];
    txtSearch.textColor=[UserSetting getIntance].titleColor;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(160, 35);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section==0?searchHistoryList.count:hotWordList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KeyWordViewCell *cell = (KeyWordViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    WordEntity *entity=[indexPath.section==0?searchHistoryList:hotWordList objectAtIndex:indexPath.row];
    if (indexPath.section==0) {
        cell.labelTitle.text=entity.word;
        cell.labelTitle.textAlignment=NSTextAlignmentCenter;
    }
    else
    {
        cell.labelTitle.text = [@"               " concat:entity.word];
        cell.labelTitle.textAlignment=NSTextAlignmentLeft;
        cell.labelNumber.text= [NSString stringWithFormat: @"%ld", indexPath.row+1];
        
        if(indexPath.row==0)
        {
            cell.labelNumber.backgroundColor=MakeUIColor(239, 101, 101,1);
        }
        else if(indexPath.row==1)
        {
            cell.labelNumber.backgroundColor=MakeUIColor(241, 131, 59,1);
        }
        else if(indexPath.row==2)
        {
            cell.labelNumber.backgroundColor=MakeUIColor(255, 191, 20,1);
        }
        else
        {
            cell.labelNumber.backgroundColor=MakeUIColor(179, 179, 179,1);
        }
    }
 
 
    cell.labelTitle.backgroundColor= [[UIColor new]initWithRed:240./255.0 green:240.0/255.0  blue:240.0/255.0  alpha:1];;
    cell.labelTitle.textColor=[UserSetting getIntance].titleColor;
    cell.labelTitle.font=[UIFont systemFontOfSize:11 weight:11];
    cell.labelNumber.hidden=(indexPath.section==0);
   
    return cell;
}


// header 实现
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    if (kind != UICollectionElementKindSectionHeader)
    {
        return nil;
    }
    HotWordHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
    headerView.labelTitle.text=indexPath.section==0?@"搜索历史":@"大家都在搜";
    headerView.labelTitle.textColor=[UserSetting getIntance].titleColor;
    [headerView.btn setBackgroundImage:[UserSetting imgWithName:indexPath.section==0?@"trash":@"refresh"] forState:UIControlStateNormal];
    headerView.btn.tag=indexPath.section;
    [headerView.btn addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
}
-(void)headerClick:(UIButton *) sender{
    
    if(sender.tag==1)
    {
        [self doQueryHotWord];
    }
    else
    {
        [searchHistoryList each:^(WordEntity *item) {
             [item deleteToDB];
        }];
        [searchHistoryList clear];
        [_collectionView reloadData];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordEntity *entity=[indexPath.section==0?searchHistoryList:hotWordList objectAtIndex:indexPath.row];
    txtSearch.text=entity.word;
    [self doSearch];
    
}

-(void)dealloc
{
    [hotWordList removeAllObjects];
    [searchHistoryList removeAllObjects];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.titleView=nil;
    _collectionView.dataSource=nil;
    _collectionView.delegate=nil;
    _collectionView=nil;
    [_collectionView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    hotWordList=nil;
    searchHistoryList=nil;
    btnBack=nil;
    btnSearch=nil;
    
    txtSearch=nil;
    NSLog(@"key word dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
