//
//  BookDetailResponse.m
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookDetailResponse.h"
 
@implementation BookDetailResponse
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"data" : @"data",
             @"status" : @"status"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
        return @{@"data" : [BookDetailInfo class]};
}
@end
