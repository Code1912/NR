//
//  LoadMoreTableViewCell.m
//  Z-Reader
//
//  Created by Code on 16/1/11.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "LoadMoreTableViewCell.h"

@implementation LoadMoreTableViewCell

bool isWording=false;
bool loaded=NO;
-(void)layoutSubviews
{
 
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    return self;
}

-(void)initSubViews:(CGSize)size
{
    self.contentView.frame=CGRectMake(0, 0,  size.width, size.height);
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loadingImgView=[UIImageView new];
    [self.contentView addSubview:self.loadingImgView];
    [self.contentView addSubview:self.btn];
    
    self.loadingImgView.hidden=true;
    self.loadingImgView.frame=CGRectMake(0,0, 30, 30);
    self.btn.frame=CGRectMake(0,0, size.width, size.height);
    self.btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.btn addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGPoint point=self.contentView.center; 
    self.loadingImgView.center = CGPointMake(point.x-75, point.y);
   
    [self configTheme];
}
-(void)resetSize:(CGSize)size
{
    self.contentView.frame=CGRectMake(0, 0,  size.width, size.height);
    CGPoint point=self.contentView.center;
    self.loadingImgView.center = CGPointMake(point.x-75, point.y);
    self.btn.frame=CGRectMake(0,0, size.width, size.height);
}
-(void)doClick
{
    if(self.delegate)
    {
        [self.delegate loadMore];
    }
}

-(void) showWork
{
    if(isWording)
    {
        return;
    }
    self.loadingImgView.hidden=false;
    [self.btn setTitle:@"正在召唤..." forState:UIControlStateNormal];
    isWording=true;
}

-(void) endWork
{
    self.loadingImgView.hidden=true;
    [self.btn setTitle:@"召唤更多..." forState:UIControlStateNormal];
    isWording=false;
}

-(void) endWorkWithNoMore
{
    self.loadingImgView.hidden=true;
    [self.btn setTitle:@"没有更多了" forState:UIControlStateNormal];
    isWording=false;
}

-(void)configTheme
{ 
    self.contentView.backgroundColor= [UserSetting getIntance].mainColor;
    [self.btn setTitle:@"召唤更多..." forState:UIControlStateNormal];
    [self.btn setTitleColor:[UserSetting getIntance].titleColor forState:UIControlStateNormal];
    self.btn.backgroundColor=[UIColor clearColor];
    self.btn.font=[UIFont systemFontOfSize: [UserSetting getIntance].headerFontSize];
    NSData *gifImg = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading-small.gif" ofType:Nil inDirectory:@"Theme/Day"]];
    self.loadingImgView.image = [UIImage sd_animatedGIFWithData:gifImg];
}
@end
