//
//  LKLoginViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/12.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKLoginViewController.h"
#import "LKWebTrueViewController.h"
#import "LKHomeViewController.h"
#import "LKNewsViewController.h"
#import "LKMineViewController.h"

@interface LKLoginViewController ()<UITabBarControllerDelegate>

@end

@implementation LKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}

- (void)createView {
    
    UITabBarController * tabBarController = [UITabBarController new];
    tabBarController.delegate = self;
    
    LKHomeViewController * homeVC = [LKHomeViewController new];
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    //    homeNC.navigationBarHidden = YES;
    LKNewsViewController * newsVC = [LKNewsViewController new];
    UINavigationController * newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    newsVC.title = @"资讯";
    //    newsNC.navigationBarHidden = YES;
    LKMineViewController * mineVC = [LKMineViewController new];
    UINavigationController * mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.title = @"我的";
    //    mineNC.navigationBarHidden = YES;
    
    tabBarController.viewControllers = [NSMutableArray arrayWithObjects:homeNC, newsNC, mineNC, nil];
    tabBarController.tabBar.tintColor = NAV_COLOR;
    
    [RootNaviControllerUtil pushViewController:tabBarController animated:YES];
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
