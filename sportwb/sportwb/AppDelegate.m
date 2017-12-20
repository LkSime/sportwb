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
#import "LKLoginViewController.h"
#import <XHLaunchAd/XHLaunchAd.h>

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.navRoot = [UINavigationController new];
    self.navRoot.view.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    self.window.rootViewController = self.navRoot;
    [self.window makeKeyAndVisible];
    
    [self applicationLaunchAd];
    [self applicationDisguise];
    
    return YES;
}

//应用伪装开光:返回
- (void)applicationDisguise {
    __weak __typeof(self) weakSelf = self;
    [[LKSystemInfoApi shareInstance] getApplictionDisguiseWithSuccessBlock:^(LKSystemBaseModel *model) {
        if (model.appSwitch == 1) {
//            [weakSelf createDefaultView];
            [weakSelf createTrueView:model.switchUrl];
        } else {
            [weakSelf createDefaultView];
        }
    } failure:^(NSString *errMsg, NSInteger errCode) {
        NSLog(errMsg, errCode);
        [weakSelf createDefaultView];
    }];
    

}

//创建webviewcontroller
- (void)createTrueView:(NSString *)sURL {
    LKWebTrueViewController * webVC = [LKWebTrueViewController new];
    webVC.title = @"首页";
    webVC.webURL = sURL;


    
    [UIUtils pushVC:webVC];
}

//创建常规界面
- (void)createDefaultView {
    NSMutableDictionary *_mdictData = [[NSMutableDictionary alloc] init];
    [_mdictData setObject:@"123456" forKey:@"18515991874"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_FILE];
    [_mdictData writeToFile:filePath atomically:YES];
    
    LKLoginViewController * loginVC = [LKLoginViewController new];
    loginVC.isLaunch = YES;
    _navRoot.navigationBarHidden = YES;
    [_navRoot pushViewController:loginVC animated:YES];
    
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

- (void)applicationLaunchAd {
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    XHLaunchImageAdConfiguration * imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    imageAdconfiguration.imageNameOrURLString = @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg";
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    imageAdconfiguration.duration = 2;
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

@end
