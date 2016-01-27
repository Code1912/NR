//
//  UITableView+Z.m
//  ZReader
//
//  Created by Code on 16/1/7.
//  Copyright © 2016年 Code. All rights reserved.
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
-(void) addNewRow:(List *)oldSource withNewRows:(List *)newSource
{
    NSMutableArray<NSIndexPath*>* paths = [[NSMutableArray new] init];
    NSInteger startIndex = oldSource.count;
    [oldSource addRange:newSource];
    for (int index = 0; index < newSource.count; index++) {
        NSIndexPath* newPath =
        [NSIndexPath indexPathForRow:startIndex + index inSection:0];
        [paths addObject:newPath];
    }
    [self insertRowsAtIndexPaths:paths
                               withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}
@end
