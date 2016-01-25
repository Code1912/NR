//
//  SearchViewController.h
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"
#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "LoadingView.h"
#import "BaseViewController.h"
#import "SearchTableCellView.h"
#import "LoadMoreTableViewCell.h"
#import "BookDetailViewController.h"
@interface SearchViewController :BaseViewController<UITableViewDataSource,UITableViewDelegate,LoadMoreDelegate>
{
    UIButton *btnBack;
    UIButton *btnSearch;
    UITextField *txtSearch;
    List<NovelInfo*> *novelList;
    NSInteger pageNumber; 
    NSInteger novelTotal;
    LoadMoreTableViewCell *footerView;
    NSString *queryWord; 
}
@property (weak, nonatomic) IBOutlet UITableView *novelListTableView;

@property (strong, nonatomic) IBOutlet UIView *rootView;

- (IBAction)btnSearch_Click:(id)sender;
- (IBAction)backBtn_Click:(id)sender;
 
@end
