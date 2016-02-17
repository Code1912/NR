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
#import "BookDetailResponse.h"
#import "CJSONDeserializer.h" 
#import "NSDictionary_JSONExtensions.h"
#import "LoadMoreTableViewCell.h"
#import "ChapterViewCell.h"
#import "ChapterListResponse.h"
#import "ChapterListViewController.h"
@interface BookDetailViewController : BaseViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,LoadMoreDelegate> {
    UIButton *btnBack;
    ChapterListResponse *chapterListInfo;
    UIView *tableHeader;
    UIView *tableFooter;
}


@property (strong, nonatomic) IBOutlet UIView *root;
- (IBAction)btnBackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bookImgView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (nonatomic)NovelInfo *book;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToBookrack;
@property (weak, nonatomic) IBOutlet UIButton *btnStartRead;
@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *bookInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *line2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
 

@end
