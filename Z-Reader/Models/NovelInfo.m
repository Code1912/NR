//
//  NovelInfo.m
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import "NovelInfo.h"

@implementation NovelInfo
-(id)init
{
    if (self=[super init]) {
        _addTime=[NSDate new];
        _editTime=[NSDate new];
    }
    return self;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"author" : @"author"
             ,@"categoryName" : @"category_name"
             ,@"imgUrl" : @"logo"
             ,@"bookId" : @"book_id"
             ,@"status" : @"book_status"
             ,@"summary" : @"summary"
             ,@"name" : @"book_name"
             ,@"booktype" : @"book_type"
             ,@"url" : @"src"};
}
+(void)dbDidInserted:(NSObject*)entity result:(BOOL)result
{
    if (result) {
      
    }
}
@end
