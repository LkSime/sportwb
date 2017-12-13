//
//  LKHomeViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKHomeViewController.h"
#import "LKSystemModel.h"
#import "LKADScrollView.h"
#import "LKTHomeMediaCell.h"
#import "LKNewsModel.h"
#import "LKNewsApi.h"
#import "LKWebTrueViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface LKHomeViewController ()<LKADScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    LKADScrollView          * _adScrollView;
    UITableView             * mTableView;
    NSArray                 * mDataSource;
}

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

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mDataSource = [NSArray array];
    
    [self createControllerView];
}

- (void)createControllerView {
    mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.showsVerticalScrollIndicator = NO;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.backgroundColor = COLOR_FOR_BACKGROUND_F2;
    [self.view addSubview:mTableView];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT - 64));
    }];

    _adScrollView = [[LKADScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADHeight)];
    mTableView.tableHeaderView = _adScrollView;
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self getNetworkOfData];
    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    mTableView.mj_header = header;
    [header beginRefreshing];
    
}

- (void)getNetworkOfData {
    [[LKNewsApi shareInstance] getMediaListSuccessBlock:^(NSArray *mArray) {
        mDataSource = [mArray copy];
        [mTableView reloadData];
    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
        
    }];
    [mTableView.mj_header endRefreshing];
}

#pragma mark - UITableViewDelegate$DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADHeight + 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * mr_identifer = @"LKTHomeMediaCell";
    LKTHomeMediaCell * cell = [tableView dequeueReusableCellWithIdentifier:mr_identifer];
    if (cell == nil) {
        cell = [[LKTHomeMediaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mr_identifer];
    }
    [cell setMediaCellData:mDataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    LKNewsSocialListModel * model = mDataSource[indexPath.row];
    AVPlayerViewController * playerVC = [AVPlayerViewController new];
    playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:model.media]];
    [self presentViewController:playerVC animated:YES completion:nil];
    [playerVC.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
