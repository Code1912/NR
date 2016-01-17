//
//  UITableView+Z.m
//  ZReader
//
//  Created by 曾超 on 16/1/7.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import "UITableView+Z.h"

@implementation UITableView(Z)
-(void)registerNibClass:(Class)cellClass withCellIdentifier:(NSString *)identifier
{
    UINib *nib=  [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self  registerNib:nib forCellReuseIdentifier:identifier];
}
 -(void)registerNibClass:(Class)cellClass withHeaderFooterIdentifier:(NSString *)identifier
{
    UINib *nib=  [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self  registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
}
@end
