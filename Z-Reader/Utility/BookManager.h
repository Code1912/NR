//
//  BookManager.h
//  Z-Reader
//
//  Created by Code on 16/1/12.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelInfo.h"
#import "CategoryGather.h"
#import "BaseSetting.h"
@interface BookManager : NSObject

+(BOOL)addBook:(NovelInfo*)book;
+(BOOL)removeBook:(NovelInfo*)book;
+(BOOL) isExists:(NovelInfo *)book;
+(List<NovelInfo *> *) getBooks;
+(void)setQueryWord:(NSString *)word;
+(NSString *)getQueryWord;
@end
