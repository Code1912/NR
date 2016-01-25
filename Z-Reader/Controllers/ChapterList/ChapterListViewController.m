//
//  ChapterListViewController.m
//  Z-Reader
//
//  Created by Code on 16/1/25.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "ChapterListViewController.h"

@interface ChapterListViewController ()

@end
List<ChapterInfo*>  *list;
@implementation ChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    list=ListNew;
    
   [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UserSetting imgWithName:@"readback"]];
  
    this.tableView.backgroundView=view;
    this.tableView.backgroundColor = [UIColor clearColor];
    this.tableView.opaque = NO;
    this.tableView.delegate=this;
    this.tableView.dataSource=this;
    [this.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
 
 

}

- (void)btnBack_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *cell=[[UITableViewHeaderFooterView new] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
  
 
    if(cell.contentView.subviews.count==0)
    {
        [cell setTintColor:[UIColor greenColor]];
        //cell.backgroundColor=[UIColor clearColor];
     
        cell.contentView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
        cell.contentView.backgroundColor=[UIColor greenColor];
        cell=[[UITableViewHeaderFooterView new]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        UIButton   *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell.contentView    addSubview:btnBack];
        btnBack.frame = CGRectMake(0, 0, 25, 25);
        [btnBack setBackgroundImage:[UserSetting imgWithName:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack_Click) forControlEvents:UIControlEventTouchUpInside];
        
        cell.backgroundView=[[UIView new]init];
        cell.backgroundView.backgroundColor=[[UIColor new]initWithRed:0 green:0 blue:0 alpha:0];
    }
    //cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
    return  cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    if(!cell)
    {
       // cell=[[UITableViewHeaderFooterView new]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    }
    //cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
