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
#import "LKWebTrueViewController.h"


@interface LKADScrollView ()<UIScrollViewDelegate> {
    
    NSMutableArray * imageArray;
    NSMutableArray * httpsArray;
    OPADView * backgroundView;
    UIImageView *mBannerImgV;
    CGRect mBannerImgVFrame;
    UIPageControl * _mainPageControl;

    NSTimer *_timer;
    NSTimeInterval _duration;
}

@end

@implementation LKADScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        imageArray = [NSMutableArray arrayWithObjects:
                      @"sport_image1",
                      @"sport_image2",
                      @"sport_image3",
                      @"sport_image4",
                      @"sport_image5", nil];
        httpsArray = [NSMutableArray arrayWithObjects:
                      @"http://sports.sina.com.cn/g/pl/2017-12-11/doc-ifypnqvn2891960.shtml",
                      @"http://sports.sina.com.cn/g/pl/2017-12-11/doc-ifypnyqi3782870.shtml",
                      @"http://sports.sina.com.cn/g/laliga/2017-12-11/doc-ifypnqvn3261932.shtml",
                      @"http://sports.qq.com/a/20171206/010616.htm",
                      @"http://sports.qq.com/a/20171212/017689.htm", nil];
        
        _mainScrollView  = [[UIScrollView alloc] initWithFrame:frame];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentOffset = CGPointZero;
        _mainScrollView.backgroundColor = COLOR_FOR_GRAY;
        [self addSubview:_mainScrollView];
        [self createADView];

        
        _mainPageControl = [[UIPageControl alloc] init];
        _mainPageControl.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        _mainPageControl.center = CGPointMake(SCREEN_WIDTH /2, self.bounds.size.height - 12);
        _mainPageControl.numberOfPages = 5;
        [self addSubview:_mainPageControl];
        
        mBannerImgVFrame = frame;
    }
    return self;
}

#pragma mark -- 获取公告信息
- (void)createADView {
    CGSize contentSize;
    CGPoint startPoint;

        for (NSInteger i = 0; i < imageArray.count + 2; i++) {
            OPADView * adView = [[OPADView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, ADHeight)];
            [_mainScrollView addSubview:adView];
            if (i == 0) {
                adView.titleImage.image = [UIImage imageNamed:imageArray.lastObject];
                adView.button.adUrl = httpsArray.lastObject;

            } else if (i == imageArray.count + 1) {
                adView.titleImage.image = [UIImage imageNamed:imageArray.firstObject];
                adView.button.adUrl = httpsArray.firstObject;
            } else {
                adView.titleImage.image = [UIImage imageNamed:imageArray[i-1]];
                adView.button.adUrl = httpsArray[i-1];
            }
            [adView.button addTarget:self action:@selector(clickADView:) forControlEvents:UIControlEventTouchUpInside];
        }
        contentSize = CGSizeMake((imageArray.count + 2) * self.frame.size.width,0);
        startPoint = CGPointMake(self.frame.size.width, 0);
        [self startTimer];  //设置定时器

    //开始的偏移量跟内容尺寸
    _mainScrollView.contentOffset = startPoint;
    _mainScrollView.contentSize = contentSize;
}
#pragma mark -- 点击广告页
- (void)clickADView:(OPADViewButton *)button {
    LKWebTrueViewController *detailVC = [[LKWebTrueViewController alloc] init];
    detailVC.webURL = button.adUrl;
    detailVC.title = @"体坛快讯";
    [UIUtils pushVC:detailVC];
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

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
    }
}

@end
