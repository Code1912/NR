//
//  BookDetailViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/12.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)configTheme
{
    self.header.backgroundColor=[UserSetting getIntance].mainColor;
    self.root.backgroundColor=[UserSetting getIntance].backColor;
   
    [self.btnBack setBackgroundImage: [UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
}
- (IBAction)btnBackClick:(id)sender {
        [self.navigationController popViewControllerAnimated:YES]; 
}
@end
