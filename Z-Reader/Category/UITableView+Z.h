//
//  UITableView+Z.h
//  ZReader
//
//  Created by 曾超 on 16/1/7.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UITableView(Z)
-(void)registerNibClass:(Class)cellClass withCellIdentifier:(NSString *)identifier;
-(void)registerNibClass:(Class)cellClass withHeaderFooterIdentifier:(NSString *)identifier;
@end
