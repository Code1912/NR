//
//  NSMutableArray+Z.m
//  Z-Reader
//
//  Created by Code on 16/1/15.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "NSMutableArray+Z.h"

@implementation NSMutableArray(Z)

- (id)findItem:(findBlock)findCondition
{
    for (id item in self) {
        if (findCondition(item)) {
            return item;
        }
    }
    return  nil;
}

-(BOOL) isExsits:(BOOL(^)(id item)) block
{
    for (id item in self)
    {
        if (block(item)) {
            return true;
        }
    } 
    return false;
}

- (List<id>*)findItems:(findBlock)findCondition
{
    NSMutableArray  *tempArray= [[NSMutableArray new] init];
    for (id item in self) {
        if (findCondition(item)) {
            [tempArray addObject:item];
        }
    }
    return  [[List new]initWithArray:tempArray];
}

- (List<id>*)getItemsByIndex:(NSInteger)index andCount:(NSInteger)count
{
    List<id> *list= [[List new]init];
    if(index>self.count)
    {
        [NSException raise:@"argument error" format:@"index is bigger than list count ,index:%ld", (long)index];
    }
    if(index+count>self.count)
    {
        [NSException raise:@"argument error" format:@"(index+count) is bigger than list count ,index:%ld  count:%ld", (long)index,(long)count];
    }
    for (NSInteger i=0; i<count; i++) {
        
        [list add:[self objectAtIndex:i+index]];
    }
    return list;
}

-(void) add:(id) item
{
    [self addObject:item];
}

-(void) remove:(id)item
{
    [self removeObject:item];
}
-(void) removeAtIndex:(NSInteger) index
{
    [self removeObjectAtIndex:index];
}

-(id) getByIndex:(NSInteger) index
{
    if (index<self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

-(void) clear
{
    [self removeAllObjects];
}


-(void) addRange:(NSMutableArray<id> *) arraySource
{
    if(arraySource!=nil)
    {
        [self addObjectsFromArray:arraySource];
    }
}

- (void)each:(void(^)(id item))eachBlock
{
    for (id entity in self) {
        eachBlock(entity)  ;
    }
}
- (void)eachWithIndex:(void(^)(id item,NSInteger index)) eachBlock
{
    NSInteger index=0;
    for (id entity in self) {
        eachBlock(entity,index)  ;
        index++;
    }
}

-(void) insert:(id)item atIndex:(NSInteger)index
{
    [self insertObject:item atIndex:index];
}
@end
