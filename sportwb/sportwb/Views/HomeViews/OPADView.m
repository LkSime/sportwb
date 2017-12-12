//
//  OPADView.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "OPADView.h"

@interface OPADView () {
    UIImageView * mBannerImgV;
    CGRect        mBannerImgVFrame;
}

@end

@implementation OPADView

//初始化view的时候创建首页图片view
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        float adHeight = ADHeight;
        _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, adHeight)];
        self.clipsToBounds = YES;
        [self addSubview:_titleImage];
        
        _button = [[OPADViewButton alloc]initWithFrame:self.bounds];
        [self addSubview:_button];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentOffsetToZero:) name:@"ADDropDown" object:nil];
        mBannerImgV = _titleImage;
        mBannerImgVFrame = _titleImage.frame;
    }
    return self;
}
//监听响应滑动
- (void)contentOffsetToZero:(NSNotification *)sender {
    CGRect frame = self.frame;
    CGFloat s = [(NSNumber *)sender.object floatValue];
    if (s <= 0) {
        CGFloat ratio = (CGRectGetHeight(mBannerImgVFrame) + (-s)) / CGRectGetHeight(mBannerImgVFrame);
        CGFloat deltaW = CGRectGetWidth(mBannerImgVFrame) * ratio - CGRectGetWidth(mBannerImgVFrame);
        self.frame = CGRectMake(frame.origin.x, - ratio / 2, SCREEN_WIDTH, CGRectGetHeight(mBannerImgVFrame) * ratio);
        _titleImage.frame = CGRectMake(-deltaW / 2, - ratio/2, CGRectGetWidth(mBannerImgVFrame) * ratio, CGRectGetHeight(mBannerImgVFrame) * ratio);
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
