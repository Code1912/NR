//
//  SearchListViewModel.m
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import "SearchListViewModel.h"
#import "UserSetting.h"
@implementation SearchListViewModel

LoadMoreTableViewCell *footerView;
- (id)init
{
    if (self = [super init]) {
        novelList = [[List new] init];
    }
    return self;
}

- (void)doQuery:(NSString*)word
{
    if ([word isNullOrWhiteSpaceEmpty]) {
        [self doQueryEnd:false];
        return;
    }
    word = [word trim];
    if ([word isEqualToString:queryWord]) {
        [self doQueryEnd:false];
        return;
    }
    pageNumber = 0;
    queryWord = word;
    [novelList clear];
    novelTotal=0;
    footerView.hidden=true;
    [self.tableView reloadData];
    [self innerQuery:queryWord andPageNumber:pageNumber];
}
- (void)moreNovel
{
    if ([novelList getCount] == novelTotal && novelTotal != 0) {
        self.queryEnd(false);
        return;
    }
    pageNumber++;
    [self innerQuery:queryWord andPageNumber:pageNumber];
}
- (void)innerQuery:(NSString*)word andPageNumber:(NSInteger)pn
{
    NSString* urlStr = [NSString stringWithFormat:SearchNovelUrl, word, pn];

    ASIHTTPRequest* request =
        [ASIHTTPRequest requestWithURL:[urlStr toEncodeURL]];

    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)doQueryEnd:(BOOL)ret
{
    if (queryWord) {
        self.queryEnd(ret);
    }
}
- (void)requestFailed:(ASIHTTPRequest*)request
{
    NSError *error = [request error];
    NSLog(error.localizedFailureReason);
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
    footerView.hidden=false;
    
    novelTotal = res.total;

    NSMutableArray<NSIndexPath*>* paths = [[NSMutableArray new] init];
    NSInteger startIndex = novelList.count;
    [novelList addRange:res.list];
    for (int index = 0; index < res.list.count; index++) {
        NSIndexPath* newPath =
            [NSIndexPath indexPathForRow:startIndex + index inSection:0];
        [paths addObject:newPath];
    }
    [self.tableView insertRowsAtIndexPaths:paths
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
 
    if (novelList.count==novelTotal) {
     
        [footerView endWorkWithNoMore];
    }
    else
    {
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
     cell.labelName.textColor=[UserSetting getIntance].titleColor;
    info.name =  [self replaceTitle: info.name];
  
    NSRange rang= [info.name rangeOfString:queryWord];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:info.name];
    [str addAttribute:NSForegroundColorAttributeName value:[UserSetting getIntance].mainColor range:rang];
    cell.labelName.attributedText=str;
   
    cell.labelAuthor.text = [NSString stringWithFormat:@"%@ | %@ | %@",info.author,info.categoryName,info.status];
    cell.labelAuthor.textColor=[UserSetting getIntance].contentColor;
    cell.labelContent.textColor=[UserSetting getIntance].contentColor;
    cell.labelContent.text = info.summary;
    [cell setBook:info];
    return cell;
}
-(NSString *)replaceTitle:(NSString*)str
{
    str = [str stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    return str;
}
- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    return 90;
}

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    SearchTableCellView *cell=(SearchTableCellView *) [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    if (!self.cellClick) {
        return;
    }
    self.cellClick(cell.book);
}
//可编辑状态
- (BOOL)tableView:(UITableView*)tableView
    canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return NO;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(novelList.count==0)
    {
        return nil;
    }
    
    
    LoadMoreTableViewCell *tempCell =(LoadMoreTableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:LoadingTableCellIdentifer];
    if(!tempCell)
    {
        [tableView registerClass:[LoadMoreTableViewCell class] forHeaderFooterViewReuseIdentifier:LoadingTableCellIdentifer];
        tempCell =(LoadMoreTableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:LoadingTableCellIdentifer];
        CGSize size=CGSizeMake(tableView.frame.size.width, 40);
        [tempCell initSubViews:size];
        tempCell.delegate=self;
    }
    footerView=tempCell;
   /*  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,40)];
   [view setBackgroundColor:[UserSetting getIntance].mainColor];
   UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setTitle:@"加载更多..." forState:UIControlStateNormal];
    [btn setTitleColor:[UserSetting getIntance].titleColor forState:UIControlStateNormal];
    btn.font=[UIFont systemFontOfSize: [UserSetting getIntance].headerFontSize];
    btn.frame=CGRectMake(0, 0 ,tableView.frame.size.width, 40);
    [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    footerBtn=btn;
    footerView=view;
    footerView.hidden=true;*;*/

   
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


-(void)loadMore
{
    if(novelTotal!=novelList.count)
    {
        [self moreNovel];
        [footerView showWork];
    }
}

-(void)dealloc
{
    self.queryEnd=nil;
    self.tableView=nil;
    [novelList clear];
    novelList=nil;
    self.cellClick=nil;
    NSLog(@"query dealloc");
}


@end
