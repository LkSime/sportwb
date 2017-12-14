//
//  OPMyBottomViewCell.h
//  oneping
//
//  Created by LkSime on 15/12/9.
//  Copyright © 2015年 1ping.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMViewController.h"

/**我的界面顶部个人视图的cell*/
@interface OPMyBottomViewCell : UIView

@property (nonatomic, strong) UILabel * unReadLabel;

- (void)setMyBottomViewCellWithTitle:(NSString *)title Image:(NSString *)image PushVCClass:(NSString *)pushVC;
@end
