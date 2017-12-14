//
//  LKNewsViewController.m
//  sportwb
//
//  Created by LkSime on 2017/12/11.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKNewsViewController.h"
#import "LKNewsModel.h"
#import "LKNewsApi.h"
#import "LKWebTrueViewController.h"
#import "LKNewsCell.h"

@interface LKNewsViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * mTableView;
    NSMutableArray * mDataSource;
}
@property(assign) NSInteger mPageIndex;

@end

@implementation LKNewsViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage * unselectImage = [UIImage imageNamed:@"tabbar_message_unselected"];
        UIImage * selectImage = [UIImage imageNamed:@"tabbar_message_selected"];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"资讯"
                                                           image:unselectImage selectedImage:selectImage];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = item;
        self.view.backgroundColor = [UIColor silverColor];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    mDataSource = [NSMutableArray array];
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
        make.height.equalTo(@(SCREEN_HEIGHT));
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
    [self getNetworkOfData:YES];
}

- (void)getNetworkOfData:(BOOL)isMore {
    if (isMore) {
        _mPageIndex ++;
    }else{
        _mPageIndex = 1;
    }
    
    [[LKNewsApi shareInstance] getSocialOfNewsIndex:_mPageIndex page_size:10 withSuccessBlock:^(NSArray *mArray) {
        [mTableView.mj_header endRefreshing];
        [mTableView.mj_header endRefreshing];
        
        if (isMore) {
            [mDataSource addObjectsFromArray:mArray];
        } else {
            [mDataSource removeAllObjects];
            [mDataSource addObjectsFromArray:mArray];
        }
        
        [mTableView reloadData];
    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
        NSLog(@"%@", errMsg);
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
    NSString * mr_identifer = @"LKNewsCell";
    LKNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:mr_identifer];
    if (cell == nil) {
        cell = [[LKNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mr_identifer];
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
