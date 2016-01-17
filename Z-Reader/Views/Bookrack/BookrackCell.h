//
//  BookrackCell.h
//  Z-Reader
//
//  Created by Code on 16/1/13.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NovelInfo.h"
#import "UIImageView+WebCache.h"
#import "CategoryGather.h"
#import "UserSetting.h"
#import "ThemeDelegate.h"
@interface BookrackCell : UICollectionViewCell<ThemeDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
-(void)setBookInfo:(NovelInfo *)book;
@end
