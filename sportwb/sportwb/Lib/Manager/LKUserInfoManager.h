//
//  LKUserInfoManager.h
//  sportwb
//
//  Created by LkSime on 2017/12/20.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKUserModel.h"

#define USER_LOGIN_TYPE @"logintype"

@interface LKUserInfoManager : NSObject
typedef void (^ErrorBlk)(int code, NSString * err);

//用户信息
@property(nonatomic,strong) LKUserModel * infoModel;
//用户主体信息缓存
@property(nonatomic,strong) NSMutableDictionary *pirncipalInfoDic;

+ (LKUserInfoManager *)sharedInstance;

//设置用户信息
-(BOOL)setAndUpdateUserInfoWithDictionary:(NSDictionary*)dicData;


//是否登录
-(BOOL)isLogin;

-(NSDictionary *)getUserInfoFromFile;

//清除用户信息
-(void)clean;

@end
