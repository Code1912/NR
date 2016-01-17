//
//  NovelCellView.h
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
@interface NovelCellView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@end
