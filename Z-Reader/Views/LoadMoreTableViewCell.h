//
//  LoadMoreTableViewCell.h
//  Z-Reader
//
//  Created by Code on 16/1/11.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeDelegate.h"
#import "BaseSetting.h"
#import "UserSetting.h"
#import "UIImage+GIF.h"
@protocol LoadMoreDelegate <NSObject>

-(void)loadMore;

@end
@interface LoadMoreTableViewCell : UITableViewHeaderFooterView 
@property (strong, nonatomic)  UIImageView *loadingImgView;
@property (strong, nonatomic)  UIButton *btn;
@property(nonatomic,weak)id<LoadMoreDelegate> delegate;
-(void) showWork;
-(void) endWork;
-(void) endWorkWithNoMore;
-(void)initSubViews:(CGSize)size;
-(void)resetSize:(CGSize)size;
@end


