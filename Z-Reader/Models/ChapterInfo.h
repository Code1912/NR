//
//  ChapterInfo.h
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChapterInfo : NSObject
@property(nonatomic) NSString* cid;
@property(nonatomic) NSInteger* index;
@property(nonatomic,strong) NSString* text;
@property(nonatomic) NSString* href;
@property(nonatomic) NSDate* update_time;
@end
