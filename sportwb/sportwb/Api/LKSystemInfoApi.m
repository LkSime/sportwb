//
//  LKSystemInfoApi.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKSystemInfoApi.h"
#import "LKSystemModel.h"

@implementation LKSystemInfoApi

+(LKSystemInfoApi *)shareInstance {
    __strong static LKSystemInfoApi *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**检查伪装机制是否开启*/
- (NSURLSessionDataTask *)getApplictionDisguiseWithSuccessBlock:(void(^)(LKSystemBaseModel * model))success
                                                        failure:(ErrorBlock)failure {
    
    return [self getWithUrl:APIGET_Application_Disguise params:nil success:^(id data, LKCommonDataModel *dataModel) {
        NSError * error = nil;
        LKSystemBaseModel * bModel = [MTLJSONAdapter modelOfClass:[LKSystemBaseModel class]
                                               fromJSONDictionary:data error:&error];
        success(bModel);
    } failure:^(NSString *errMsg, NSInteger errCode) {
        failure(errMsg, errCode);
    }];
}
@end
