//
//  PublicInfomation.m
//  penavicoxm
//
//  Created by jx on 14-11-19.
//  Copyright (c) 2014年 1ping.com. All rights reserved
//

#import "PublicInfomation.h"
//#import "OPDBHelper.h"
//#import "OPLetterModel.h"
//#import "OPFriendModel.h"
//#import <ImSDK/ImSDK.h>

@implementation PublicInfomation


+ (PublicInfomation *)shared
{
    __strong static PublicInfomation *sharedPublicInfomation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
			sharedPublicInfomation = [[PublicInfomation alloc] init];
#ifdef DEBUG
//            sharedPublicInfomation.is_product         = YES;
//            sharedPublicInfomation.base_url_build     = @"https://api.1ping.com";
//            sharedPublicInfomation.base_html_url      = @"http://m.1ping.com";
//            sharedPublicInfomation.base_html_urlheard = @"m.1ping.com";
        
///////////////////////////////////测试环境////////////////////////////////////////////
            
            sharedPublicInfomation.is_product         = NO;
            sharedPublicInfomation.base_url_build     = @"http://117.29.166.222:8090";
            sharedPublicInfomation.base_html_url      = @"http://117.29.166.222:8091";
            sharedPublicInfomation.base_html_urlheard = @"117.29.166.222";

////////////////////////////////////预发布环境/////////////////////////////////////////
//            sharedPublicInfomation.is_product         = NO;
//            sharedPublicInfomation.base_url_build     = @"http://119.29.137.108:8090";
//            sharedPublicInfomation.base_html_url      = @"http://m.1ping.com";
//            sharedPublicInfomation.base_html_urlheard = @"m.1ping.com";

#else
            sharedPublicInfomation.is_product         = YES;
            sharedPublicInfomation.base_url_build     = @"https://api.1ping.com";
            sharedPublicInfomation.base_html_url      = @"http://m.1ping.com";
            sharedPublicInfomation.base_html_urlheard = @"m.1ping.com";
#endif
    });
		return sharedPublicInfomation;
}


+(void)initDB{
//    DBHelper *aDBHelper = [DBHelper getInstance];
//    [aDBHelper createDbTableWithModel:TIMChatListModel.class];  //im 会话列表数据表
//    [aDBHelper createDbTableWithModel:OPFriendIMUserModel.class];//IM 通讯录用户信息表
}

@end
