//
//  KeyWordViewController.h
//  Z-Reader
//
//  Created by Code on 16/1/14.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "KeyWordViewCell.h"
@interface KeyWordViewController : BaseViewController<ASIHTTPRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *rootView;

@end
