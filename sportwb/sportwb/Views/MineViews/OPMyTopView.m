//
//  OPMyTopView.m
//  oneping
//
//  Created by LkSime on 15/8/25.
//  Copyright (c) 2015年 1ping.com All rights reserved.
//

#import "OPMyTopView.h"
#import "PublicFunction.h"

@interface OPMyTopView (){
    UIImageView * backgroundView;
}

@end

@implementation OPMyTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];

        UIImage * image = [UIImage imageNamed:@"user_tbg"];
        self.layer.contents = (id)image.CGImage;
        self.frame = frame;
        [self createView];
        

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createView];
//        [self getPingScore];
    }
    return self;
}
- (void)createView {
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.top.equalTo(self).offset(60);
        make.width.height.equalTo(@60);
    }];
    _avatarView.layer.cornerRadius = 30;
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.borderColor = ColorFromRGBA(0.1, 0.1, 0.1, 0.1).CGColor;
    _avatarView.layer.borderWidth = 2.0f;
    _avatarView.image = [UIImage imageNamed:@"avatar"];
    
    UIImageView * indicateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_white"]];
    [self addSubview:indicateImage];
    [indicateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatarView);
        make.right.equalTo(self).offset(-12);
        make.width.height.equalTo(@15);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = FONT_FOR_TEXT_14;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(20);
        make.top.equalTo(_avatarView);
        make.right.lessThanOrEqualTo(self).offset(-40);
    }];

//    _viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:_viewButton];
//    [_viewButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_avatarView.mas_right).offset(20);
//        make.top.equalTo(_avatarView).offset(10);
//        make.right.equalTo(indicateImage.mas_left);
//        make.bottom.equalTo(self);
//    }];

    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:(@"注册/登录")
                  forState:UIControlStateNormal];
    _loginButton.titleLabel.font = FONT_FOR_TEXT_18;
    [_loginButton addTarget:self action:@selector(clickLoginBtn)
           forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(15);
        make.centerY.equalTo(_avatarView);
        make.right.equalTo(self);
    }];
    
    UIButton * setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setButton setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(clickSettingBtn)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setButton];
    [setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(24);
        make.width.height.equalTo(@40);
    }];
    
//    [self layoutIfNeeded];
//    setButton.frame = CGRectMake(20, 60, 40, 100);
//    [self layoutSubviews];
//    [self updateConstraintsIfNeeded];
//    [self updateConstraints];
    
}

- (void)clickLoginBtn {
    [PublicFunction needLogin:NO];
}
- (void)clickSettingBtn {
//    OPMoreViewController *aVC = [[OPMoreViewController alloc]init];
//    [UIUtils pushVC:aVC];
}


@end
