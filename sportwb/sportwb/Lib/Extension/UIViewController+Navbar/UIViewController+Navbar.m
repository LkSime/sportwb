//
//  UIViewController+Navbar.m
//  doctor
//
//  Created by LkSime on 16/3/14.
//  Copyright © 2016年 1ping.com. All rights reserved.
//

#import "UIViewController+Navbar.h"
#import "UIColor+FlatUI.h"

@implementation UIViewController (Navbar)

//隐藏导航栏
-(void)hideNavigatoinBar:(BOOL)hidden{
    self.navigationController.navigationBar.hidden = hidden;
}
///设置VC标题
- (void)setNavigationTitle:(NSString *)title {
    [self setNavigationTitle:title Target:nil Action:nil];
}
///带点击事件的标题
- (void)setNavigationTitle:(NSString *)title Target:(id)target Action:(SEL)action {
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 72, 40)];
    self.navigationItem.titleView = titleView;
    UIButton * titleButton = [UIButton new];
    [titleButton setTitle:title forState:UIControlStateNormal];
    titleButton.titleLabel.font = FONT_FOR_TEXT_18;
    [titleButton setTitleColor:COLOR_FOR_TEXT_33  forState:UIControlStateNormal];
    [titleButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
        make.height.equalTo(@40);
    }];
}
///设置导航栏颜色
- (void)setNavigationBackgroundColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.translucent = NO;
}

//添加导航栏左侧按钮(图标)
- (void)setNavigationLeftButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action{
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:imageName]
                                   style:UIBarButtonItemStyleDone
                                   target:target action:action];
    leftButton.tintColor = ColorFromHex(0x7e7e7e);
    self.navigationItem.leftBarButtonItem = leftButton;
}

///添加导航栏右侧按钮(图标)
- (void)setNavigationRightButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:imageName]
                                   style:UIBarButtonItemStyleDone
                                   target:target action:action];
    rightButton.tintColor = ColorFromHex(0x7e7e7e);
    self.navigationItem.rightBarButtonItem = rightButton;
}
///添加导航栏右侧按钮(文字)
- (void)setNavigationRightButtonText:(NSString *)title Target:(id)target Action:(SEL)action {
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88.0f, 44.0f)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:ColorFromHex(0x808080) forState:UIControlStateNormal];
    [rightBtn setTitleColor:ColorFromHex(0x4d4d4d) forState:UIControlStateHighlighted];
    rightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [backButton setStyle:UIBarButtonItemStyleDone];
    self.navigationItem.rightBarButtonItem = backButton;
}

///添加导航栏多个右侧按钮
- (void)setNavigationRightButtonArray:(NSArray *)array {
    if (IsEmpty(array)) {
        return;
    }
    NSMutableArray * itemsArray = [NSMutableArray array];
    for (UIButton * rightButton in array) {
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        [rightItem setStyle:UIBarButtonItemStyleDone];
        [itemsArray addObject:rightItem];
    }
    self.navigationItem.rightBarButtonItems = itemsArray;
}
@end
