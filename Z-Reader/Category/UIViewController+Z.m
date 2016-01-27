//
//  UIViewController+Z.m
//  Z-Reader
//
//  Created by Code on 16/1/26.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "UIViewController+Z.h"


@implementation UIViewController(Z)

-(void)alert:(NSString *)msg
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:msg  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertview show];
}
@end