//
//  OPMoreViewController.m
//  oneping
//
//  Created by 吴星煜 on 14-9-18.
//  Copyright (c) 2014年 1ping.com. All rights reserved.
//

#import "OPMoreViewController.h"
//#import "IMXUtils.h"
//#import "OPGeneralWebViewController.h"
//#import "OPMoreApi.h"
//#import "SVProgressHUD.h"
#import "SDWebImageManager.h"
#import "OPFeedbackViewController.h"
//#import "OPUserApi.h"
//#import "OPCrashLogVC.h"

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:NSLocalizedStringFromEPing(@"user_account_sets")];
//    self.mmContentView.backgroundColor = COLOR_BACKGROUND;
    self.mmContentView.frame = CGRectMake(self.mmContentView.frame.origin.x, self.mmContentView.frame.origin.y, self.mmContentView.frame.size.width, self.mmContentView.frame.size.height);
    
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
    _lbVer.frame = CGRectMake(WidthForView(self.mmContentView) - 150 - 10, 0, 140, BTN_HEIGHT);
    _lbVer.textColor = COLOR_FOR_TEXT_80;
    _lbVer.font = [UIFont systemFontOfSize:13.0f];
    _lbVer.textAlignment = NSTextAlignmentRight;
    NSString *verStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//CFBundleShortVersionString  CFBundleVersion
    //TODO: 为与产品开发命名一致，设版本号为2.2.8
    
    verStr = @"2.2.8";

    _lbVer.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedStringFromEPing(@"more_version"), verStr];
    
    NSArray *arryTitles = [[NSArray alloc] initWithObjects:NSLocalizedStringFromEPing(@"more_aboutus"), NSLocalizedStringFromEPing(@"more_cleancache"), NSLocalizedStringFromEPing(@"more_help"), NSLocalizedStringFromEPing(@"more_vercheck"),nil];
    NSArray *arryGap = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
    NSArray *arryContent = [[NSArray alloc] initWithObjects:imgvArrow1, imgvArrow2, imgvArrow3, _lbVer, [NSNull null], nil];
    
    CGFloat fLastY = 0;
    
    for (int i = 0; i < [arryTitles count]; i ++) {
        NSInteger   iGap = [[arryGap objectAtIndex:i] integerValue];
        UIView      *contentV = [arryContent objectAtIndex:i];
        
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, fLastY + iGap, WidthForView(self.mmContentView), BTN_HEIGHT)];
        bgV.backgroundColor = [UIColor whiteColor];
        
        {
            NSString *strTtile = [arryTitles objectAtIndex:i];
            OPLabel *lbTtile = [[OPLabel alloc] init];
            lbTtile.frame = CGRectMake(10, 0, 70, HeightForView(bgV));
            lbTtile.text = strTtile;
            lbTtile.textColor = COLOR_BLACK_TEXT33;
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
        
        [self.mmContentView addSubview:bgV];
        
        fLastY = BottomForView(bgV);
    }
    
    if ([[OPUserInfoManager sharedInstance] isLogin]) {
        UIButton *btnLogout = [[UIButton alloc] init];
        btnLogout.frame = CGRectMake(0, fLastY + 20, SCREEN_WIDTH, 40);
        btnLogout.backgroundColor = [UIColor whiteColor];
        btnLogout.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnLogout setTitleColor:COLOR_BLACK_TEXT33 forState:UIControlStateNormal];
        [btnLogout setTitle:NSLocalizedStringFromEPing(@"user_logout_string") forState:UIControlStateNormal];
        [btnLogout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [self.mmContentView addSubview:btnLogout];
        self.btnLogout = btnLogout;
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[OPUserInfoManager sharedInstance] isLogin]) {
        
        self.btnLogout.hidden = NO;
        
    }else{
        
        self.btnLogout.hidden = YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)isNeedLeftBarItem
{
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        //立即更新
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:_newVer.url]];
    }
}


#pragma mark - private functions

- (void)logout {
    [SVProgressHUD showWithStatus:NSLocalizedStringFromEPing(@"common_loading")];
    
    [[OPUserApi shareInstance]logoutWithSuccessBlock:^{
        [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromEPing(@"user_logout_string")];
        [OPNotifyManager postNotificationWithName:OPNotifyUserLogout];
        [IMXUtils delayThread:^{
            [UIUtils popViewControllerAnimated:YES];
        }];
    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
        
    }];
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    switch (btn.tag) {
        case 0:
        {
            // 关于我们
            OPGeneralWebViewController *webVC = [[OPGeneralWebViewController alloc] init];
            webVC.newsURL = @"http://www.1ping.com/mbintro";
            webVC.titleStr = NSLocalizedStringFromEPing(@"more_aboutus");
            [UIUtils pushVC:webVC];
        }
            break;
        case 1:
        {
            // 清除缓存
            [SVProgressHUD showWithStatus:NSLocalizedStringFromEPing(@"common_loading")];
            
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
                
                //清除天气数据
                // 获取目录
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *weatherFilePath = [docPath stringByAppendingPathComponent:@"weatherData.1ping"];
                NSString *weatherInfoFilePath = [docPath stringByAppendingPathComponent:@"weatherInfoData.1ping"];
                OPLog(@"%@", docPath);
                
                NSFileManager *fileMgr = [NSFileManager defaultManager];
                
                if ([fileMgr fileExistsAtPath:weatherFilePath]) {
                    [fileMgr removeItemAtPath:weatherFilePath error:nil];
                }
                
                if ([fileMgr fileExistsAtPath:weatherInfoFilePath]) {
                    [fileMgr removeItemAtPath:weatherInfoFilePath error:nil];
                }
                
                //清除图片缓存
                [[SDWebImageManager sharedManager].imageCache clearDisk];
                [[SDImageCache sharedImageCache] clearDisk];
                [[SDImageCache sharedImageCache] clearMemory];//可有可无
                
                [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromEPing(@"more_clear")];
            });
        }
            break;
        case 2:
        {
            // 使用说明
            OPGeneralWebViewController *webVC = [[OPGeneralWebViewController alloc] init];
            webVC.newsURL = [NSString stringWithFormat:@"%@/file/instruction.html",BASE_HTML_URL];
            webVC.titleStr = NSLocalizedStringFromEPing(@"more_help");
            [UIUtils pushVC:webVC];
            
        }
            break;
        case 3:
        default:
        {
            // 使用说明
            OPGeneralWebViewController *webVC = [[OPGeneralWebViewController alloc] init];
            webVC.newsURL = [NSString stringWithFormat:@"%@/file/instruction.html",BASE_HTML_URL];
            webVC.titleStr = NSLocalizedStringFromEPing(@"more_help");
            [UIUtils pushVC:webVC];
        }
            break;
    }
}



@end
