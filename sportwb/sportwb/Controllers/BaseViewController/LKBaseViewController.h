//
//  LKBaseViewController.h
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKBaseViewController : UIViewController

/**导航栏 begin*/
//隐藏导航栏
-(void)hideNavigatoinBar:(BOOL)hidden;
//设置标题
-(void)setNavigationTitle:(NSString *)title;
//设置可点击标题
-(void)setNavigationTitle:(NSString *)title Target:(id)target Action:(SEL)action;
//设置导航栏颜色
- (void)setNavigationBackgroundColor:(UIColor *)color;
//添加导航栏左侧按钮(图标)
- (void)setNavigationLeftButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action;
//添加导航栏右侧按钮(图标)
- (void)setNavigationRightButtonImage:(NSString *)imageName Target:(id)target Action:(SEL)action;
//添加导航栏右侧按钮(文字)
- (void)setNavigationRightButtonText:(NSString *)title Target:(id)target Action:(SEL)action;
//添加导航栏多个右侧按钮
- (void)setNavigationRightButtonArray:(NSArray *)array;
/**导航栏 end*/

@end
