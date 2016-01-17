//
//  NovelCellView.m
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "NovelCellView.h"

@implementation NovelCellView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载novelCell.xlib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"NovelCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
