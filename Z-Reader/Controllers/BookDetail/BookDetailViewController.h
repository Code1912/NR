//
//  BookDetailViewController.h
//  Z-Reader
//
//  Created by Code on 16/1/12.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UserSetting.h"

@interface BookDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) IBOutlet UIView *root;
- (IBAction)btnBackClick:(id)sender;

@end
