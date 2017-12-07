//
//  UIViewController+Navbar.h
//  doctor
//
//  Created by LkSime on 16/3/14.
//  Copyright © 2016年 1ping.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//UIViewController 添加导航栏的自定义方法
@interface UIViewController (Navbar)

//隐藏导航栏
-(void)hideNavigatoinBar:(BOOL)hidden;
//设置VC标题
- (void)setNavigationTitle:(NSString *)title;
///带点击事件的标题
- (void)setNavigationTitle:(NSString *)title Target:(id)target Action:(SEL)action;
//设置导航栏颜色
- (void)setNavigationBackgroundColor:(UIColor *)color;
//添加导航栏左侧按钮(图标)
- (void)setNavigationLeftButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action;
//设置导航栏背景图片
//添加导航栏右侧按钮(图标)
- (void)setNavigationRightButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action;
//添加导航栏右侧按钮(文字)
- (void)setNavigationRightButtonText:(NSString *)title Target:(id)target Action:(SEL)action;
//添加导航栏多个右侧按钮
- (void)setNavigationRightButtonArray:(NSArray *)array;

@end
