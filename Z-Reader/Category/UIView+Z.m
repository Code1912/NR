//
//  UIView+Z.m
//  Z-Reader
//
//  Created by Code on 16/1/17.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "UIView+Z.h"

@implementation UIView(Z)
-(void) setBackground:(UIImage *)img
{
    UIColor *bgColor = [UIColor colorWithPatternImage: img];
    self.backgroundColor=bgColor;
}
@end
