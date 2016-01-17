//
//  BookRackViewController.h
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NovelInfo.h"
#import "ASIHTTPRequest.h"
#import "UICollectionView+Z.h"
#import "BookrackCell.h"
#import "BaseSetting.h"
#import "BookManager.h"
@interface BookrackViewController : BaseViewController<ASIHTTPRequestDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIButton *btnSearch;
}
- (IBAction)searchBtn_Click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *rootView;

@property (weak, nonatomic) IBOutlet UICollectionView *bookListView;
 

@end
