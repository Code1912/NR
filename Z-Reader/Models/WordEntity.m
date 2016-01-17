//
//  WordEntity.m
//  ZReader
//
//  Created by 曾超 on 16/1/3.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import "WordEntity.h"
 
@implementation WordEntity

-(id)init
{
    if (self=[super init]) {
        self.wordType=0;
    }
    return self;
}

+(WordEntity *)initWithWord:(NSString *)word andSortId:(NSInteger  )sortId
{
    WordEntity* entity=  [[WordEntity new] init];
 
    [entity setWord:word];
    [entity setSortId: sortId];
    [entity setDateTime:[NSDate date]];
 
    return entity;
}

+(NSString *)getTableName
{
    return @"WordEntity";
}
@end
