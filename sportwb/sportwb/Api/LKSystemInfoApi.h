//
//  LKSystemInfoApi.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseApi.h"
@class LKSystemBaseModel;

/**系统服务相关的信息请求类*/
@interface LKSystemInfoApi : LKBaseApi

+(LKSystemInfoApi *)shareInstance;

/**检查伪装机制是否开启*/
- (NSURLSessionDataTask *)getApplictionDisguiseWithSuccessBlock:(void(^)(LKSystemBaseModel * model))success
                                                        failure:(ErrorBlock)failure;
@end
