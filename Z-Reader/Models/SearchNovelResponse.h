//
//  QueryNovelResponse.h
//  ZReader
//
//  Created by Code on 16/1/4.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelInfo.h"
#import "YYModel.h"
@interface SearchNovelResponse : NSObject
@property  NSInteger total;
@property NSMutableArray<NovelInfo*> *list;
@property NSString* key;
@end
