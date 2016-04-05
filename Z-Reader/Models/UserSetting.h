//
//  UserSetting.h
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LKDBHelper.h"
#import "NSString+Z.h"
#import "BaseSetting.h"
@interface UserSetting : NSObject
@property(nonatomic) UIColor *mainColor;
@property(nonatomic) UIColor *backColor;
@property(nonatomic) UIColor *headerColor;
@property(nonatomic) UIColor *titleColor;
@property(nonatomic) UIColor *contentColor;
@property(nonatomic) NSInteger headerFontSize;
@property(nonatomic) NSInteger titleFontSize;
@property(nonatomic) NSInteger contentFontSize;
@property(nonatomic) BOOL isNightMode;
@property(nonatomic) NSString* theme;
@property(nonatomic) NSInteger * readColor;
@property(nonatomic) NSInteger * readSize;
@property(nonatomic) NSInteger * downCount;
+(UserSetting *)getIntance;
+(void)save;
+(NSString*) imgPathWithName:(NSString *)name ofType:(NSString* __nullable)ext;
+(UIImage*) imgWithName:(NSString *)name ofType:(NSString* __nullable)ext;

+(UIImageView*) imgViewWithName:(NSString *)name ofType:(NSString* __nullable)ext;

+(UIImage*) imgWithName:(NSString *)name;
+(UIImageView*) imgViewWithName:(NSString *)name;
 
@end
