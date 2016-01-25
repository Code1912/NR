//
//  SearchViewController.m
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{

    novelList = [[List new] init];
    btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0, 0, 30, 30);
    [btnSearch addTarget:self action:@selector(btnSearch_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem new] initWithCustomView:btnSearch];

    btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 25, 25);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new] initWithCustomView:btnBack];
    [btnBack addTarget:self action:@selector(backBtn_Click:) forControlEvents:UIControlEventTouchUpInside];

    txtSearch = [[UITextField new] init];
    txtSearch.font = [UIFont systemFontOfSize:11 weight:11];
    [txtSearch setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    txtSearch.placeholder = @"搜索小说或作者"; //默认显示的字
    txtSearch.frame = CGRectMake(0, 0, _rootView.frame.size.width - 90, 25);
    self.navigationItem.titleView = txtSearch;
    txtSearch.text = [BookManager getQueryWord];
    self.loadingView = [[LoadingView new] init];
    [self.rootView addSubview:self.loadingView];

    [self.novelListTableView registerNibClass:[SearchTableCellView class] withCellIdentifier:cellReuseIdentifier];
    self.novelListTableView.delegate = self;
    self.novelListTableView.dataSource = self;
    self.novelListTableView.separatorStyle = YES;

    [self.novelListTableView setSeparatorColor:[UserSetting getIntance].mainColor];
    [super viewDidLoad];
    if (txtSearch.text) {
        [self doQuery:txtSearch.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)configTheme
{
    [btnSearch setBackgroundImage:[UserSetting imgWithName:@"search"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
    [_rootView setBackgroundColor:[UserSetting getIntance].backColor];
    [_novelListTableView setBackgroundColor:[UserSetting getIntance].backColor];
    txtSearch.textColor = [UserSetting getIntance].titleColor;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn_Click:(id)sender
{
    // [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnSearch_Click:(id)sender
{
    [self.loadingView show];
    [self doQuery:txtSearch.text];
}

- (IBAction)txtSearchBox_EditingEnd:(id)sender
{
}
- (IBAction)txtSearchBox_EditingBegin:(id)sender
{
    // [txtSearch becomeFirstResponder];
}

- (void)doQuery:(NSString*)word
{
    if ([word isNullOrWhiteSpaceEmpty]) {
        [self doQueryEnd:false];
        return;
    }
    if ([word isEqualToString:queryWord] && novelList.count > 0) {
        [self doQueryEnd:false];
        return;
    }
    queryWord = word;
    pageNumber = 0;
    [novelList clear];
    novelTotal = 0;
    footerView.hidden = true;
    [_novelListTableView reloadData];
    [self innerQuery:queryWord andPageNumber:pageNumber];
}

- (void)innerQuery:(NSString*)word andPageNumber:(NSInteger)pn
{
    NSString* urlStr;
    if (pn == 0) {
        urlStr = [NSString stringWithFormat:SearchNovelUrl0, word];
    }
    else {
        urlStr = [NSString stringWithFormat:SearchNovelUrl, word, pn];
    }
    ASIHTTPRequest* request =
        [ASIHTTPRequest requestWithURL:[urlStr toEncodeURL]];

    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)doQueryEnd:(BOOL)ret
{

    [self.loadingView hide];
}
- (void)requestFailed:(ASIHTTPRequest*)request
{
    //NSError* error = [request error];
    //  NSLog(error.localizedFailureReason);
    [footerView endWork];
    [self doQueryEnd:false];
}
- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* responseString = [request responseString];
    NSError* error = [request error];
    if (error != nil) {
        [self doQueryEnd:false];
        return;
    }
    SearchNovelResponse* res =
        [SearchNovelResponse yy_modelWithJSON:responseString];

    if (res == nil || res.list == nil || res.list.count == 0) {
        [self doQueryEnd:false];
        return;
    }
    footerView.hidden = false;

    novelTotal = res.total;

    NSMutableArray<NSIndexPath*>* paths = [[NSMutableArray new] init];
    NSInteger startIndex = novelList.count;
    [novelList addRange:res.list];
    for (int index = 0; index < res.list.count; index++) {
        NSIndexPath* newPath =
            [NSIndexPath indexPathForRow:startIndex + index inSection:0];
        [paths addObject:newPath];
    }
    [_novelListTableView insertRowsAtIndexPaths:paths
                               withRowAnimation:UITableViewRowAnimationFade];
    [_novelListTableView endUpdates];

    if (novelList.count == novelTotal) {

        [footerView endWorkWithNoMore];
    }
    else {
        [footerView endWork];
    }
    [self doQueryEnd:true];
    // NSLog(responseString);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return novelList.count;
}

//创建 cell
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    SearchTableCellView* cell = (SearchTableCellView*)[tableView
        dequeueReusableCellWithIdentifier:cellReuseIdentifier
                             forIndexPath:indexPath];
    if (novelList.count > 0 && indexPath.row == novelList.count) {
    }
    NovelInfo* info = [novelList getByIndex:indexPath.row];
    if ([info.imgUrl isNullOrWhiteSpaceEmpty]) {
        cell.logoImageView.image = [UserSetting imgWithName:@"noimg" ofType:@"png"];
    }
    else {
        [cell.logoImageView sd_setImageWithURL:[info.imgUrl toURL]];
    }
    cell.labelName.textColor = [UserSetting getIntance].titleColor;
    info.name = [self replaceTitle:info.name];

    NSRange rang = [info.name rangeOfString:queryWord];
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:info.name];
    [str addAttribute:NSForegroundColorAttributeName value:[UserSetting getIntance].mainColor range:rang];
    cell.labelName.attributedText = str;

    cell.labelAuthor.text = [NSString stringWithFormat:@"%@ | %@ | %@", info.author, info.categoryName, info.status];
    cell.labelAuthor.textColor = [UserSetting getIntance].contentColor;
    cell.labelContent.textColor = [UserSetting getIntance].contentColor;
    cell.labelContent.text = info.summary;
    [cell setBook:info];
    return cell;
}
- (NSString*)replaceTitle:(NSString*)str
{
    str = [str stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    return str;
}
- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    //  NSLog(@"index:%d",indexPath.row);
    return 90;
}

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    SearchTableCellView* cell = (SearchTableCellView*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    if (self.navigationController.visibleViewController == self) {

        [self performSegueWithIdentifier:@"ToDetail" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ToDetail"]) {
        NSIndexPath *indexPath = [self.novelListTableView indexPathForSelectedRow];
        NovelInfo *info=[novelList getByIndex:indexPath.row];
        BookDetailViewController *controller = (BookDetailViewController *)[segue destinationViewController] ;
        [controller setBook:info];
       // controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
       // controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


//可编辑状态
- (BOOL)tableView:(UITableView*)tableView
    canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return NO;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    if (novelList.count == 0) {
        return nil;
    }

    LoadMoreTableViewCell* tempCell = (LoadMoreTableViewCell*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:LoadingTableCellIdentifer];
    if (!tempCell) {
        [tableView registerClass:[LoadMoreTableViewCell class] forHeaderFooterViewReuseIdentifier:LoadingTableCellIdentifer];
        tempCell = (LoadMoreTableViewCell*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:LoadingTableCellIdentifer];
        CGSize size = CGSizeMake(tableView.frame.size.width, 40);
        [tempCell initSubViews:size];
        tempCell.delegate = self;
    }
    else{
        
        [tempCell resetSize:CGSizeMake(tableView.frame.size.width, 40)];
    }
    footerView = tempCell;
    
    return footerView;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
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

- (void)loadMore
{
    if (novelList.count == novelTotal && novelTotal != 0) {
        [self.loadingView hide];
        return;
    }
    [footerView showWork];
    pageNumber++;
    [self innerQuery:queryWord andPageNumber:pageNumber];
}

- (void)dealloc
{
    NSLog(@"search dealloc");
}
@end
