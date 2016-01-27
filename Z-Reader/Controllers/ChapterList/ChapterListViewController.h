//
//  ChapterListViewController.h
//  Z-Reader
//
//  Created by Code on 16/1/25.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ChapterViewCell.h"
@interface ChapterListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
 
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

 @property (nonatomic)NovelInfo *book;
@property (weak, nonatomic) IBOutlet UIButton *donwnBtn;

@end
