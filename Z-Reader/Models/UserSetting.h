//
//  UserSetting.h
//  ZReader
//
//  Created by 曾超 on 16/1/5.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LKDBHelper.h"
#import "NSString+Z.h"
#import "BaseSetting.h"
@interface UserSetting : NSObject
@property(nonatomic) UIColor *mainColor;
@property(nonatomic) UIColor *backColor;
@property(nonatomic) UIColor *titleColor;
@property(nonatomic) UIColor *contentColor;
@property(nonatomic) NSInteger headerFontSize;
@property(nonatomic) NSInteger titleFontSize;
@property(nonatomic) NSInteger contentFontSize;
@property(nonatomic) BOOL isNightMode;
@property(nonatomic) NSString* theme;
+(UserSetting *)getIntance;
+(void)save;
+(NSString*) imgPathWithName:(NSString *)name ofType:(NSString* __nullable)ext;
+(UIImage*) imgWithName:(NSString *)name ofType:(NSString* __nullable)ext;

+(UIImageView*) imgViewWithName:(NSString *)name ofType:(NSString* __nullable)ext;

+(UIImage*) imgWithName:(NSString *)name;
+(UIImageView*) imgViewWithName:(NSString *)name;
 
@end
