//
//  UINavigationBar+Z.h
//  ZReader
//
//  Created by 曾超 on 16/1/2.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end