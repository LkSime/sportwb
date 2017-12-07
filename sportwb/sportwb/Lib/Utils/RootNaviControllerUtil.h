//
//  RootNaviControllerUtil.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppDelegate;

@interface RootNaviControllerUtil : NSObject

+(UINavigationController *)getRootNavigation;

+(void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

+(void)popViewControllerAnimated:(BOOL)animated;

+(void)popToRootViewControllerAnimated:(BOOL)animated;

+(UIViewController *)topViewController;
@end
