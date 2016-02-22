//
//  ChapterViewCell.m
//  Z-Reader
//
//  Created by Code on 16/1/18.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ChapterViewCell.h"
#import "UtilityDefine.h"
@implementation ChapterViewCell
-(void)awakeFromNib
{
    self.chapterLabel.textColor=[UserSetting getIntance].titleColor;
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor =MakeUIColor(96,96,96,0.5);
}
@end
