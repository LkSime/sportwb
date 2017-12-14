//
//  LKBaseApi.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseApi.h"
#import "AFAppClient.h"
//#import "LKDeviceUtils.h"
#import "LKParamsUtils.h"

//网络请求错误
#define err_code_net -10000
//返回json数据为空
#define err_code_null -9999
//网络请求成功
#define success_code 0

@implementation LKBaseApi

-(NSURLSessionDataTask*)getWithUrl:(NSString*)url
                            params:(NSDictionary *)paramsDic
                           success:(BaseSuccessBlk)successBlk
                           failure:(ErrorBlock)errorBlk{
    return [self getWithUrl:url params:paramsDic progress:nil success:successBlk failure:errorBlk];
}

-(NSURLSessionDataTask*)getWithUrl:(NSString*)url
                            params:(NSDictionary *)paramsDic
                          progress:(void(^)(NSProgress * progress))downloadProgress
                           success:(BaseSuccessBlk)successBlk
                           failure:(ErrorBlock)errorBlk{
    
    //参数处理
    paramsDic = [self createParams:paramsDic];

#ifdef DEBUG
    NSString *paramsStr = @"";
    for (NSString *key in paramsDic) {
        paramsStr = [NSString stringWithFormat:@"%@=%@&%@",key,[paramsDic objectForKey:key],paramsStr];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",url,paramsStr];
    NSLog(@"用户端请求URL ： %@",requestUrl);
#endif
    
    NSURLSessionDataTask *dataTask = nil;
    @try {
            //先截取字符串，拿到第一个字符
//            NSString *firstStr = [url substringToIndex:1];
//            if (![@"/"isEqualToString:firstStr]) {
//                url = [NSString stringWithFormat:@"/%@",url];
//            }
       dataTask = [[AFAppClient shared]GET:url parameters:paramsDic
                        progress:downloadProgress
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             //成功处理
                             [self successWithResponseObject:responseObject success:successBlk failure:errorBlk];
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             //失败
                             errorBlk([error localizedDescription],err_code_net);
                         }];
    }
    @catch (NSException *exception) {
        errorBlk(exception.name,err_code_net);
    }
    @finally {
        return dataTask;
    }
    
}

-(NSURLSessionDataTask*)postWithUrl:(NSString*)url
                             params:(NSDictionary *)paramsDic
                            success:(BaseSuccessBlk)successBlk
                            failure:(ErrorBlock)errorBlk{
    return [self postWithUrl:url params:paramsDic uploadFile:nil progress:nil success:successBlk failure:errorBlk];
}

-(NSURLSessionDataTask*)postWithUrl:(NSString*)url
                             params:(NSDictionary *)paramsDic
                           progress:(void(^)(NSProgress *progress)) uploadProgress
                            success:(BaseSuccessBlk)successBlk
                            failure:(ErrorBlock)errorBlk{
    return [self postWithUrl:url params:paramsDic uploadFile:nil progress:uploadProgress success:successBlk failure:errorBlk];
}

-(NSURLSessionDataTask*)postWithUrl:(NSString*)url
                             params:(NSDictionary *)paramsDic
                         uploadFile:(NSArray *)fileDic
                           progress:(void(^)(NSProgress *progress))uploadProgress
                            success:(BaseSuccessBlk)successBlk
                            failure:(ErrorBlock)errorBlk{
    
    //参数处理
    paramsDic = [self createParams:paramsDic];
    
#ifdef DEBUG
    NSString *paramsStr = @"";
    for (NSString *key in paramsDic) {
        paramsStr = [NSString stringWithFormat:@"%@=%@&%@",key,[paramsDic objectForKey:key],paramsStr];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@",url,paramsStr];
    NSLog(@"用户端请求URL ： %@",requestUrl);
#endif
    
    NSURLSessionDataTask *dataTask = nil;
    @try {
        //先截取字符串，拿到第一个字符
//        NSString *firstStr = [url substringToIndex:1];
//        if (![@"/"isEqualToString:firstStr]) {
//            url = [NSString stringWithFormat:@"/%@",url];
//        }
        dataTask = [[AFAppClient shared] POST:url
                                   parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                       //上传文件
                                   }
                                     progress:uploadProgress
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          //成功处理
                                          [self successWithResponseObject:responseObject success:successBlk failure:errorBlk];
                                      }
                                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          //失败
                                          errorBlk([error localizedDescription],err_code_net);
                                      }];
    }
    @catch (NSException *exception) {
        errorBlk(exception.name,err_code_net);
    }
    @finally {
        return dataTask;
    }
}

//请求成功处理
-(void)successWithResponseObject:(id)responseObject success:(BaseSuccessBlk)successBlk
                         failure:(ErrorBlock)errorBlk{
    if (responseObject) {
        NSInteger iReturn = [[responseObject objectForKey:@"code"] integerValue];
        if (iReturn == 200) {
            //请求成功 返回data
            LKCommonDataModel *model = [[LKCommonDataModel alloc]init];
            model.Return = [[responseObject objectForKey:@"msg"] integerValue];
//            model.Detail = [responseObject objectForKey:@"Detail"];
            successBlk([responseObject objectForKey:@"newslist"],model);
        }else {
            NSString* errStr = [responseObject objectForKey:@"Detail"];
            errorBlk(errStr,iReturn);
        }
    } else {
        errorBlk(@"json数据为空",err_code_null);
    }
}

-(NSDictionary*)createParams:(NSDictionary *)params{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    NSMutableDictionary *dictParamsM = [NSMutableDictionary dictionary];
    if (!IsEmpty(params)) {
        dictParamsM = [params mutableCopy];
    }
//    [dictParamsM setObject:[LKParamsUtils getVersion] forKey:@"ver"];
//    [dictParamsM setObject:[LKParamsUtils getPlatform] forKey:@"platform"];
//    [dictParamsM setObject:[[LKUserInfoManager sharedInstance] token] forKey:@"token"];
//    [dictParamsM setObject:[LKParamsUtils getAppID] forKey:@"appid"];
    [dic setValuesForKeysWithDictionary:dictParamsM];
//    [dic setObject:[LKParamsUtils getTokenWithParams:dictParamsM] forKey:@"sign"];
    return dic;
}

@end
