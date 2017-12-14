//
//  PublicInfomation.m
//  penavicoxm
//
//  Created by jx on 14-11-19.
//  Copyright (c) 2014年 1ping.com. All rights reserved
//

#import "PublicFunction.h"
#import "SVProgressHUD.h"
//#import "NSString+MD5.h"
//#import "OPUserApi.h"
//#import "OPActionApi.h"
//#import "OPSystemInfoApi.h"
//#import "OPIMPrincipalModel.h"
//#import "OPIMChatViewController.h"

@interface PublicFunction()<UIAlertViewDelegate>

@end

@implementation PublicFunction

+ (PublicFunction *)shared
{
    static PublicFunction *sharedPublicFunction;
    
    @synchronized(self)
    {
        if (!sharedPublicFunction)
            sharedPublicFunction = [[PublicFunction alloc] init];
        
        return sharedPublicFunction;
    }
}


+ (NSString *)getLogFilePath{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *logPath = [docPath stringByAppendingPathComponent:@"onePingException.log"];
    return logPath;
}

+ (void)needLogin:(BOOL)isPopCurrentVC{
//    UIViewController *aVC = [UIUtils getCurrentVC];
//    NSArray *aArr = @[@"OPStartPageViewController",@"OPLoginViewController"];
//    if (![aArr containsObject:NSStringFromClass([aVC class])]) {
//        [SVProgressHUD dismiss];
//        [UIUtils pushVC:@"OPLoginViewController" withParam:nil];
//    }
}

+ (void)popVC:(UIViewController*)vc animated:(BOOL)animated{
    [SVProgressHUD dismiss];
    [vc.navigationController popViewControllerAnimated:animated];
}

+ (void)popVC:(UIViewController*)vc{
    [self popVC:vc animated:YES];
}

+ (void)showWaitingProgress{
    [SVProgressHUD showWithStatus:NSLocalizedStringFromEPing(@"common_loading")];
}

+ (void)dissProgress:(NSString*)message{
    if (message) {
        [SVProgressHUD showErrorWithStatus:message];
    }else{
        [SVProgressHUD dismiss];
    }
}

//保存对象到本地
+ (BOOL)saveToLocaleWithModel:(id)model useFileName:(NSString *)name
{
    // 获取目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:filePath]) {
        [fileMgr removeItemAtPath:filePath error:nil];
    }
    
    // 保存自定义对象(归档)
    return [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}

//从本地获取对象
+ (id)getFromLocaleWithName:(NSString *)name
{
    // 获取目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    // 解归档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (NSString*)getTokenWithParams:(NSDictionary*)params
{
    
    NSString *key = @"M#4zg^MBwB9fYmVRdbi!zw[8qEygTQ";
    
    NSMutableString* rawData = nil;
    rawData = [[NSMutableString alloc] init];
    [rawData appendString:key];
    if([params count] > 0 && key)
    {
        
        NSArray* allKeys = [params allKeys];
        NSMutableArray* mutableKeys = [NSMutableArray arrayWithArray:allKeys];
        [mutableKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSString* strKey1 = obj1;
            NSString* strKey2 = obj2;
            
            NSComparisonResult comResult = [strKey1 compare:strKey2];
            return comResult;
            
        }];
        
        for(NSInteger index = 0; index < [mutableKeys count]; ++index)
        {
            NSString* valueKey = [mutableKeys objectAtIndex:index];
            NSString* value = [NSString stringWithFormat:@"%@",[params objectForKey:valueKey]];
            [rawData appendString:valueKey];
            [rawData appendString:value];
        }
        
    }
    
    [rawData appendString:key];
    
    NSString* token = nil;
    if(rawData)
    {
//        token = [[rawData md5] uppercaseString];
    }
    return token;
}

- (void)showReviewTip{
//
//    if ([OPUserApi shareInstance].isNeedShowReviewTip) {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@""
//                                  message:NSLocalizedStringFromEPing(@"commnet_tip_app")
//                                  delegate:self
//                                  cancelButtonTitle:NSLocalizedStringFromEPing(@"comment_goto_comment_app")
//                                  otherButtonTitles:NSLocalizedStringFromEPing(@"comment_use_wait_times"),
//                                  nil];
//        alertView.cancelButtonIndex = 2;
//        [alertView show];
//    }
    
}

#pragma mark - 弹框代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
//            NSString *urlStr = [OPUserApi shareInstance].mUserContextModel.app_review.review_url;
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
            
        }
            break;
            
        default:
            break;
    }
}

/**联系客服*/
+ (void)linkEpingService:(NSString *)group_principal_id
                Business:(NSString *)business{
    
//    [[OPSystemInfoApi shareInstance] getCustomerServiceWithPrincipalId:nil GroupPrincipalId:group_principal_id Business:business Data:^(OPSystemCustomerModel *customerModel) {
//        if (IsEmpty(customerModel.principal_id)) {
//            return ;
//        }
//
//        OPIMPrincipalModel * model = [[OPIMPrincipalModel alloc]init];
//        model.principal_id         = IsEmpty(customerModel.principal_id)?@"0":customerModel.principal_id;
//        model.avatar               = customerModel.avatar;
//        model.is_friend            = customerModel.is_friend;//暂时给客服分在 1 组;
//        model.user_id              = [OPUserInfoManager sharedInstance].infoModel.userid;
//        model.principal_kind       = customerModel.principal_kind;
//        model.principal_kind_url   = customerModel.principal_kind_url;
//        model.user_id              = customerModel.user_id;
//        model.source_id            = customerModel.source_id;
//        model.showname             = customerModel.showname;
//        model.nickname             = customerModel.nickname;
//        model.cs_role              = customerModel.cs_role;
//        model.group_principal_id   = IsEmpty(customerModel.group_principal_id)?@"0":customerModel.group_principal_id;
//        [model saveOrUpdate];
//
//        [OPIMPrincipalModel getPrincipalInfo:model.group_principal_id withGroupId:nil WithInfo:^(OPIMPrincipalModel *model) {
//
//            OPIMChatViewController * chatCntler = [[OPIMChatViewController alloc] initWithTitle:model.showname?model.showname:model.nickname PrincipalId:customerModel.principal_id PrincipalKind:model.principal_kind GroupId:customerModel.group_principal_id];
//            [UIUtils pushVC:chatCntler];
//        }];
//
//    } withErrorBlock:^(NSString *errMsg, NSInteger errCode) {
//        [SVProgressHUD showErrorWithStatus:NSLocalizedStringFromEPing(@"more_fb_link_service_error")];
//    }];

}

@end
