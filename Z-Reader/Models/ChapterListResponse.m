//
//  ChapterListResponse.m
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ChapterListResponse.h"

@implementation ChapterListResponse

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"list" : @"data.group",
             @"chapter_count" : @"data.chapter_count",
             @"chapter_all_count" : @"data.chapter_all_count",
             @"page_count" : @"data.page_count",
             @"current_page" : @"data.current_page",
             @"page_size" : @"data.page_size",
             @"has_more" : @"data.has_more",
             @"status" : @"data."};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ChapterInfo class]};
}
@end
