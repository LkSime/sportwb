//
//  LKUserInfoManager.m
//  sportwb
//
//  Created by LkSime on 2017/12/20.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKUserInfoManager.h"

#define USER_INFO_PLIST      @"usr_info.plist"

@interface LKUserInfoManager(){
    
    typeof (void(^)(BOOL login)) loginSuccessBlock;
    ErrorBlk loginFaileBlock;
    
}

//用户信息
@property(nonatomic,strong)NSMutableDictionary *infoDicData;

@end
@implementation LKUserInfoManager

+ (LKUserInfoManager *)sharedInstance
{
    static LKUserInfoManager *instance;
    @synchronized(self)
    {
        if (!instance)
        {
            instance = [[LKUserInfoManager alloc] init];
            instance.infoDicData = [NSMutableDictionary new];
            instance.pirncipalInfoDic = [NSMutableDictionary new];
            //获取本地用户信息
            [instance getUserInfoFromFile];
        }
        return instance;
    }
}

//设置用户信息
-(BOOL)setAndUpdateUserInfoWithDictionary:(NSDictionary*)dicData{
    
    if (IsEmpty(dicData)) {
        return NO;
    }
    
    //设置用户信息
    [self.infoDicData setValuesForKeysWithDictionary:dicData];
    
    NSError *error = nil;
    LKUserModel *usrInfo = [MTLJSONAdapter modelOfClass:LKUserModel.class fromJSONDictionary:self.infoDicData error:&error];
    if (IsEmpty(usrInfo)) {
        return NO;
    }
    //设置用户信息
    self.infoModel = usrInfo;
    
    //更新本地数据
    [self saveUserInfoToFlieWithDictionary];
    return YES;
}


///是否登录
-(BOOL)isLogin{
    return !IsEmpty(self.infoModel);
}

//清除用户信息
-(void)clean{
    self.infoModel = nil;
    self.infoDicData = [NSMutableDictionary new];
    
    {

        // 删除本地文件
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_PLIST];
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:&error];
        
        //登出
//        [OPNotifyManager postNotificationWithName:Notify_User_Logout];
    }
}

//保存用户信息到本地
-(void)saveUserInfoToFlieWithDictionary{
    NSMutableDictionary *_mdictData = [[NSMutableDictionary alloc] init];
    NSEnumerator *enumerator = [self.infoDicData keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        if ([self.infoDicData objectForKey:key] != [NSNull null]) {
            [_mdictData setObject:[self.infoDicData objectForKey:key] forKey:key];
        }
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_PLIST];
    [_mdictData writeToFile:filePath atomically:YES];
}

//获取本地缓存用户信息
- (NSDictionary*)getUserInfoFromFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:USER_INFO_PLIST];
    
    NSDictionary *_mdictData = [[[NSDictionary alloc] initWithContentsOfFile:filePath] mutableCopy];
    if (_mdictData) {
        NSError *error = nil;
        self.infoModel = [MTLJSONAdapter modelOfClass:LKUserModel.class fromJSONDictionary:_mdictData error:&error];
        [self.infoDicData setValuesForKeysWithDictionary:_mdictData];
    }
    return _mdictData;
}

@end
