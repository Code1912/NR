//
//  ChapterInfo.m
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ChapterInfo.h"

@implementation ChapterInfo

 
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *timestamp = dic[@"update_time"];
    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
    _update_time = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
    return YES;
}
@end
