//
//  SearchListViewModel.h
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CategoryGather.h"
#import "UIImage+Z.h"
#import "WordEntity.h"
#import "ASIHTTPRequestDelegate.h"
#import "BaseSetting.h"
#import "ASIHTTPRequest.h"
#import "SearchNovelResponse.h"
#import "NovelInfo.h"
#import "CategoryGather.h"
#import "UIImageView+WebCache.h"
#import "SearchTableCellView.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreTableViewCell.h"

@interface SearchListViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>
{
    List<NovelInfo*> *novelList;
    NSInteger pageNumber;
    NSString* queryWord;
    NSInteger novelTotal;
}
-(void) doQuery:(NSString* __nullable )word ;
@property(nonatomic, copy,nullable) void (^ queryEnd)(BOOL ret);
@property(nonatomic, weak,nullable) UITableView* tableView;
@property(nonatomic, copy,nullable) void (^ cellClick)(NovelInfo* book);
@end
 