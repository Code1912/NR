//
//  BookrackCell.m
//  Z-Reader
//
//  Created by Code on 16/1/13.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookrackCell.h"
@interface BookrackCell()

@property bool isImgLoaded;
@end
@implementation BookrackCell

- (void)awakeFromNib {
    // Initialization code
    [self configTheme];
}

-(void)setBookInfo:(NovelInfo *)book
{
    self. isImgLoaded=true;
    self.bookNameLabel.text=book.name;
    NSString * key=[[NSNumber numberWithLong:book.bookId] stringValue];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    if(cachedImage)
    {
        self.logoImgView.image=nil;
        self.logoImgView.image=cachedImage;
        return;
    }
   // NSLog(book.imgUrl);
    [self.logoImgView sd_setImageWithURL:[book.imgUrl toURL] placeholderImage:[UIImage imageNamed:@"noimg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         if(!error)
         {
            [[SDImageCache sharedImageCache] storeImage:self.logoImgView.image forKey:key];
         }
         if(error)
         {
             [self.logoImgView setImage:[UserSetting imgWithName:@"noimg"]];
         }
        
    }];
   
}
-(void)configTheme
{
    self.bookNameLabel.textColor=[UserSetting getIntance].titleColor;
    
}
@end
