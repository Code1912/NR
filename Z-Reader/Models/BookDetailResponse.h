//
//  BookDetailResponse.h
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapterInfo.h"
#import "UtilityDefine.h"
#import "BookDetailInfo.h"
@interface BookDetailResponse :NSObject

@property (nonatomic) NSInteger status;
@property (nonatomic) BookDetailInfo *data;
@end
