//
//  OPMyBottomViewCell.m
//  oneping
//
//  Created by LkSime on 15/12/9.
//  Copyright © 2015年 1ping.com All rights reserved.
//

#import "OPMyBottomViewCell.h"
#import "AppDelegate.h"
#import "LKUserModel.h"
#import "LKUserInfoManager.h"


@interface OPMyBottomViewCell () {
    UIImageView         * _iconImageView;
    UILabel             * _titleLabel;
    NSString            * _pushVC;
}

@end

@implementation OPMyBottomViewCell

- (void)setUnReadLabel:(UILabel *)unReadLabel {
    _unReadLabel = unReadLabel;
    if ([_unReadLabel.text isEqualToString:@"0"] || IsEmpty(_unReadLabel.text)) {
        _unReadLabel.hidden = YES;
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createView {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12.5, 25, 25)];
    _iconImageView.layer.cornerRadius = WidthForView(_iconImageView) / 2;
    _iconImageView.layer.masksToBounds = YES;
    [self addSubview:_iconImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = COLOR_FOR_TEXT_4D;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.equalTo(_iconImageView);
        make.width.equalTo(@160);
        make.height.equalTo(@16);
    }];
    
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 15, 17.5, 9, 15)];
    arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self addSubview:arrowImage];
    
    UIImageView * line0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_1"]];
    line0.frame = CGRectMake(15, 49, SCREEN_WIDTH - 15 * 2, 1);
    [self addSubview:line0];
    
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushViewController)];
    [self addGestureRecognizer:tgr];
    
//    _unReadLabel = createLabel(SCREEN_WIDTH - 46, TopForView(_titleLabel) + 1.5, 14, 14, 10, WHITE);
//    _unReadLabel.textAlignment = NSTextAlignmentCenter;
//    _unReadLabel.backgroundColor = [UIColor redColor];
//    _unReadLabel.layer.cornerRadius = 7;
//    _unReadLabel.layer.masksToBounds = YES;
//    _unReadLabel.text = nil;
//    _unReadLabel.hidden = YES;
//    [self addSubview:_unReadLabel];
}

- (void)setMyBottomViewCellWithTitle:(NSString *)title Image:(NSString *)image PushVCClass:(NSString *)pushVC {
    [_iconImageView setImage:[UIImage imageNamed:[NSString stringWithString:image]]];
    _titleLabel.text = title;
    _pushVC = pushVC;
}

- (void)pushViewController {
    if ([_pushVC isEqualToString:@"collect"]) {
        //判断是否为测试账号
        LKUserModel * model = [LKUserInfoManager sharedInstance].infoModel;
        if ([model.isLogin isEqualToString:@"Yes"]) {
            if ([model.username isEqualToString:@"18515991874"]) {
                [UIUtils pushVC:@"LKCollectViewController" withParam:nil];
            } else {
                [UIUtils pushVC:@"LKLieViewController" withParam:nil];
            }
        } else {
            [UIUtils pushVC:@"LKLoginViewController" withParam:nil];
        }
    } else {
        [UIUtils pushVC:[NSString stringWithString:_pushVC] withParam:nil];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
