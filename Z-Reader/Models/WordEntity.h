//
//  WordEntity.h
//  ZReader
//
//  Created by Code on 16/1/3.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LKDBHelper.h"
@interface WordEntity : NSObject
@property (nonatomic,strong,nullable) NSString *word;
@property (nonatomic) NSInteger sortId;
@property (nonatomic) NSInteger wordType;
@property (nonatomic,nullable) NSDate *dateTime;
@property (nonatomic,nullable) NSString *memo;
+(WordEntity *_Nonnull)initWithWord:(NSString * __nullable)word andSortId:(NSInteger)sortId;
 
@end
