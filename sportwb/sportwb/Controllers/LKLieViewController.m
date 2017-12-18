//
//  LKLieViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/18.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKLieViewController.h"

@interface LKLieViewController ()

@end

@implementation LKLieViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"啊喔～"];
    UIImage * _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = _backItem;
    
    UIImageView * lieImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image_brid"]];
    [self.view addSubview:lieImageView];
    [lieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.equalTo(@(SCREEN_WIDTH / 2));
    }];
}
- (void)clickBackButton {
    [UIUtils popViewControllerAnimated:YES];
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
