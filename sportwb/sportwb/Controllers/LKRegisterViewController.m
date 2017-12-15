//
//  LKRegisterViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/15.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKRegisterViewController.h"

#define HGAP                20
#define VGAP                10

@interface LKRegisterViewController ()<UITextFieldDelegate>
{
    UITextField     *_tfPhone;
    UITextField     *_tfPwd;
    
    UIImageView     *_imgvUsr;
    UIImageView     *_imgvPwd;
    UIButton        *_nextSetpBtn;
}

@end

@implementation LKRegisterViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

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
    // Do any additional setup after loading the view.
    
    [self setTitle:@"注册"];
    
    UIImage * _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = _backItem;
    
    //背景
    UIImageView *bgImgV = [UIImageView new];
    bgImgV.image = [UIImage imageNamed:@"forgotPed_bg.jpg"];
    bgImgV.userInteractionEnabled = YES;
    [self.view addSubview:bgImgV];
    [bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.height.width.equalTo(self.view);
    }];
    
    
    //账号密码容器
    UIView *actPwdContentView = [UIView new];
    actPwdContentView.backgroundColor = [UIColor clearColor];
    actPwdContentView.layer.cornerRadius = 8;
    actPwdContentView.clipsToBounds = YES;
    actPwdContentView.layer.borderColor = ColorFromRGBA(0.1, 0.1, 0.1, 0.1).CGColor;
    actPwdContentView.layer.borderWidth = 2.0f;
    [bgImgV addSubview:actPwdContentView];
    [actPwdContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgImgV);
        make.width.equalTo(@300);
        make.height.lessThanOrEqualTo(@300);
        make.height.greaterThanOrEqualTo(@440);
    }];
    
    //手机号图标
    _imgvUsr = [UIImageView new];
    _imgvUsr.image = [UIImage imageNamed:@"tip_usr"];
    _imgvUsr.contentMode = UIViewContentModeCenter;
    [actPwdContentView addSubview:_imgvUsr];
    [_imgvUsr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.height.width.equalTo(@44);
    }];
    
    //竖线1
    UIView *Vline1 = [UIView new];
    Vline1.backgroundColor = ColorFromRGBA(0.1, 0.1, 0.1, 0.1);
    [actPwdContentView addSubview:Vline1];
    [Vline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgvUsr.mas_right).offset(5);
        make.centerY.equalTo(_imgvUsr);
        make.height.equalTo(@34);
        make.width.equalTo(@1);
    }];
    
    
    //手机号输入框
    _tfPhone = [UITextField new];
    _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    _tfPhone.delegate = self;
    _tfPhone.placeholder = @"请输入您的手机号";
    [actPwdContentView addSubview:_tfPhone];
    [_tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Vline1.mas_right).offset(10);
        make.centerY.equalTo(_imgvUsr);
        make.right.equalTo(actPwdContentView).offset(-10);
        make.height.equalTo(@44);
    }];
    //横线
    UIView *Hline = [UIView new];
    Hline.backgroundColor = ColorFromRGBA(0.1, 0.1, 0.1, 0.1);
    [actPwdContentView addSubview:Hline];
    [Hline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgvUsr.mas_bottom).offset(10);
        make.centerX.equalTo(actPwdContentView);
        make.width.equalTo(@240);
        make.height.equalTo(@1);
    }];
    
    //密码图标
    _imgvPwd = [UIImageView new];
    _imgvPwd.image = [UIImage imageNamed:@"tip_pwd"];
    _imgvPwd.contentMode = UIViewContentModeCenter;
    [actPwdContentView addSubview:_imgvPwd];
    [_imgvPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Hline.mas_bottom).offset(5);
        make.left.equalTo(_imgvUsr);
        make.height.width.equalTo(@44);
    }];
    
    
    //竖线2
    UIView *Vline2 = [UIView new];
    Vline2.backgroundColor = ColorFromRGBA(0.1, 0.1, 0.1, 0.1);
    [actPwdContentView addSubview:Vline2];
    [Vline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgvPwd.mas_right).offset(5);
        make.centerY.equalTo(_imgvPwd);
        make.height.equalTo(@34);
        make.width.equalTo(@1);
    }];
    
    //密码输入框
    CGFloat eyeBtnW = 40;
    _tfPwd = [[UITextField alloc] initWithFrame:CGRectMake(RightForView(_imgvPwd) + 1, TopForView(_imgvPwd), WidthForView(actPwdContentView) - WidthForView(_imgvUsr) - 1 - eyeBtnW, HeightForView(_imgvPwd))];
    _tfPwd.placeholder = @"不少于6位的密码";
    _tfPwd.secureTextEntry = YES;
    _tfPwd.delegate = self;
    [actPwdContentView addSubview:_tfPwd];
    [_tfPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Vline2.mas_right).offset(10);
        make.right.equalTo(_tfPhone).offset(60);
        make.height.equalTo(@44);
        make.centerY.equalTo(_imgvPwd);
    }];
    
    //密码可见眼睛
    UIButton *eyeBtn = [UIButton new];
    [eyeBtn setImage:[UIImage imageNamed:@"eye_n"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"eye_h"] forState:UIControlStateSelected];
    [actPwdContentView addSubview:eyeBtn];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgvPwd);
        make.right.equalTo(_tfPhone);
        make.height.width.equalTo(@44);
    }];
    
    //下一步按钮
    UIImage *regImg_n = [UIUtils creatResizableImageFromImageName:@"btn_orange"];
    _nextSetpBtn = [UIButton new];
    [_nextSetpBtn setBackgroundImage:regImg_n forState:UIControlStateNormal];
    [_nextSetpBtn setTitle:@"提交注册" forState:UIControlStateNormal];
    [_nextSetpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextSetpBtn addTarget:self action:@selector(nextSetpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [actPwdContentView addSubview:_nextSetpBtn];
    [_nextSetpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(actPwdContentView).offset(-20);
        make.centerX.equalTo(actPwdContentView);
        make.height.equalTo(@44);
        make.width.equalTo(@200);
    }];
}


#pragma mark - private functions
- (void)nextSetpBtnClick{

    if (_tfPwd.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码不能少于6个字"];
        return;
    }
    
    NSMutableDictionary *_mdictData = [[NSMutableDictionary alloc] init];
    [_mdictData setObject:_tfPwd.text forKey:_tfPhone.text];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_FILE];
    [_mdictData writeToFile:filePath atomically:YES];

    [SVProgressHUD showErrorWithStatus:@"注册成功，请登录"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIUtils popViewControllerAnimated:YES];
    });
}


- (void)eyeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _tfPwd.secureTextEntry = !_tfPwd.secureTextEntry;
    
}

#pragma mark - 文本输入代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        if ((_tfPhone.text.length > 10) && (_tfPwd.text.length > 5)) {
//
//            _nextSetpBtn.enabled = YES;
//        }else{
//            _nextSetpBtn.enabled = NO;
//        }
//
//    });
    
    return YES;
}

@end
