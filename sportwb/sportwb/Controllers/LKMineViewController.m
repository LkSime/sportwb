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
#import "OPMoreViewController.h"
#import "LKLoginViewController.h"
#import "LKUserInfoManager.h"

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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];
}

- (void)viewWillAppear:(BOOL)animated {
    LKUserModel * model = [LKUserInfoManager sharedInstance].infoModel;
    if (model.isLogin) {
        _myTopView.loginButton.hidden = YES;
        _myTopView.nameLabel.hidden = NO;
        _myTopView.nameLabel.text = model.username;
        _myTopView.avatarView.image = [UIImage imageNamed:@"sportwb_avatar"];
    } else {
        _myTopView.loginButton.hidden = NO;
        _myTopView.nameLabel.hidden = YES;
        _myTopView.nameLabel.text = @"";
        _myTopView.avatarView.image = [UIImage imageNamed:@"avatar"];
    }
}

- (void)createView {

    _myTopView = [[OPMyTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [_myTopView.viewButton addTarget:self action:@selector(pushUserInfoView) forControlEvents:UIControlEventTouchUpInside];
    [_myTopView.loginButton addTarget:self action:@selector(actionOfLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myTopView];
    
    _myBottomView = [[OPMyBottomView alloc] initWithFrame:CGRectMake(0, BottomForView(_myTopView) + 10, SCREEN_WIDTH, 500)];
    [self.view addSubview:_myBottomView];
}

- (void)actionOfLogin {
    LKLoginViewController * loginVC = [LKLoginViewController new];
    loginVC.isLaunch = NO;
    [UIUtils pushVC:loginVC];
}

- (void)pushUserInfoView {
    OPMoreViewController * moreVC = [OPMoreViewController new];
    [UIUtils pushVC:moreVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
