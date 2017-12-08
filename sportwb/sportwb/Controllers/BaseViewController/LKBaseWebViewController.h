//
//  LKBaseWebViewController.h
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKBaseWebViewController : LKBaseViewController

@property (nonatomic, copy  ) NSString  * webURL;
@property (nonatomic, copy  ) NSString  * webTitle;
@property (nonatomic, strong) UIWebView * mWebView;
///是否是一级界面
@property (nonatomic, assign) BOOL        isFirst;

///加载网页,是否需要加入cookies
- (void)loadWithURL:(NSString *)url Cookies:(BOOL)need;
///是否显示右侧按钮
- (BOOL)isShowNavBarRightButton;
///是否显示关闭按钮
- (BOOL)isShowNavBarCloseItem;
///自定义进度条开始
- (void)fakeProgressViewStartLoading;
///进度条结束
- (void)fakeProgressBarStopLoading;
///刷新
-(void)actionForRightRefresh;

@end
