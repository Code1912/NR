//
//  BookRackViewController.m
//  ZReader
//
//  Created by Code on 16/1/2.
//  Copyright © 2016年 Code. All rights reserved.
//

#import "BookrackViewController.h"
#import "UINavigationBar+Z.h"
@interface BookrackViewController ()

@end

@implementation BookrackViewController

- (void)viewDidLoad
{
    btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0, 0, 30, 30);
    [btnSearch addTarget:self action:@selector(searchBtn_Click:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray<UIBarButtonItem*>* btnArray = [[NSMutableArray new] init];
    [btnArray addObject:[[UIBarButtonItem new] initWithCustomView:btnSearch]];
    this.navigationItem.rightBarButtonItems = [btnArray copy];
    this.navigationItem.title = @"我的书架";
    [self.bookListView registerNibClass:[BookrackCell class] withCellIdentifier:cellReuseIdentifier];
    self.bookListView.delegate = self;
    self.bookListView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBook) name:AddBookNotifier object:nil];

    [super viewDidLoad];
}
- (void)addBook
{
    [self.bookListView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [BookManager getBooks].count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // NSLog(@"%d",indexPath.row);
    BookrackCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    [cell setBookInfo:[[BookManager getBooks] getByIndex:indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{

    return CGSizeMake(90, 180);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchBtn_Click:(id)sender
{
    //[self performSegueWithIdentifier:@"bookRackToSearch" sender:nil];
    if (self.navigationController.visibleViewController == self) {
        [self performSegueWithIdentifier:@"ToKeyWordView" sender:self];
    }
}
- (void)configTheme
{
    self.rootView.backgroundColor = [UserSetting getIntance].backColor;
    [self.rootView setBackgroundColor:[UserSetting getIntance].backColor];
    [btnSearch setBackgroundImage:[UserSetting imgWithName:@"search"] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setBackgroundImage:[UserSetting imgWithName:@"search"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
}
- (void)dealloc
{
    NSLog(@"index dealloc");
}
@end
