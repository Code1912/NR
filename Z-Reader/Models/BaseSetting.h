//
//  BaseSetting.h
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//pn=x; x=1、2、3、4
static  NSString* const _Nonnull  GetHotWordUrl=@"http://dushu.baidu.com/ajax/search?pn=%d";
//word=%@  word=要查询的关键字  pn=pageNumber
static   NSString* const _Nonnull   SearchNovelUrl=@"http://dushu.baidu.com/ajax/searchresult?word=%@&pn=%d";

//http://m.baidu.com/tc?srd=1&appui=alaxs&ajax=4&id=wisenovel&pi=2&order=asc&gid=1786047843
// pi=%d 表示页数  gid=%ld 小说的id
static   NSString* const _Nonnull   GetChapterListUrl=@"http://m.baidu.com/tc?srd=1&appui=alaxs&ajax=4&id=wisenovel&pi=%d&order=asc&gid=%ld";

//http://m.baidu.com/tc?srd=1&appui=alaxs&ajax=1&gid=1786047843&alals=1&preNum=1&preLoad=true&src=http%3A%2F%2Fwww.bxwx.org%2Fb%2F118%2F118806%2F20957696.html&cid=1786047843%7C17722447306943420439&time=&skey=&id=wisenovel
//gid=小说id（long） src=章节url   cid=章节的cid
static   NSString* const _Nonnull   GetChapterContentUrl=@"http://m.baidu.com/tc?srd=1&appui=alaxs&ajax=1&gid=%ld&alals=1&preNum=1&preLoad=true&src=%@&cid=%@&time=&skey=&id=wisenovel";

static  NSString * const _Nonnull cellReuseIdentifier=@"ZReaderCell";
static  NSString * const _Nonnull  headerReuseIdentifier=@"Header";
static NSString * const _Nonnull ThemeNotifier=@"ThemeNotifier";
static NSString * const _Nonnull LoadingTableCellIdentifer=@"LoadMoreTableViewCell";

static NSString * const _Nonnull AddBookNotifier=@"AddBookNotifier";

