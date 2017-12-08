//
//  LKBaseWebViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseWebViewController.h"

@interface LKBaseWebViewController ()<UIWebViewDelegate> {
    UIProgressView  * _progressView;
    NSTimer         * _fakeProgressTimer;
    NSDictionary    * _paramsDictionary; //分享的数据
    
    //导航栏返回、关闭按钮
    UIBarButtonItem * _backItem;
    UIImage         * _backImage;
    UIBarButtonItem * _closeItem;
    
    UIButton * _closeButton;
    UIButton * _backButton;
}

@end

@implementation LKBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    [self setNavigationTitle:_webTitle];
    _paramsDictionary = [NSDictionary dictionary];
    [self createView];
    [self initNavBarItem];
}

- (void)createView {
    self.mWebView = [UIWebView new];
    self.mWebView.delegate = self;
    self.mWebView.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    [self.view addSubview:self.mWebView];
    [self.mWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:_progressView];
    [_progressView setTintColor:COLOR_FOR_MAIN_36A6C7];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
}

- (void)loadWithURL:(NSString *)url Cookies:(BOOL)need {
    NSURL * webURL = [NSURL URLWithString:url];
    [_mWebView loadRequest: [NSMutableURLRequest requestWithURL:webURL]];
    [_mWebView setScalesPageToFit:YES];
}

#pragma mark - 导航栏
- (void)initNavBarItem {
    _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    _backButton.hidden = YES;
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _closeButton.hidden = YES;
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeButton setTitleColor:COLOR_FOR_TEXT_80 forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(clickcloseButton) forControlEvents:UIControlEventTouchUpInside];
    _closeItem = [[UIBarButtonItem alloc] initWithCustomView:_closeButton];
    
    if ([self isShowNavBarCloseItem]) {
        self.navigationItem.leftBarButtonItems = @[_backItem, _closeItem];
    } else {
        self.navigationItem.leftBarButtonItem = _backItem;
    }
}
- (void)clickBackButton {
    if (self.mWebView.canGoBack) {
        [self.mWebView goBack];
    } else {
        [self clickcloseButton];
    }
}
- (void)clickcloseButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听Web请求
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.mWebView.canGoBack) {
        _backButton.hidden = NO;
        _closeButton.hidden = NO;
    }else{
        if (_isFirst) {
            _backButton.hidden = YES;
        } else {
            _backButton.hidden = NO;
        }
        _closeButton.hidden = YES;
    }
    [self fakeProgressBarStopLoading];
    
    [SVProgressHUD dismiss];
    
}
#pragma mark - Fake Progress Bar Control (UIWebView)
- (void)fakeProgressViewStartLoading {
    [_progressView setProgress:0.0f animated:NO];
    [_progressView setAlpha:1.0f];
    
    if(!_fakeProgressTimer) {
        _fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(_fakeProgressTimer) {
        [_fakeProgressTimer invalidate];
    }
    
    if(_progressView) {
        [_progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.5f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [_progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(_progressView.progress + 0.2);
    if([_mWebView isLoading]) {
        CGFloat progress = (_progressView.progress < 0.75f) ? _progressView.progress + increment : _progressView.progress + 0.0005;
        if(_progressView.progress < 0.95) {
            [_progressView setProgress:progress animated:YES];
        }
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (![self isCustomProgressStart]) {
        [self fakeProgressViewStartLoading];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    
    [self fakeProgressBarStopLoading];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * usl = request.URL;
    return YES;
}

#pragma mark -- url操作 取字典
- (NSDictionary *)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isShowNavBarCloseItem {
    
    return YES;
}

-(BOOL)isShowNavBarRightButton{
    return YES;
}
-(BOOL)isCustomProgressStart{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
