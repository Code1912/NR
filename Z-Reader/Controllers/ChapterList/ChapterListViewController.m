//
//  ChapterListViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/25.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ChapterListViewController.h"
#import "ChapterListResponse.h"
@interface ChapterListViewController ()

@end
ChapterListResponse * chapterRes;
@implementation ChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    chapterRes=[ChapterListResponse new];
    chapterRes.list=ListNew;
    
   //[[self navigationController] setNavigationBarHidden:YES animated:NO];
    this.navigationController.navigationBar.hidden=YES;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UserSetting imgWithName:@"readback"]];
  
    this.tableView.backgroundView=view;
    this.tableView.backgroundColor = [UIColor clearColor];
    this.tableView.opaque = NO;
    this.tableView.delegate=this;
    this.tableView.dataSource=this;
    [this.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    [this.tableView registerNibClass:[ChapterViewCell class] withCellIdentifier:cellReuseIdentifier];
    this.loadingView=[LoadingView initView];
    [this.rootView addSubview:this.loadingView];
   
    
    [this.backBtn setBackgroundImage:[UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
    [this.backBtn  addTarget:self action:@selector(btnBack_Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [this.donwnBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [this.donwnBtn.layer setBorderWidth:1.0]; //边框宽度
   
    this.donwnBtn.layer.borderColor=MakeUIColor(182, 167, 142, 1).CGColor;
    [this.headerView setBackground:[UserSetting imgWithName:@"readback1"]];
    [this.footerView setBackground:[UserSetting imgWithName:@"readback1"]];
    [this doQuery:1];
 

}
-(void)doQuery:(NSInteger)pageIndex
{
    [this.loadingView show];
    chapterRes.current_page=pageIndex;
    NSString* urlStr = [NSString stringWithFormat:GetChapterListUrl, pageIndex, this.book.bookId];
    ASIHTTPRequest* request =
    [ASIHTTPRequest requestWithURL:[urlStr toEncodeURL]];
    
    request.tag = pageIndex;
    
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [this.loadingView hide];
    [this alert:@"获取章节失败！"];
    return;
}
- (void) requestFinished:(ASIHTTPRequest*)request
{

    NSString* responseString = [request responseString];
    NSError* error = [request error];
    if (error != nil) {
        
        return;
    }
    ChapterListResponse* res =  [ChapterListResponse yy_modelWithJSON:responseString];
    if(res==nil)
    {
        [this.loadingView hide];
        [this alert:@"获取章节失败！"];
        return;
    }
    chapterRes.chapter_count=res.chapter_count;
    chapterRes.chapter_all_count=res.chapter_all_count;
    chapterRes.page_count=res.page_count;
    chapterRes.current_page=res.current_page;
    chapterRes.has_more=res.has_more;
    [this.tableView addNewRow:chapterRes.list withNewRows:res.list];
    if(chapterRes.has_more)
    {
        [this doQuery:chapterRes.current_page+1];
    }
    else
    {
        [this.loadingView hide];
    }
}
- (void)btnBack_Click
{
    [self.navigationController popViewControllerAnimated:YES];
    this.navigationController.navigationBar.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chapterRes.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChapterViewCell* cell = (ChapterViewCell*)[tableView
                                               dequeueReusableCellWithIdentifier:cellReuseIdentifier
                                               forIndexPath:indexPath];
    ChapterInfo* info = [chapterRes.list getByIndex:indexPath.row];
    cell.chapterLabel.text = info.text;
    cell.chapterLabel.textColor = [UserSetting getIntance].contentColor;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
