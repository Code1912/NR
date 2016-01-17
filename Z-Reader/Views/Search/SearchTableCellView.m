//
//  SearchTableCellView.m
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "SearchTableCellView.h"
#import "BookManager.h"
@implementation SearchTableCellView


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       
    }
    return self;
}

-(void)setBook:(NovelInfo *)book
{
    BOOL isExists=[BookManager isExists:book];
    [self setBtnImg:!isExists];
    _book=book;
}

-(void)setBtnImg:(BOOL)isAdd
{
    UIImage *img=[UserSetting imgWithName:isAdd?@"add":@"ok"];
    [self.btnStatus setBackgroundImage:img forState:UIControlStateNormal];
    self.btnStatus.tag=isAdd?1:0;
    [self.btnStatus addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick:(UIButton *) sender
{
    if (self.btnStatus.tag==1)
    {
        [BookManager addBook:_book];
         [self setBtnImg:false];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ Clicked",_book.name);
}
@end
