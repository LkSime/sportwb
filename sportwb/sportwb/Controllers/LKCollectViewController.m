//
//  LKCollectViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/22.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKCollectViewController.h"
#import "LKNewsModel.h"
#import "LKNewsApi.h"
#import "LKWebTrueViewController.h"
#import "LKCollectCell.h"

@interface LKCollectViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * mTableView;
    NSMutableArray * mDataSource;
}

@property(assign) NSInteger mPageIndex;

@end

@implementation LKCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mDataSource = [NSMutableArray array];
    [self setTitle:@"心水收藏"];
    UIImage * _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = _backItem;
    
    [self getNetworkOfData:NO];
    [self createContentView];
}

- (void)createContentView {
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
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    mTableView.mj_header = header;
    mTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableView)];
    mTableView.mj_footer.hidden = YES;
}

-(void)refreshTableView{
    [self getNetworkOfData:NO];
}

-(void)loadMoreTableView{
//    [self getNetworkOfData:YES];
}

- (void)getNetworkOfData:(BOOL)isMore {
    if (isMore) {
        _mPageIndex ++;
    }else{
        _mPageIndex = 1;
    }
    [SVProgressHUD showWithStatus:@"正在加载。。。"];
    [[LKNewsApi shareInstance] getCollectListSuccessBlock:^(NSArray *mArray) {
        [SVProgressHUD dismiss];
        [mTableView.mj_header endRefreshing];
        [mTableView.mj_footer endRefreshing];
        
        if (isMore) {
            [mDataSource addObjectsFromArray:mArray];
        } else {
            [mDataSource removeAllObjects];
            [mDataSource addObjectsFromArray:mArray];
        }
        
        [mTableView reloadData];
    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
    return SCREEN_WIDTH * 0.4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * mr_identifer = @"LKCollectCell";
    LKCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:mr_identifer];
    if (cell == nil) {
        cell = [[LKCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mr_identifer];
    }
    [cell setNewsCellData:mDataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LKNewsSocialListModel * model = mDataSource[indexPath.row];
    LKWebTrueViewController * web = [LKWebTrueViewController new];
    web.webURL = model.newsUrl;
    if (model.title.length > 10) {
        model.title = [NSString stringWithFormat:@"%@...", [model.title substringToIndex:10]];
    }
    web.title = model.title;
    [UIUtils pushVC:web];
    
}
- (void)clickBackButton {
    [UIUtils popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
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
