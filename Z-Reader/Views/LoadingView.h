//
//  LoadingView.h
//  ZReader
//
//  Created by 曾超 on 16/1/4.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
@interface LoadingView : UIView
{
    UIView* maskView;
    UIImageView *loadingImageView;
    UILabel *label;
}
-(void)show;
-(void)showWithText:(NSString*)text;
-(void)hide;
@end
