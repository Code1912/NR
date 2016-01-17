//
//  BaseControllerViewController.h
//  ZReader
//
//  Created by 曾超 on 16/1/5.
//  Copyright © 2016年 zeng3750@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryGather.h"
#import "UserSetting.h"
#import "WordEntity.h"
#import "NovelInfo.h"
#import "ASIHTTPRequestDelegate.h"
#import "BaseSetting.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "LoadingView.h"
#import "HotWordResponse.h"
#import "SearchNovelResponse.h"
#import "BookManager.h"
@interface BaseViewController : UIViewController
{
   
    
}
@property(nonatomic) LoadingView * loadingView;
- (void)configTheme;
@end
