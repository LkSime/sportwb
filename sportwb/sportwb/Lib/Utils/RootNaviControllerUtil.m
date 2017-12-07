//
//  RootNaviControllerUtil.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "RootNaviControllerUtil.h"
#import "AppDelegate.h"

@implementation RootNaviControllerUtil

+(UINavigationController *)getRootNavigation{
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).rootNavigation;
}

+(void)pushViewController:(UIViewController *)vc animated:(BOOL)animated{
    [[RootNaviControllerUtil getRootNavigation] pushViewController:vc animated:animated];
}

+(void)popViewControllerAnimated:(BOOL)animated{
    [[RootNaviControllerUtil getRootNavigation] popViewControllerAnimated:animated];
}

+(void)popToRootViewControllerAnimated:(BOOL)animated{
    [[RootNaviControllerUtil getRootNavigation] popToRootViewControllerAnimated:animated];
}

+(UIViewController *)topViewController{
    return [[RootNaviControllerUtil getRootNavigation] topViewController];
}
@end
