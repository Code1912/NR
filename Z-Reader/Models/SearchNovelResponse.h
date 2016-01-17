//
//  QueryNovelResponse.h
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelInfo.h"
#import "YYModel.h"
@interface SearchNovelResponse : NSObject
@property  NSInteger total;
@property NSMutableArray<NovelInfo*> *list;
@property NSString* key;
@end
