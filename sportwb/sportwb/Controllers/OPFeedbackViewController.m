//
//  OPFeedbackViewController.m
//  oneping
//
//  Created by 吴星煜 on 14/11/28.
//  Copyright (c) 2014年 1ping.com. All rights reserved.
//

#import "OPFeedbackViewController.h"
//#import "SVProgressHUD.h"
//#import "GCPlaceholderTextView.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>
//#import "OPChangeModeView.h"

#define GAP             10.0f

@interface OPFeedbackViewController ()<UITextViewDelegate>
{
    UITextField             *_tfName;
    UITextField             *_tfPhone;
    UITextView   *_tvDetail;
}

@end

@implementation OPFeedbackViewController

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
    UIImage * _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = _backItem;
    
    UIButton * sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:COLOR_FOR_TEXT_80 forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(actionForRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * sendButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendButtonItem;
    
    [self setTitle:@"意见反馈"];

    

    
    UILabel *lbNameTip = [[UILabel alloc] init];
    lbNameTip.text = @"真实姓名";
    lbNameTip.textColor = COLOR_FOR_TEXT_4D;
    lbNameTip.font = FONT_FOR_TEXT_14;
    [self.view addSubview:lbNameTip];
    [lbNameTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
    }];
    
    _tfName = [[UITextField alloc] init];
    _tfName.font = [UIFont systemFontOfSize:12.0f];
    _tfName.placeholder = @"请填写您的真实姓名";
    _tfName.leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    _tfName.leftViewMode        = UITextFieldViewModeAlways;
    _tfName.backgroundColor = COLOR_FOR_WHITE;
    [self.view addSubview:_tfName];
    [_tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(lbNameTip.mas_bottom).offset(10);
        make.height.equalTo(@35);
    }];
    
    UILabel *lbPhoneTip = [[UILabel alloc] init];
    lbPhoneTip.text = @"手机号码";
    lbPhoneTip.textColor = COLOR_FOR_TEXT_4D;
    lbPhoneTip.font = FONT_FOR_TEXT_14;
    [self.view addSubview:lbPhoneTip];
    [lbPhoneTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_tfName.mas_bottom).offset(10);
    }];
    
    _tfPhone = [[UITextField alloc] init];
    _tfPhone.font = [UIFont systemFontOfSize:12.0f];
    _tfPhone.placeholder = @"请填写您的手机号";
    _tfPhone.keyboardType = UIKeyboardTypePhonePad;
    _tfPhone.backgroundColor = COLOR_FOR_WHITE;
    _tfPhone.leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    _tfPhone.leftViewMode        = UITextFieldViewModeAlways;
    [self.view addSubview:_tfPhone];
    [_tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_tfName);
        make.top.equalTo(lbPhoneTip.mas_bottom).offset(10);
        make.height.equalTo(@35);
    }];
    
    UILabel *lbDetailTip = [[UILabel alloc] init];
    lbDetailTip.text = @"您的反馈意见";
    lbDetailTip.textColor = COLOR_FOR_TEXT_B3;
    lbDetailTip.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:lbDetailTip];
    [lbDetailTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_tfPhone.mas_bottom).offset(10);
    }];
    
    _tvDetail = [[UITextView alloc] init];
    _tvDetail.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:_tvDetail];
    [_tvDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_tfName);
        make.top.equalTo(lbDetailTip.mas_bottom).offset(10);
        make.height.equalTo(@150);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBackButton {
    [UIUtils popViewControllerAnimated:YES];
}
- (void)actionForRightButton
{
    if (0 == [_tvDetail.text length]) {
        [SVProgressHUD showErrorWithStatus:@"请填写您的宝贵意见"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"提交中。。。"];
    
        _tfName.text = nil;
        _tfPhone.text = nil;
        _tvDetail.text = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"感谢您的反馈"];
        [UIUtils popViewControllerAnimated:YES];
    });

    
}

@end
