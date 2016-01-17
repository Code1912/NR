//
//  NovelInfo.h
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface NovelInfo : NSObject
@property (nonatomic)   NSString* author;
@property (nonatomic)    NSString* categoryName;
@property (nonatomic)    NSString* imgUrl;
@property   long bookId;
@property (nonatomic)    NSString* status;
@property (nonatomic)   NSString* summary;
@property (nonatomic)   NSString* name;
@property (nonatomic)   NSInteger booktype;
@property (nonatomic)  NSString* url;
@property  BOOL isInBookRack;
@property(nonatomic) NSDate *addTime;
@property (nonatomic) NSDate *editTime;
@end
