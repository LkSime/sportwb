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
#import "LKRegisterViewController.h"

@interface LKLoginViewController ()<UITabBarControllerDelegate> {
    MMDrawerController *_drawerController;
    UITextField *phoneField;
    UITextField *pwdField;
}

@end

@implementation LKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *_mdictData = [[NSMutableDictionary alloc] init];
    [_mdictData setObject:@"123456" forKey:@"18515991874"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_FILE];
    [_mdictData writeToFile:filePath atomically:YES];
    
    [self createView];
    [self createTabbarView];
}

#pragma mark - createView
-(void)createView{
    UIImageView *bgImg = [UIImageView new];
    bgImg.image = [UIImage imageNamed:@"login_bg.jpg"];
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    UIView *contentView = [UIView new];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    UIImageView *avatarImg = [UIImageView new];
    avatarImg.image = [UIImage imageNamed:@"icon_login"];
    [contentView addSubview:avatarImg];
    [avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(95);
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(74);
    }];
    
    UIView *infoView = [UIView new];
    infoView.backgroundColor = [UIColor whiteColor];
    infoView.layer.cornerRadius = 2;
    infoView.clipsToBounds = YES;
    [contentView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(20);
        make.right.equalTo(contentView).offset(-20);
        make.top.equalTo(avatarImg.mas_bottom).offset(40);
    }];
    
    //手机号码
    UIImageView *phoneIconImg = [UIImageView new];
    phoneIconImg.contentMode = UIViewContentModeCenter;
    [phoneIconImg setImage:[UIImage imageNamed:@"tip_avatar_icon"]];
    [infoView addSubview:phoneIconImg];
    [phoneIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(infoView);
        make.width.and.height.mas_equalTo(44);
    }];
    
    UIView *phoneLineView = [UIView new];
    phoneLineView.backgroundColor = ColorFromHex(0xebebeb);
    [infoView addSubview:phoneLineView];
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneIconImg.mas_right);
        make.top.equalTo(infoView).offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(34);
    }];
    
    phoneField = [UITextField new];
    phoneField.placeholder = @"请输入您的手机号";
    phoneField.textColor = COLOR_FOR_TEXT_80;
    phoneField.font = FONT_FOR_TEXT_14;
    pwdField.keyboardType = UIKeyboardTypeNumberPad;
    [infoView addSubview:phoneField];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView);
        make.right.equalTo(infoView).offset(-10);
        make.left.equalTo(phoneLineView.mas_right).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    //
    UIView *lineView = [UIView new];
    lineView.backgroundColor = ColorFromHex(0xebebeb);
    [infoView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneField.mas_bottom);
        make.left.and.right.equalTo(infoView);
        make.height.mas_equalTo(1);
    }];
    
    //密码
    UIImageView *pwdIconImg = [UIImageView new];
    pwdIconImg.contentMode = UIViewContentModeCenter;
    [pwdIconImg setImage:[UIImage imageNamed:@"tip_pwd_icon"]];
    [infoView addSubview:pwdIconImg];
    [pwdIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(infoView);
        make.width.and.height.mas_equalTo(44);
    }];
    
    UIView *pwdLineView = [UIView new];
    pwdLineView.backgroundColor = ColorFromHex(0xebebeb);
    [infoView addSubview:pwdLineView];
    [pwdLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdIconImg.mas_right);
        make.top.equalTo(lineView.mas_bottom).offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(34);
    }];
    
    pwdField = [UITextField new];
    pwdField.placeholder = @"请输入您的密码";
    pwdField.textColor = COLOR_FOR_TEXT_80;
    pwdField.font = FONT_FOR_TEXT_14;
    pwdField.secureTextEntry = YES;
    [infoView addSubview:pwdField];
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(pwdLineView.mas_right).offset(10);
        make.right.equalTo(infoView).offset(-44);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *showPwdBtn = [UIButton new];
    showPwdBtn.backgroundColor = [UIColor clearColor];
    [showPwdBtn setImage:[UIImage imageNamed:@"tip_hide_pwd"] forState:UIControlStateNormal];
    [showPwdBtn setImage:[UIImage imageNamed:@"tip_show_pwd"] forState:UIControlStateSelected];
    [showPwdBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:showPwdBtn];
    [showPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.right.equalTo(infoView);
        make.width.and.height.mas_equalTo(44);
    }];
    
    [infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pwdField.mas_bottom);
    }];
    
    //登录按钮
    UIButton *loginBtn = [UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:COLOR_FOR_WHITE forState:UIControlStateNormal];
    loginBtn.titleLabel.font = FONT_FOR_TEXT_16;
    [loginBtn addTarget:self action:@selector(actionForLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:resizableImageWithImageName(@"btn_blue_light") forState:UIControlStateHighlighted];
    [loginBtn setBackgroundImage:resizableImageWithImageName(@"btn_blue_normal") forState:UIControlStateNormal];
    [contentView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdField.mas_bottom).offset(20);
        make.left.and.right.equalTo(infoView);
        make.height.mas_equalTo(44);
    }];

    UIView * spaceView = [UIView new];
    spaceView.backgroundColor = [UIColor whiteColor];
    spaceView.layer.cornerRadius = 2.0f;
    spaceView.layer.masksToBounds = YES;
    [contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(loginBtn.mas_bottom).offset(13);
        make.height.equalTo(@0.71);
    }];
    
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.titleLabel.font = FONT_FOR_TEXT_14;
    [registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(actionOfRegister) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spaceView.mas_bottom).offset(20);
        make.centerX.equalTo(contentView);
        make.width.equalTo(@100);
        make.height.equalTo(@32);
    }];
    
//    UIButton * forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    forgotButton.titleLabel.font = FONT_FOR_TEXT_14;
//    [forgotButton setTitle:@"找回密码" forState:UIControlStateNormal];
//    [forgotButton addTarget:self action:@selector(actionOfForgot) forControlEvents:UIControlEventTouchUpInside];
//    [contentView addSubview:forgotButton];
//    [forgotButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(spaceView.mas_bottom).offset(20);
//        make.centerX.equalTo(contentView).offset(SCREEN_WIDTH * 0.25);
//        make.width.equalTo(@100);
//        make.height.equalTo(@32);
//    }];
    
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(registerButton.mas_bottom).offset(20);
    }];
    
    
}

- (void)createTabbarView {
    
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.mtabBarController = tabBarController;
    
    LKHomeViewController * homeVC = [LKHomeViewController new];
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"首页";

    LKNewsViewController * newsVC = [LKNewsViewController new];
    UINavigationController * newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    newsVC.title = @"资讯";

    LKMineViewController * mineVC = [LKMineViewController new];
    UINavigationController * mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
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

}
- (void)actionForLogin {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_FILE];
    NSDictionary *_mdictData = [[[NSDictionary alloc] initWithContentsOfFile:filePath] mutableCopy];

    NSString * account = phoneField.text;
    NSString * pwd = pwdField.text;
    __weak typeof(self) weakSelf = self;
    [_mdictData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:account] && [obj isEqualToString:pwd]) {
            [weakSelf.navigationController pushViewController:_drawerController animated:YES];
        } else {
            TipAlert(@"账号或者密码有误");
        }
    }];
    
}
- (void)eyeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    pwdField.secureTextEntry = !pwdField.secureTextEntry;
        
}

//- (void)actionOfForgot {
//    LKRegisterViewController * regVC = [LKRegisterViewController new];
//    [UIUtils pushVC:regVC];
//}
- (void)actionOfRegister {
    LKRegisterViewController * regVC = [LKRegisterViewController new];
    [UIUtils pushVC:regVC];
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
