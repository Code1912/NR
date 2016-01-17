//
//  LoadingView.m
//  ZReader
//
//  Created by Code on 16/1/4.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(id)init
{
    if (self=[super init]) {
        //加载动画图片
        loadingImageView=[[UIImageView new] init];
        NSData *gifImg = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:Nil inDirectory:@"Theme/Day"]];
        loadingImageView.image = [UIImage sd_animatedGIFWithData:gifImg];
        [loadingImageView setBackgroundColor:[UIColor clearColor]];
        
        //加载 遮罩
        maskView=[[UIView new] init];
        [maskView setBackgroundColor:[UIColor whiteColor]];
        [maskView setAlpha:0.5];
        //加载显示文字
        label=[[UILabel new]init];
        label.text=@"召唤术施法中.......";
        label.backgroundColor=[UIColor clearColor];
        
        self.backgroundColor=[UIColor clearColor];
        self.hidden=true;
        [self addSubview:maskView];
        [self addSubview:loadingImageView];
        [self addSubview:label];
        
    }
    return self;
}

-(void)layoutSubviews{
    if(self.superview)
    {
        CGSize size=  self.superview.frame.size;
        self.frame=CGRectMake(0, 0, size.width, size.height);
        
        maskView.frame=CGRectMake(0, 0, size.width, size.height);
        loadingImageView.frame=CGRectMake(size.width/2-100, size.height/2-100, 200, 200);
        label.frame= CGRectMake((size.width-100)/2, (size.height+20)/2, 100, 50);
    }
    
    /*
    [super layoutSubviews];
    UIDeviceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //翻转为竖屏时
        [self setVerticalFrame];
    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation == UIDeviceOrientationLandscapeRight) {
        //翻转为横屏时
        [self setHorizontalFrame];
    }*/
   
}

-(void)showWithText:(NSString*)text
{
    label.text=text;
    [self show];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)show
{
    self.hidden=false;
}
-(void)hide
{
     self.hidden=true;
}
@end
