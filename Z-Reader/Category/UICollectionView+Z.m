//
//  UICollectionView+Z.m
//  Z-Reader
//
//  Created by Code on 16/1/13.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "UICollectionView+Z.h"

@implementation UICollectionView(Z)
-(void)registerNibClass:(Class)cellClass withCellIdentifier:(NSString *)identifier
{
    UINib *nib=  [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self  registerNib:nib forCellWithReuseIdentifier:identifier ];
}

-(void)registerNibClass:(Class)cellClass withHeaderIdentifier:(NSString *)identifier;
{
    UINib *nib=  [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self  registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier ];
}
@end
