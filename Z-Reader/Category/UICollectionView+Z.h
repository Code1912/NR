//
//  UICollectionView+Z.h
//  Z-Reader
//
//  Created by Code on 16/1/13.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UICollectionView(Z)
-(void)registerNibClass:(Class)cellClass withCellIdentifier:(NSString *)identifier;
-(void)registerNibClass:(Class)cellClass withHeaderIdentifier:(NSString *)identifier;
@end
