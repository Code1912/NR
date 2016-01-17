//
//  UITableView+Z.h
//  ZReader
//
//  Created by Code on 16/1/7.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UITableView(Z)
-(void)registerNibClass:(Class)cellClass withCellIdentifier:(NSString *)identifier;
-(void)registerNibClass:(Class)cellClass withHeaderFooterIdentifier:(NSString *)identifier;
@end
