//
//  BookDetailInfo.m
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookDetailInfo.h"
 
@implementation BookDetailInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"keyWords" : @"keyWords",
             @"lastChapter" : @"lastChapter"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"lastChapter" : [ChapterInfo class]};
}
@end
