//
//  BaseControllerViewController.m
//  ZReader
//
//  Created by Code on 16/1/5.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BaseViewController.h"
#import "UserSetting.h"
#import "BaseSetting.h"
 
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UserSetting getIntance].titleColor, NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], NSFontAttributeName,
                                                                     nil]];
    // Do any additional setup after loading the view.
    [self configTheme];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyThemChanged) name:ThemeNotifier object:nil];
   // UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
   // [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0.7]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UserSetting getIntance].mainColor ];
   // UIButton* rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    //  UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
   // self.navigationController.navigationItem.rightBarButtonItem= rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notifyThemChanged{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UserSetting getIntance].mainColor];
    [self configTheme];
}
-(void)configTheme
{
 

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
