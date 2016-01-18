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
        [this.bookImgView sd_setImageWithURL:[this.book.imgUrl toURL]];
        this.bookInfoLabel.text = [@"     " concat:this.book.summary];
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
    this.loadingView = [LoadingView initView];
    [this.root addSubview:this.loadingView];
    [this.tableView registerNibClass:[ChapterViewCell class] withCellIdentifier:cellReuseIdentifier];
    this.tableView.dataSource=this;
    this.tableView.delegate=this;
    [self doQueryDetail];
    [self doQueryChapterList];
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
        List<ChapterInfo *> *list=res.list;
        chapterListInfo=res;
        chapterListInfo.list=ListNew;
        [list each:^(ChapterInfo *item) {
            [chapterListInfo.list add:item];
        }];
        [this.tableView reloadData];
    }
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
     cell.chapterLabel.text=[info.text copy];
    cell.chapterLabel.textColor=[UserSetting getIntance].contentColor;
    return cell;
}
@end
