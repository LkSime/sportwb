//
//  LKNewsCell.m
//  sportwb
//
//  Created by LkSime on 2017/12/13.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKNewsCell.h"
#import "LKNewsModel.h"
#import <UIImageView+WebCache.h>

@interface LKNewsCell() {
    UIImageView * mImageView;
    UILabel * channelLabel;
    UILabel * titleLabel;
}
@end

@implementation LKNewsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        self.backgroundColor = COLOR_FOR_WHITE;
    }
    return self;
}

- (void)createView {
    UIView * spaceView = [UIView new];
    spaceView.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    [self addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    
    mImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sport_image_default"]];
    [self addSubview:mImageView];
    [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spaceView.mas_bottom).offset(10);
        make.left.equalTo(@(10));
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.equalTo(mImageView.mas_width).multipliedBy(2.0 / 3.0f);
    }];
    
    titleLabel = [UILabel new];
    titleLabel.font = FONT_FOR_TEXT_16;
    titleLabel.textColor = COLOR_FOR_TEXT_4D;
    titleLabel.numberOfLines = 4;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mImageView);
        make.left.equalTo(mImageView.mas_right).offset(15);
        make.right.equalTo(@(-15));
    }];
    
    UILabel * commentLabel = [UILabel new];
    commentLabel.font = FONT_FOR_TEXT_14;
    commentLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:commentLabel];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mImageView);
        make.left.equalTo(mImageView.mas_right).offset(15);
        make.height.equalTo(@(16));
    }];
    commentLabel.text = [NSString stringWithFormat:@"%u 评论", 50+(arc4random()%100)];
    
    UILabel * collectLabel = [UILabel new];
    collectLabel.font = FONT_FOR_TEXT_14;
    collectLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:collectLabel];
    [collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentLabel);
        make.left.equalTo(commentLabel.mas_right).offset(20);
        make.height.equalTo(@(16));
    }];
    collectLabel.text = [NSString stringWithFormat:@"%u 收藏", arc4random()%20];
    
    channelLabel = [UILabel new];
    channelLabel.font = FONT_FOR_TEXT_16;
    channelLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:channelLabel];
    [channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(commentLabel.mas_top).offset(-10);
        make.left.equalTo(commentLabel);
        make.right.equalTo(@(-10));
        make.height.equalTo(@(16));
    }];
}


- (void)setNewsCellData:(LKNewsSocialListModel *)dataModal {
    titleLabel.text = dataModal.title;
    channelLabel.text = dataModal.des;
    [mImageView sd_setImageWithURL:[NSURL URLWithString:dataModal.picUrl]];
}
@end
