//
//  ChapterListResponse.h
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapterInfo.h"
#import "UtilityDefine.h"
#import "NSMutableArray+Z.h"
@interface ChapterListResponse : NSObject
@property (nonatomic,strong) List<ChapterInfo *> *list;
@property (nonatomic) NSInteger chapter_count;
@property (nonatomic) NSInteger chapter_all_count;
@property (nonatomic) NSInteger page_count;
@property (nonatomic) NSInteger current_page;
@property (nonatomic) NSInteger page_size;
@property (nonatomic) BOOL has_more;
@end
