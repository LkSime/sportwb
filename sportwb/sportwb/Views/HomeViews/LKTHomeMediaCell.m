//
//  LKTHomeMediaCell.m
//  sportwb
//
//  Created by LkSime on 2017/12/13.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKTHomeMediaCell.h"
#import "LKNewsModel.h"
#import <UIImageView+WebCache.h>

@interface LKTHomeMediaCell() {
    UIImageView * mImageView;
    UILabel * channelLabel;
    UILabel * titleLabel;
}
@end

@implementation LKTHomeMediaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        self.backgroundColor = COLOR_FOR_WHITE;
    }
    return self;
}

- (void)createView {
    titleLabel = [UILabel new];
    titleLabel.font = FONT_FOR_TEXT_16;
    titleLabel.textColor = COLOR_FOR_TEXT_4D;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.height.equalTo(@(20));
    }];
    
    mImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sport_image_default"]];
    [self addSubview:mImageView];
    [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
        make.left.equalTo(@(10));
        make.right.equalTo(@(-10));
        make.height.equalTo(mImageView.mas_width).multipliedBy(2.0 / 3.0f);
    }];
    
    channelLabel = [UILabel new];
    channelLabel.font = FONT_FOR_TEXT_14;
    channelLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:channelLabel];
    [channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mImageView.mas_bottom).offset(15);
        make.left.equalTo(@(10));
        make.height.equalTo(@(16));
    }];
    
    UILabel * commentLabel = [UILabel new];
    commentLabel.font = FONT_FOR_TEXT_14;
    commentLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:commentLabel];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(channelLabel);
        make.left.equalTo(channelLabel.mas_right).offset(20);
        make.height.equalTo(@(16));
    }];
    commentLabel.text = [NSString stringWithFormat:@"%u评论", 50+(arc4random()%100)];
    
    UILabel * collectLabel = [UILabel new];
    collectLabel.font = FONT_FOR_TEXT_14;
    collectLabel.textColor = COLOR_FOR_TEXT_80;
    [self addSubview:collectLabel];
    [collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(channelLabel);
        make.left.equalTo(commentLabel.mas_right).offset(20);
        make.height.equalTo(@(16));
    }];
    collectLabel.text = [NSString stringWithFormat:@"%u收藏", arc4random()%20];
}

- (void)setMediaCellData:(LKNewsSocialListModel *)dataModal {
    titleLabel.text = dataModal.title;
    channelLabel.text = dataModal.des;
    [mImageView sd_setImageWithURL:[NSURL URLWithString:dataModal.picUrl]];
}

@end
