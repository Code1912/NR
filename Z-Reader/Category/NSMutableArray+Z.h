//
//  NSMutableArray+Z.h
//  Z-Reader
//
//  Created by Code on 16/1/15.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef List
#define List NSMutableArray
#endif

#ifndef ListNew
#define ListNew [[NSMutableArray new] init]
#endif
@interface NSMutableArray<T> (Z)

typedef BOOL(^findBlock)(T item);
typedef void(^forBlock)(T item);

- (T)findItem:(findBlock)findCondition;
- (List<T>*)findItems:(findBlock)findCondition;
- (List<T>*)getItemsByIndex:(NSInteger)index andCount:(NSInteger)count;
- (void)each:(void(^)(T item)) eachBlock;
- (void)eachWithIndex:(void(^)(T item,NSInteger index)) eachBlock;
-(void) add:(T)item;
-(void) remove:(T)item;
-(void) removeAtIndex:(NSInteger) index;
-(NSInteger) getCount;
-(T) getByIndex:(NSInteger) index;
-(void) clear;
-(void) addRange:(NSMutableArray<T> *) arraySource;
-(void) insert:(T)item atIndex:(NSInteger)index;
-(BOOL) isExsits:(BOOL(^)(T item)) block;

@end
