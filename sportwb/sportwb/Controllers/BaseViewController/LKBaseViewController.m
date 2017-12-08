//
//  LKBaseViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseViewController.h"
#import "UIViewController+Navbar.h"

@interface LKBaseViewController ()

@end

@implementation LKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationBar

-(void)initNavigation{
    //设置默认导航背景颜色
    [self setNavigationBackgroundColor:[UIColor whiteColor]];
    //设置默认ViewController背景颜色
    self.view.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"btn_nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,30,0,0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin,NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

//隐藏导航栏
-(void)hideNavigatoinBar:(BOOL)hidden{
    [super hideNavigatoinBar:hidden];
}
//设置标题
-(void)setNavigationTitle:(NSString *)title{
    [super setNavigationTitle:title];
}
//设置可点击标题
-(void)setNavigationTitle:(NSString *)title Target:(id)target Action:(SEL)action{
    [super setNavigationTitle:title Target:target Action:action];
}
//设置导航栏颜色
- (void)setNavigationBackgroundColor:(UIColor *)color{
    [super setNavigationBackgroundColor:color];
}
//添加导航栏左侧按钮(图标)
- (void)setNavigationLeftButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action{
    [super setNavigationLeftButtonImage:imageName Target:target Action:action];
}
//添加导航栏右侧按钮(图标)
- (void)setNavigationRightButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action{
    [super setNavigationRightButtonImage:imageName Target:target Action:action];
}
//添加导航栏右侧按钮(文字)
- (void)setNavigationRightButtonText:(NSString *)title Target:(id)target Action:(SEL)action;{
    [super setNavigationRightButtonText:title Target:target Action:action];
}
//添加导航栏多个右侧按钮
- (void)setNavigationRightButtonArray:(NSArray *)array {
    [super setNavigationRightButtonArray:array];
}
- (void)clickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
