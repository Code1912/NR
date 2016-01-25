//
//  BookDetailViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/12.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookDetailViewController.h"

#import "BookDetailResponse.h"
@interface BookDetailViewController () {
 
}

@end

@implementation BookDetailViewController
- (void)viewDidLoad
{
    this.navigationItem.title = @"书籍简介";
    btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 25, 25);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new] initWithCustomView:btnBack];
    [btnBack addTarget:self action:@selector(btnBack_Click) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_book) {
        this.bookNameLabel.text = this.book.name;
        this.authorLabel.text = [@"作者：" concat:this.book.author];
        this.categoryLabel.text = [@"分类：" concat:this.book.categoryName];
        this.sourceLabel.text = [@"状态：" concat:this.book.status];
        if ([this.book.imgUrl isNullOrWhiteSpaceEmpty]) {
            [this.bookImgView setImage: [UserSetting imgWithName:@"noimg"]];
        }
        else{
            [this.bookImgView sd_setImageWithURL:[this.book.imgUrl toURL]];
        }
        if([this.book.summary length]>300)
        {
            this.bookInfoLabel.text = [[[@"     " concat:this.book.summary ] substringWithRange:NSMakeRange(0, 250)] concat:@"......"];;
        }
        else
        {
            this.bookInfoLabel.text = [@"     " concat:this.book.summary];
        }
       // NSLog(@"-----:%ld",[this.book.summary length]);
    }
    this.btnStartRead.backgroundColor = [UserSetting getIntance].mainColor;
    [this.btnStartRead setTitleColor:[UserSetting getIntance].headerColor forState:UIControlStateNormal];
    this.btnAddToBookrack.backgroundColor = [UserSetting getIntance].mainColor;
    [this.btnAddToBookrack setTitleColor:[UserSetting getIntance].headerColor forState:UIControlStateNormal];
    this.line1.backgroundColor = [UserSetting getIntance].mainColor;
    this.line2.backgroundColor = [UserSetting getIntance].mainColor;
    this.bookInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    this.bookInfoLabel.preferredMaxLayoutWidth = self.view.frame.size.width;
    this.authorLabel.textColor = [UserSetting getIntance].titleColor;
    this.categoryLabel.textColor = [UserSetting getIntance].titleColor;
    this.sourceLabel.textColor = [UserSetting getIntance].titleColor;
    this.bookInfoLabel.textColor = [UserSetting getIntance].contentColor;
    this.tagLabel.textColor = [UserSetting getIntance].titleColor;
    this.scrollView.contentSize=this.root.frame.size;
    this.scrollView.delegate=self;
    
    this.tableView.scrollEnabled=NO;
    this.loadingView = [LoadingView initView];
    [this.root addSubview:this.loadingView];
    
    [this.tableView registerNibClass:[ChapterViewCell class] withCellIdentifier:cellReuseIdentifier];
 
    this.tableView.dataSource=this;
    this.tableView.delegate=this;
    [self doQueryDetail];
    [self doQueryChapterList];
    //this.scrollView.frame=this.root.frame;
}

- (void)btnBack_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)doQueryDetail
{
    [this.loadingView show];
    NSString* urlStr = [NSString stringWithFormat:GetNovelDetailUrl, this.book.bookId, this.book.url];
    ASIHTTPRequest* request =
        [ASIHTTPRequest requestWithURL:[urlStr toEncodeURL]];
    request.tag=0;

    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest*)request
{
   [this.loadingView hide];
    NSString* responseString = [request responseString];
    NSError* error = [request error];
    if (error != nil) {
  
        return;
    }
    if (request.tag == 0) {
        BookDetailResponse* res =
            [BookDetailResponse yy_modelWithJSON:responseString];
        if (res && res.data && res.data.keyWords) {
            this.tagLabel.text = [res.data.keyWords isNullOrEmpty] ? @"标签：暂无" : [@"标签：" concat:res.data.keyWords];
        }
    }
    else
    {
        ChapterListResponse* res =
        [ChapterListResponse yy_modelWithJSON:responseString];
 
        chapterListInfo=res;
     
       
        CGRect frame= this.scrollView.frame;
     
        //this.scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, this.tableView.frame.origin.y+20*40) ;
        this.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, this.tableView.frame.origin.y+22*30);
    
         //this.tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 22*30);
        [this.tableView reloadData];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame= this.scrollView.frame;
    
    //this.scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, this.tableView.frame.origin.y+20*40) ;
    this.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, this.tableView.frame.origin.y+22*30);
    this.tableView.frame=CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, 22*30);
   // NSLog(@"------------ddsdfsfsfd");
}
-(void)viewDidLayoutSubviews
{
   // NSLog(@"22");
   // this.scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, this.tableView.frame.origin.y+this.tableView.frame.size.height);
   // this.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, this.tableView.frame.origin.y+this.tableView.frame.size.height);
}

-(void)viewWillAppear:(BOOL)animated
{
   //  NSLog(@"111");
}
-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    
}
-(void)doQueryChapterList
{
    NSInteger pageNumber=1;
    NSString* urlStr = [NSString stringWithFormat:GetChapterListUrl, pageNumber, this.book.bookId];
    ASIHTTPRequest* request =
    [ASIHTTPRequest requestWithURL:[urlStr toEncodeURL]];
    request.tag=1;
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}
- (void)requestFailed:(ASIHTTPRequest*)request
{
    [this.loadingView hide];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)configTheme
{
    self.root.backgroundColor = [UserSetting getIntance].backColor;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [btnBack setBackgroundImage:[UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
}

- (IBAction)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (chapterListInfo.list.count>20) {
        return  20;
    }
    return chapterListInfo.list.count;
}

//创建 cell
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ChapterViewCell* cell = (ChapterViewCell*)[tableView
                                                       dequeueReusableCellWithIdentifier:cellReuseIdentifier
                                                       forIndexPath:indexPath];
    ChapterInfo *info=[chapterListInfo.list getByIndex:indexPath.row ];
     cell.chapterLabel.text=info.text ;
    cell.chapterLabel.textColor=[UserSetting getIntance].contentColor;
    return cell;
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    //  NSLog(@"index:%d",indexPath.row);
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!tableHeader) {
     //  tableHeader=[[UIView new]initWithFrame:CGRectMake(0,0, tableView.frame.size.width, 30)];
        UILabel *label=[[UILabel new]init];
        label.frame=CGRectMake(0,0, tableView.frame.size.width, 30);
        label.backgroundColor=[UserSetting getIntance].contentColor;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment=NSTextAlignmentLeft;
        label.text=@"目录";
        tableHeader= label;
    }
    else{
        tableHeader.frame=CGRectMake(0,0, tableView.frame.size.width, 30);
    }
    return tableHeader;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return tableFooter;
}
@end
