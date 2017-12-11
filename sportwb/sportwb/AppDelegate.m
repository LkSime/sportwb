//
//  AppDelegate.m
//  sportwb
//
//  Created by Mahalo on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "AppDelegate.h"
#import "LKSystemInfoApi.h"
#import "LKSystemModel.h"
#import "LKNewsApi.h"   //测试用
#import "LKNewsModel.h" //测试用
#import "LKWebTrueViewController.h"
#import "LKHomeViewController.h"
#import "LKNewsViewController.h"
#import "LKMineViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self applicationDisguise];
    
    return YES;
}

//应用伪装开光:返回
- (void)applicationDisguise {
    __weak __typeof(self) weakSelf = self;
    [[LKSystemInfoApi shareInstance] getApplictionDisguiseWithSuccessBlock:^(LKSystemBaseModel *model) {
        [weakSelf createDefaultView];
//        [weakSelf createTrueView:model.switchUrl];
    } failure:^(NSString *errMsg, NSInteger errCode) {
        NSLog(errMsg, errCode);
        [weakSelf createDefaultView];
    }];
    
//    [[LKNewsApi shareInstance] getSocialOfNewsIndex:1 page_size:10 withSuccessBlock:^(NSArray *mArray) {
//        NSArray * aaa = mArray;
//        NSLog(@"%@", aaa);
//    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
//
//    }];
}

//创建webviewcontroller
- (void)createTrueView:(NSString *)sURL {
    LKWebTrueViewController * webVC = [LKWebTrueViewController new];
    webVC.webTitle = @"xxx";
    webVC.webURL = sURL;
    self.rootNavigation = [[UINavigationController alloc] init];

    self.window.rootViewController = self.rootNavigation;
    [self.window makeKeyAndVisible];
    [RootNaviControllerUtil pushViewController:webVC animated:YES];
}

//创建常规界面
- (void)createDefaultView {
    UITabBarController * tabBarController = [UITabBarController new];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    
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
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
