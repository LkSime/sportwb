//
//  LKMineViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKMineViewController.h"
#import "OPMyTopView.h"
#import "OPMyBottomView.h"
#import "OPMyBottomViewCell.h"

@interface LKMineViewController () {
    OPMyTopView             * _myTopView;
    OPMyBottomView          * _myBottomView;

}

@end

@implementation LKMineViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage * unselectImage = [UIImage imageNamed:@"tabbar_mine_unselected"];
        UIImage * selectImage = [UIImage imageNamed:@"tabbar_mine_selected"];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我的" image:unselectImage selectedImage:selectImage];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = item;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = [UIColor wisteriaColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];
}
- (void)createView {
//    _scrlView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mmContentView.frame.size.width, self.mmContentView.frame.size.height)];
//    _scrlView.showsVerticalScrollIndicator = NO;
//    [_scrlView setContentSize:CGSizeMake(self.mmContentView.frame.size.width, self.mmContentView.frame.size.height)];
//    [self.mmContentView addSubview:_scrlView];
    
    _myTopView = [[OPMyTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [_myTopView.viewButton addTarget:self action:@selector(pushUserInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myTopView];
    
    _myBottomView = [[OPMyBottomView alloc] initWithFrame:CGRectMake(0, BottomForView(_myTopView) + 10, SCREEN_WIDTH, 500)];
    [self.view addSubview:_myBottomView];
//    [_scrlView setContentSize:CGSizeMake(self.mmContentView.frame.size.width, BottomForView(_myBottomView) + 2)];
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

@end
