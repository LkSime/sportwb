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
#import "AppDelegate.h"
#import "MMDrawerController.h"

@interface LKLoginViewController ()<UITabBarControllerDelegate> {
    MMDrawerController          *_drawerController;

}

@end

@implementation LKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self createView];
}

- (void)createView {
    
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.mtabBarController = tabBarController;
    
    LKHomeViewController * homeVC = [LKHomeViewController new];
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"首页";
//        homeNC.navigationBarHidden = YES;
    LKNewsViewController * newsVC = [LKNewsViewController new];
    UINavigationController * newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    newsVC.title = @"资讯";
//        newsNC.navigationBarHidden = YES;
    LKMineViewController * mineVC = [LKMineViewController new];
    UINavigationController * mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
//    mineVC.title = @"我的";
        mineNC.navigationBarHidden = YES;
    
    tabBarController.viewControllers = [NSMutableArray arrayWithObjects:homeNC, newsNC, mineNC, nil];
    tabBarController.tabBar.tintColor = NAV_COLOR;
    
    [tabBarController setSelectedIndex:0];
    
    _drawerController = [[MMDrawerController alloc]
                         initWithCenterViewController:tabBarController
                         leftDrawerViewController:nil];
    
    [_drawerController setRestorationIdentifier:@"MMDrawer"];
    [_drawerController setMaximumLeftDrawerWidth:260.0f];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.navigationController pushViewController:_drawerController animated:YES];

}
#pragma mark - TabbarController Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    BOOL ret = YES;
    return ret;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
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
