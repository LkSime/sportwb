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
        UIImage * image = [UIImage imageNamed:@"user_tbg"];
        self.layer.contents = (id)image.CGImage;
        self.frame = frame;
        [self createView];
        
    }
    return self;
}

- (void)createView {
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(40);
        make.width.height.equalTo(@80);
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
    _nameLabel.font = [UIFont systemFontOfSize:24.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(20);
        make.centerY.equalTo(_avatarView);
    }];
    
    _loginButton = [UIButton new];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = FONT_FOR_TEXT_18;
    [self addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(20);
        make.centerY.equalTo(_avatarView);
        make.height.equalTo(@36);
        make.width.equalTo(@100);
    }];
    
    _viewButton = [UIButton new];
    [self addSubview:_viewButton];
    [_viewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginButton.mas_right).offset(20);
        make.centerY.equalTo(_avatarView);
        make.height.right.equalTo(self);
    }];
    
    
}

@end
