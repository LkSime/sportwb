//
//  LKHomeBannerView.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKHomeBannerView.h"
#import "UIImageView+WebCache.h"
#import "LKSystemModel.h"

@interface LKHomeBNView : UIView
@property (nonatomic, copy) NSString * actionUrl;
- (void)createBannerImage:(NSString *)imageUrl;
@end

@implementation LKHomeBNView

- (void)createBannerImage:(NSString *)imageUrl{
    UIImageView * bannerImage = [UIImageView new];
    [bannerImage setContentMode:UIViewContentModeScaleAspectFill];
    bannerImage.userInteractionEnabled = YES;
    [bannerImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"banner_default"]];
    [self addSubview:bannerImage];
    [bannerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(self);
        make.height.equalTo(@153);
    }];
    
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForBanner)];
    [self addGestureRecognizer:tgr];
}
- (void)actionForBanner {
//    LKBaseWebViewController * webVC = [LKBaseWebViewController new];
//    webVC.newsURL = @"http://www.163.com";
//    [RootNaviControllerUtil pushViewController:webVC animated:YES];
}
@end

@interface LKHomeBannerView ()<UIScrollViewDelegate> {
    UIScrollView * _mScrollView;
    NSMutableArray * _datasArray;
    UIPageControl * _mainPageControl;
    NSTimer *_timer;
    
}

@end

@implementation LKHomeBannerView

- (void)createBannerView{
    [_timer invalidate];
    
    _mScrollView = [UIScrollView new];
    _mScrollView.pagingEnabled = YES;
    _mScrollView.delegate = self;
    _mScrollView.contentOffset = CGPointZero;
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.backgroundColor = COLOR_FOR_CLEAR;
    [self addSubview:_mScrollView];
    [_mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.height.equalTo(self);
        make.width.equalTo(self);
    }];
    _mainPageControl = [[UIPageControl alloc] init];
    _mainPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _mainPageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.67];
    _mainPageControl.enabled = NO;
    [self addSubview:_mainPageControl];
    [_mainPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@10);
        make.bottom.equalTo(self).offset(-4);
    }];
}

- (void)loadBannerDatas:(LKHomeBannerAdvertList *)datasArray {
    if (IsEmpty(datasArray.dataList)) {
        return;
    }
    _datasArray = [datasArray.dataList mutableCopy];
    if (datasArray.dataList.count > 1) {
        [_datasArray addObject:datasArray.dataList.firstObject];
        [_datasArray insertObject:datasArray.dataList.lastObject atIndex:0];
        [self startTimer];      //开始计时
        _mainPageControl.numberOfPages = datasArray.dataList.count;
    } else {
        _mainPageControl.numberOfPages = 0;
        [_timer invalidate];
    }
    
    //清除上一次数据
    [_mScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor greenSeaColor];
    [_mScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_mScrollView);
        make.height.equalTo(_mScrollView);
    }];
    
    UIView * lastView = [[UIView alloc] initWithFrame:CGRectZero];
    [contentView addSubview:lastView];
    
    for (NSInteger i = 0; i < _datasArray.count; i++) {
        LKHomeBNView * bannerView = [LKHomeBNView new];
        [contentView addSubview:bannerView];
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView.mas_right);
            make.top.equalTo(@0);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@153);
        }];
        LKHomeBannerAdvertModel * model = _datasArray[i];
        bannerView.actionUrl = model.url;
        
        [bannerView createBannerImage:model.imgUrl];
        lastView = bannerView;
    }
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView);
    }];
    
    //开始的偏移量跟内容尺寸
    _mScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _mScrollView.contentSize = CGSizeMake(_datasArray.count * SCREEN_WIDTH,0);
}

#pragma mark UIScrollView的代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_datasArray.count < 2) {
        return;
    }
    if (scrollView.contentOffset.x < SCREEN_WIDTH) {
        [_mScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (_datasArray.count - 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (_datasArray.count - 1)) {
        [_mScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    if (pageCount == _datasArray.count - 1) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)_datasArray.count - 3;
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
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    CGPoint newOffset = CGPointMake(_mScrollView.contentOffset.x  + CGRectGetWidth(_mScrollView.frame), 0);
    [_mScrollView setContentOffset:newOffset animated:YES];
}

@end
