//
//  BookRackViewController.h
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "BaseSetting.h"
#import "BaseViewController.h"
#import "BookManager.h"
#import "BookrackCell.h"
#import "NovelInfo.h"
#import "UICollectionView+Z.h"
#import <UIKit/UIKit.h>
@interface BookrackViewController : BaseViewController <ASIHTTPRequestDelegate, UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    UIButton* btnSearch;
}
- (IBAction)searchBtn_Click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView* rootView;

@property (weak, nonatomic) IBOutlet UICollectionView* bookListView;

@end
