//
//  HotWordResponse.m
//  ZReader
//
//  Created by Code on 16/1/4.
//  Copyright © 2016年 Code. All rights reserved.
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
