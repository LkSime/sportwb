//
//  OPMyTopView.m
//  oneping
//
//  Created by LkSime on 15/8/25.
//  Copyright (c) 2015年 1ping.com All rights reserved.
//

#import "OPMyTopView.h"
#import "PublicFunction.h"
#import "OPMoreViewController.h"

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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createView];
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
    
}
- (void)clickSettingBtn {
    OPMoreViewController *aVC = [[OPMoreViewController alloc]init];
    [UIUtils pushVC:aVC];
}


@end
