//
//  OPMoreViewController.m
//  oneping
//
//  Created by 吴星煜 on 14-9-18.
//  Copyright (c) 2014年 1ping.com. All rights reserved.
//

#import "OPMoreViewController.h"
#import "LKWebTrueViewController.h"
#import "SDWebImageManager.h"
#import "OPFeedbackViewController.h"
#import "LKLieViewController.h"
#import "LKUserInfoManager.h"

#define GAP                     20.0f
#define BTN_HEIGHT              40.0f

@interface OPMoreViewController ()<UIAlertViewDelegate>
{
    UILabel         *_lbVer;
    
//    OPVersionModel  *_newVer;
}

@property (nonatomic,weak) UIButton *btnLogout;

@end

@implementation OPMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"设置"];
    UIImage * _backImage = [[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    [_backButton setImage:_backImage forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [_backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * _backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = _backItem;
    
    
    UIImageView *imgvArrow1 = [[UIImageView alloc] init];
    imgvArrow1.frame = CGRectMake(SCREEN_WIDTH - 25, (BTN_HEIGHT - 15) / 2, 8, 15);
    imgvArrow1.image = [UIImage imageNamed:@"right_arrow"];
    
    UIImageView *imgvArrow2 = [[UIImageView alloc] init];
    imgvArrow2.frame = CGRectMake(SCREEN_WIDTH - 25, (BTN_HEIGHT - 15) / 2, 8, 15);
    imgvArrow2.image = [UIImage imageNamed:@"right_arrow"];
    
    UIImageView *imgvArrow3 = [[UIImageView alloc] init];
    imgvArrow3.frame = CGRectMake(SCREEN_WIDTH - 25, (BTN_HEIGHT - 15) / 2, 8, 15);
    imgvArrow3.image = [UIImage imageNamed:@"right_arrow"];
    
    _lbVer = [[UILabel alloc] init];
    _lbVer.frame = CGRectMake(WidthForView(self.view) - 150 - 10, 0, 140, BTN_HEIGHT);
    _lbVer.textColor = COLOR_FOR_TEXT_80;
    _lbVer.font = [UIFont systemFontOfSize:13.0f];
    _lbVer.textAlignment = NSTextAlignmentRight;
    NSString *verStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//CFBundleShortVersionString  CFBundleVersion
    
    verStr = @"1.2.0";

    _lbVer.text = [NSString stringWithFormat:@"%@ %@", @"当前版本：", verStr];
    
    LKUserModel * model = [LKUserInfoManager sharedInstance].infoModel;
    NSMutableArray * arryTitles = [NSMutableArray array];
    NSMutableArray * arryGap = [NSMutableArray array];
    NSMutableArray * arryContent = [NSMutableArray array];
    if (model.isLogin) {
        arryTitles = [NSMutableArray arrayWithObjects:@"关于我们", @"清理缓存", @"使用帮助", @"版本信息", @"退出",nil];
        arryGap = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        arryContent = [NSMutableArray arrayWithObjects:imgvArrow1, imgvArrow2, imgvArrow3, _lbVer, [NSNull null], [NSNull null], nil];
    } else {
        arryTitles = [NSMutableArray arrayWithObjects:@"关于我们", @"清理缓存", @"使用帮助", @"版本信息", nil];
        arryGap = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        arryContent = [NSMutableArray arrayWithObjects:imgvArrow1, imgvArrow2, imgvArrow3, _lbVer, [NSNull null], nil];
    }

    
    CGFloat fLastY = 0;
    
    for (int i = 0; i < [arryTitles count]; i ++) {
        NSInteger   iGap = [[arryGap objectAtIndex:i] integerValue];
        UIView      *contentV = [arryContent objectAtIndex:i];
        
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, fLastY + iGap, WidthForView(self.view), BTN_HEIGHT)];
        bgV.backgroundColor = [UIColor whiteColor];
        
        {
            NSString *strTtile = [arryTitles objectAtIndex:i];
            UILabel *lbTtile = [[UILabel alloc] init];
            lbTtile.frame = CGRectMake(10, 0, 70, HeightForView(bgV));
            lbTtile.text = strTtile;
            lbTtile.textColor = COLOR_FOR_TEXT_33;
            lbTtile.font = [UIFont systemFontOfSize:14.0f];
            [bgV addSubview:lbTtile];
            
            if (NO == IsEmpty(contentV)) {
                [bgV addSubview:contentV];
            }
            
            UIButton *btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
            btnClear.frame = CGRectMake(0, 0, WidthForView(bgV), HeightForView(bgV));
            btnClear.backgroundColor = [UIColor clearColor];
            btnClear.tag = i;
            [btnClear addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 3) {//版本检查不可点击
                btnClear.enabled = NO;
            }
            [bgV addSubview:btnClear];
            
        }
        
        [self.view addSubview:bgV];
        
        fLastY = BottomForView(bgV);
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    switch (btn.tag) {
        case 0:
        {
            // 关于我们
            LKWebTrueViewController *webVC = [[LKWebTrueViewController alloc] init];
            webVC.webURL = @"";
            webVC.title = @"关于我们";
            [UIUtils pushVC:webVC];
        }
            break;
        case 1:
        {
            // 清除缓存
            [SVProgressHUD showWithStatus:@"清理缓存"];
            
            float delayInSeconds = 0.3;
            dispatch_time_t delalyTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(delalyTime, dispatch_get_main_queue(), ^{
                
                NSString *folderPath = [NSTemporaryDirectory() stringByAppendingPathComponent:Audio_Load_Path];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSError *error;
                if(![fileManager contentsOfDirectoryAtPath:folderPath error:nil])
                    [fileManager createDirectoryAtPath:folderPath
                           withIntermediateDirectories:YES
                                            attributes:nil
                                                 error:&error];
                [fileManager removeItemAtPath:folderPath error:nil];
                [SVProgressHUD dismiss];
                
            });
        }
            break;
        case 2:
        {
            LKLieViewController * lieVC = [LKLieViewController new];
            [UIUtils pushVC:lieVC];
        }
            break;
        case 4:
        {
            [[LKUserInfoManager sharedInstance] clean];
            [UIUtils popViewControllerAnimated:YES];
        }
            break;
        case 3:
            
        default:
            break;
    }
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

@end
