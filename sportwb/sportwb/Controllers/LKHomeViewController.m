//
//  LKHomeViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKHomeViewController.h"
#import "LKHomeBannerView.h"
#import "LKSystemModel.h"
#import "LKADScrollView.h"

@interface LKHomeViewController ()<LKADScrollViewDelegate>{
    LKHomeBannerView       * _homeBannerView;
    UIScrollView            * _mScrollView;
    LKADScrollView                  * _adScrollView;

    UIView                  * _contentView;

}
@property (nonatomic,assign) CGRect                  mBannerImgVFrame;

@end

@implementation LKHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage * unselectImage = [UIImage imageNamed:@"tabbar_appointment_unselected"];
        UIImage * selectImage = [UIImage imageNamed:@"tabbar_appointment_selected"];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"首页" image:unselectImage selectedImage:selectImage];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = item;
        self.view.backgroundColor = [UIColor tangerineColor];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createControllerView];
}

- (void)createControllerView {
    _mScrollView = [UIScrollView new];
    _mScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mScrollView];
    [_mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT - 49 - 64));
    }];
    
    _contentView = [UIView new];
    _contentView.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    [_mScrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mScrollView);
        make.width.equalTo(_mScrollView);
    }];
    
    //banner
//    _homeBannerView = [LKHomeBannerView new];
//    [_contentView addSubview:_homeBannerView];
//    [_homeBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.width.equalTo(_contentView);
//        make.height.equalTo(_contentView.mas_width).multipliedBy(0.5);
//    }];
//    [_homeBannerView createBannerView];
    //    [_homeBannerView loadBannerDatas:@[@"QQ", @"WX", @"WB"]];//, @"ZFB"]];
    
    //流量使用情况
//    _dataMonitorView = [LKHomeDataMonitorView new];
//    [_contentView addSubview:_dataMonitorView];
//    [_dataMonitorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_homeBannerView.mas_bottom);
//        make.left.width.equalTo(_contentView);
//        make.height.equalTo(@217);
//    }];
//    [_dataMonitorView createDataMonitorView];
//    [_dataMonitorView loadViewParam:nil];
//
//    _rechargeView = [LKHomeRechargeView new];
//    CGFloat btW = (KSCREEN_WIDTH - 5)/4 * 1.5;
//
//    [_contentView addSubview:_rechargeView];
//    [_rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_dataMonitorView.mas_bottom).offset(6);
//        make.left.width.equalTo(_contentView);
//        make.height.equalTo(@(124 + btW));
//    }];
//    [_rechargeView createRechargeView];
    
    //常用软件
//    NSArray * scArray = @[@"QQ", @"WX", @"WB", @"ZFB", @"JD"];
//    _shortcutView = [LKHomeShortcutView new];
//    [_contentView addSubview:_shortcutView];
//    [_shortcutView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_rechargeView.mas_bottom).offset(6);
//        make.left.width.equalTo(_contentView);
//        //        make.bottom.equalTo(self.view);
//    }];
//    [_shortcutView createShortcutView];
//    [_shortcutView loadShortcutList:scArray];
//
//    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_shortcutView);
//    }];
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshADDataAndWeatherData" object:nil];
        [_adScrollView requestADImageInfo];
        
//        [self getDynamicHome];
        [self getNetworkOfData];

    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    _mScrollView.mj_header = header;
    [header beginRefreshing];
    
    self.mBannerImgVFrame = _adScrollView.frame;

}

- (void)getNetworkOfData {

    //TODO: 模拟数据
    [_homeBannerView loadBannerDatas:[self testOfBannerData]];
//    [_dataMonitorView loadViewParam:[self testOfFlowUsageInfo]];
    
    [_mScrollView.mj_header endRefreshing];
}

#pragma mark - 模拟数据
- (LKHomeBannerAdvertList *)testOfBannerData {
    //TODO: 测试数据
    LKHomeBannerAdvertList * listData = [LKHomeBannerAdvertList new];
    LKHomeBannerAdvertModel * model_1 = [LKHomeBannerAdvertModel new];
    model_1.aId = @"1";
    model_1.title = @"广告_1";
    model_1.url = @"http://xxxx.com/1.html";
    model_1.imgUrl = @"http://7xkszy.com2.z0.glb.qiniucdn.com/pics/vol/580a6f544dfba.jpg?imageView2/1/w/640/h/452";
    LKHomeBannerAdvertModel * model_2 = [LKHomeBannerAdvertModel new];
    model_2.aId = @"2";
    model_2.title = @"广告_2";
    model_2.url = @"http://xxxx.com/1.html";
    model_2.imgUrl = @"http://7xkszy.com2.z0.glb.qiniucdn.com/pics/vol/58051aeba7870.jpg?imageView2/1/w/640/h/452";
    LKHomeBannerAdvertModel * model_3 = [LKHomeBannerAdvertModel new];
    model_3.aId = @"3";
    model_3.title = @"广告_3";
    model_3.url = @"http://xxxx.com/1.html";
    model_3.imgUrl = @"http://img-cdn.luoo.net/pics/vol/583b045d826cb.jpg?imageView2/1/w/640/h/452";
    LKHomeBannerAdvertModel * model_4 = [LKHomeBannerAdvertModel new];
    model_4.aId = @"4";
    model_4.title = @"广告_4";
    model_4.url = @"http://xxxx.com/1.html";
    model_4.imgUrl = @"http://img-cdn.luoo.net/pics/vol/58406b4dd4509.jpg?imageView2/1/w/640/h/452";
    listData.dataList = @[model_1, model_2, model_3, model_4];
    
    return listData;
}

#pragma mark - 滚动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //主滚动图 下拉放大图片
    if (scrollView.tag == 1) {
        CGRect frame = _adScrollView.frame;
        if (scrollView.contentOffset.y <= 0) {
            NSNumber * SNumber = [NSNumber numberWithFloat:scrollView.contentOffset.y];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDropDown" object:SNumber];
            if (scrollView.contentOffset.y < 0) {
                _adScrollView.mainPageControl.hidden = YES;
            } else if (scrollView.contentOffset.y ==  0) {
                _adScrollView.mainPageControl.hidden = NO;
                _adScrollView.frame = frame;
            }
            CGFloat ratio = (CGRectGetHeight(self.mBannerImgVFrame) + (-scrollView.contentOffset.y)) / CGRectGetHeight(self.mBannerImgVFrame);
            CGFloat deltaH = CGRectGetHeight(self.mBannerImgVFrame) * ratio - CGRectGetHeight(self.mBannerImgVFrame);
            _adScrollView.frame = CGRectMake(0, - deltaH/2, SCREEN_WIDTH, CGRectGetHeight(self.mBannerImgVFrame) * ratio);
        }
    }
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
