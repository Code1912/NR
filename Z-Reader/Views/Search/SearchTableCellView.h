//
//  SearchTableCellView.h
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import "UserSetting.h"
#import "NovelInfo.h"
@interface SearchTableCellView : UITableViewCell
 
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
@property (strong, nonatomic) NovelInfo* book;
 

@end

@protocol SearchTableCellDelegate <NSObject>


@end
