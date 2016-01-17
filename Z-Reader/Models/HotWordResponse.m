//
//  HotWordResponse.m
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import "HotWordResponse.h"

@implementation HotWordResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"hotWord" : [NSString class] };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"hotWord" : @"hotword"};
}
@end
