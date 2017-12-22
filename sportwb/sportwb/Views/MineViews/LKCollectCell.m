//
//  LKCollectCell.m
//  sportwb
//
//  Created by LkSime on 2017/12/22.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKCollectCell.h"

@implementation LKCollectCell
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
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
