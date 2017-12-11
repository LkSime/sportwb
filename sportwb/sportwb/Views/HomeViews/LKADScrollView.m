//
//  LKADScrollView.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKADScrollView.h"
#import "OPADView.h"
#import "UIImageView+WebCache.h"
#import "LKBaseWebViewController.h"

#define ADHeight (SCREEN_WIDTH * 19.0f / 32.0f)

@interface LKADScrollView ()<UIScrollViewDelegate> {
    
    NSMutableArray * imageArray;
    NSMutableArray * httpsArray;
    OPADView * backgroundView;
    UIImageView *mBannerImgV;
    CGRect mBannerImgVFrame;
    
    NSTimer *_timer;
    NSTimeInterval _duration;
    
//    OPWeatherWidget * weatherWidget;
//    OPWeatherWidget * weatherWidget1;
//    OPWeatherWidget * weatherWidget2;
//
}

@end

@implementation LKADScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageArray = [NSMutableArray array];
        httpsArray = [NSMutableArray array];
        
        _mainScrollView  = [[UIScrollView alloc] initWithFrame:frame];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentOffset = CGPointZero;
        _mainScrollView.backgroundColor = COLOR_FOR_CLEAR;
        [self addSubview:_mainScrollView];
        
//        weatherWidget = [[OPWeatherWidget alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100, 130, 90) weatherModel:nil];
//        weatherWidget1 = [[OPWeatherWidget alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100, 130, 90) weatherModel:nil];
//        weatherWidget2 = [[OPWeatherWidget alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100, 130, 90) weatherModel:nil];
        backgroundView = [[OPADView alloc] initWithFrame:frame];
        backgroundView.titleImage.image = [UIImage imageNamed:@"Weatherbanner2"];
        backgroundView.button.hidden = YES;
        backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWeatherView)];
        [backgroundView addGestureRecognizer:tap];
//        [backgroundView addSubview:weatherWidget];
        [_mainScrollView addSubview:backgroundView];
        
        _mainPageControl = [[UIPageControl alloc] init];
        _mainPageControl.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        _mainPageControl.center = CGPointMake(SCREEN_WIDTH /2, _mainScrollView.bounds.size.height - 12);
        _mainPageControl.currentPageIndicatorTintColor = COLOR_FOR_WHITE;
        _mainPageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.67];
        _mainPageControl.enabled = NO;
        [self addSubview:_mainPageControl];
        
        
        [self requestADImageInfo];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentOffsetToZero:) name:@"ADDropDown" object:nil];
        mBannerImgVFrame = frame;
    }
    return self;
}

#pragma mark -- 获取公告信息
- (void)requestADImageInfo {
    
    __weak typeof(self) weakSelf = self;
    
//    [[OPStartPageApi shareInstance]getADViewInfoWithType:@"2" WithSuccessBlock:^(id data) {
//        [imageArray removeAllObjects];
//        [httpsArray removeAllObjects];
//        [imageArray addObject:@"default"];
//        [httpsArray addObject:@"default"];
//        //要判空
//        if (IsEmpty(data)) {
//            return ;
//        }
//
//        for (NSDictionary * dic in data) {
//            [imageArray addObject:[dic objectForKey:@"img"]];
//            [httpsArray addObject:[NSString stringWithFormat:@"%@?platform=app", [dic objectForKey:@"url"]]];
//        }
//
//        [IMXUtils delayThread:^{
//            [weakSelf createADView];
//        } withTime:0.3];
//    } WithErrorBlock:^(NSString *errMsg, NSInteger errCode) {
//        [IMXUtils delayThread:^{
//            [weakSelf createADView];
//        } withTime:0.3];
//    }];
    
}
- (void)createADView {
    CGSize contentSize;
    CGPoint startPoint;
    [_timer invalidate];
    for (UIView *view in _mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    if (imageArray.count > 1) {
        for (NSInteger i = 0; i < imageArray.count + 2; i++) {
            OPADView * adView = [[OPADView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, ADHeight)];
            [_mainScrollView addSubview:adView];
            if (i == 0) {
                NSURL * imageUrl = [NSURL URLWithString:imageArray.lastObject];
                [adView.titleImage sd_setImageWithURL:imageUrl
                                     placeholderImage:[UIImage imageNamed:@"ADHomeImage"]];
                adView.button.adUrl = httpsArray.lastObject;
            } else if (i == 1 || i == imageArray.count + 1) {
                adView.titleImage.image = [UIImage imageNamed:@"Weatherbanner2"];
                adView.button.hidden = YES;
                adView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWeatherView)];
                [adView addGestureRecognizer:tap];
                if (i == 1) {
//                    [adView addSubview:weatherWidget1];
                } else {
//                    [adView addSubview:weatherWidget2];
                }
            } else {
                NSURL * imageUrl = [NSURL URLWithString:imageArray[i - 1]];
                [adView.titleImage sd_setImageWithURL:imageUrl
                                     placeholderImage:[UIImage imageNamed:@"ADHomeImage"]];
                adView.button.adUrl = httpsArray[i - 1];
            }
            [adView.button addTarget:self action:@selector(clickADView:) forControlEvents:UIControlEventTouchUpInside];
        }
        contentSize = CGSizeMake((imageArray.count + 2) * self.frame.size.width,0);
        startPoint = CGPointMake(self.frame.size.width, 0);
        [self startTimer];  //设置定时器
        _mainPageControl.numberOfPages = imageArray.count;
    }
    else{ //无公告时
        OPADView * adView = [[OPADView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, ADHeight)];
        [_mainScrollView addSubview:adView];
        adView.titleImage.image = [UIImage imageNamed:@"Weatherbanner2"];
        adView.button.hidden = YES;
        adView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWeatherView)];
        [adView addGestureRecognizer:tap];
//        [adView addSubview:weatherWidget1];
        
        _mainPageControl.hidden = YES;
        contentSize = CGSizeMake(self.frame.size.width,0);
        startPoint = CGPointMake(self.frame.size.width, 0);
    }
    
    //开始的偏移量跟内容尺寸
    _mainScrollView.contentOffset = startPoint;
    _mainScrollView.contentSize = contentSize;
}
#pragma mark -- 点击广告页
- (void)clickADView:(OPADViewButton *)button {
    if ([button.adUrl componentsSeparatedByString:@"http://"] || [button.adUrl componentsSeparatedByString:@"https://"]) {
        LKBaseWebViewController *detailVC = [[LKBaseWebViewController alloc] init];
        detailVC.webURL = button.adUrl;
        [RootNaviControllerUtil pushViewController:detailVC animated:YES];
    }
}
#pragma mark -- 点击天气页
- (void)clickWeatherView {
    if (self.delegate) {
        [self.delegate skipWeatherView];
    }
}
#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < SCREEN_WIDTH) {
        [_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (imageArray.count + 1)) {
        [_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
    
    if (pageCount == imageArray.count + 1) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)imageArray.count - 1;
    }else{
        pageCount--;
    }
    _mainPageControl.currentPage = pageCount;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];    //停止计时
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self startTimer];      //开始计时
}

#pragma mark - 创建计时器和计时器重复事件
- (void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:4.6 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    CGPoint newOffset = CGPointMake(_mainScrollView.contentOffset.x  + CGRectGetWidth(_mainScrollView.frame), 0);
    [_mainScrollView setContentOffset:newOffset animated:YES];
}

//下拉通知的响应
- (void)contentOffsetToZero:(NSNotification *)sender {
    [_timer invalidate];
    CGFloat s = [(NSNumber *)sender.object floatValue];
    if (s <= 0) {
        CGFloat ratio = (CGRectGetHeight(mBannerImgVFrame) + (-s)) / CGRectGetHeight(mBannerImgVFrame);
        CGFloat deltaH = CGRectGetHeight(mBannerImgVFrame) * ratio - CGRectGetHeight(mBannerImgVFrame);
        
        _mainScrollView.frame = CGRectMake(0, - deltaH /2, SCREEN_WIDTH, CGRectGetHeight(mBannerImgVFrame) * ratio);
//        weatherWidget.frame = CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100 + deltaH /2, 130, 90);
//        weatherWidget1.frame = CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100 + deltaH /2, 130, 90);
//        weatherWidget2.frame = CGRectMake(SCREEN_WIDTH - 135, BottomForView(_mainScrollView) - 100 + deltaH /2, 130, 90);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_timer) {
        [_timer invalidate];
    }
}

@end
