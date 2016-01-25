//
//  ChapterListViewController.h
//  Z-Reader
//
//  Created by Code on 16/1/25.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ChapterListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

 

@end
