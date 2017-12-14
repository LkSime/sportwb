//
//  OPMyTopView.h
//  oneping
//
//  Created by LkSime on 15/8/25.
//  Copyright (c) 2015年 1ping.com All rights reserved.
//

#import <UIKit/UIKit.h>

/**我的界面顶部个人视图*/
@interface OPMyTopView : UIView

@property (nonatomic, strong) UIImageView    * avatarView;
@property (nonatomic, strong) UIImageView    * memberSign;
@property (nonatomic, strong) UILabel        * nameLabel;
@property (nonatomic, strong) UILabel        * scoreLabel;
@property (nonatomic, strong) UIButton       * loginButton;
@property (nonatomic, strong) UIButton       * viewButton;

-(void)getPingScore;

@end
