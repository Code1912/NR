//
//  BookManager.m
//  Z-Reader
//
//  Created by Code on 16/1/12.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookManager.h"

@interface BookManager(private)
// 请在这里声明私有函数
+(void)checkNovelList;
@end
@implementation BookManager
static List<NovelInfo*> *novelList;
static NSString *queryWord;
+(BOOL) isExists:(NovelInfo *)book
{
    [BookManager checkNovelList];
    NovelInfo* item=[novelList findItem:^BOOL(NovelInfo *p) {
        return p.bookId==book.bookId;
    }];
   
    return item!=nil;
}

+(BOOL)addBook:(NovelInfo*)book
{
    [BookManager checkNovelList];
    if ([self isExists:book]) {
        return YES;
    }
    [novelList insert:book atIndex:0 ];
    [book saveToDB];
    [[NSNotificationCenter defaultCenter] postNotificationName:AddBookNotifier object:nil];
    return YES;
}

+(BOOL)removeBook:(NovelInfo*)book
{
    [BookManager checkNovelList];
    NovelInfo* item=[novelList findItem:^BOOL(NovelInfo *p) {
        return p.bookId==book.bookId;
    }];
    if (!item) {
        return YES;
    }
    [novelList remove:item];
    [item deleteToDB];
    return YES;
}

+(void)checkNovelList
{
    if(novelList)
    {
        return;
    }
    novelList=[[List new]init];
    NSMutableArray<NovelInfo*>* array = [NovelInfo searchWithWhere:nil orderBy:@" addTime desc" offset:0 count:10000];
    if (array) {
        [novelList addRange:array];
       // [novelList each:^(NovelInfo *item) {
        //    [item deleteToDB];
       // }];
    }
}

+(List<NovelInfo *> *) getBooks
{
    [BookManager checkNovelList];
    return novelList;
}

+(void)setQueryWord:(NSString *) word
{
    queryWord=word;
}
+(NSString *)getQueryWord
{
    return  queryWord;
}
@end
