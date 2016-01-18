//
//  BookDetailInfo.h
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapterInfo.h"
@interface BookDetailInfo : NSObject
@property (nonatomic) ChapterInfo* lastChapter;
@property (nonatomic) NSString *keyWords;
@end
