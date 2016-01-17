//
//  UIImage+Z.m
//  ZReader
//
//  Created by Code on 16/1/3.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "UIImage+Z.h"

@implementation UIImage(Z)
- (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width  height:(CGFloat)height
{
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
