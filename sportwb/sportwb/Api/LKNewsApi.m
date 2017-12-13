//
//  LKNewsApi.m
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKNewsApi.h"
#import "LKNewsModel.h"

@implementation LKNewsApi
+(LKNewsApi *)shareInstance {
    __strong static LKNewsApi *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 * 获取社会新闻列表
 */
-(NSURLSessionDataTask *)getSocialOfNewsIndex:(NSInteger)page_index
                                    page_size:(NSInteger)page_size
                             withSuccessBlock:(void (^)(NSArray * mArray))successBlk
                               withErrorBlock:(ErrorBlock)errorBlk {
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:[NSString stringWithFormat:@"%ld",page_index] forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%ld",page_size] forKey:@"num"];
    [params setObject:@"11e76634e4cc7ef5142c1ea90afe629a" forKey:@"key"];
    return [self postWithUrl:APIPOST_News_Social params:params success:^(id data,LKCommonDataModel *dataModel) {
        
        NSError *error = nil;
        NSArray *arr = [MTLJSONAdapter modelsOfClass:LKNewsSocialListModel.class fromJSONArray:(NSArray*)data error:&error];
        successBlk(arr);
        
    } failure:^(NSString *errMsg, NSInteger errCode) {
        errorBlk(errMsg,errCode);
    }];
}

-(NSURLSessionDataTask *)getMediaListSuccessBlock:(void (^)(NSArray * mArray))successBlk
                                   withErrorBlock:(ErrorBlock)errorBlk {
    
    return [self getWithUrl:APIGET_Home_Media params:nil success:^(id data,LKCommonDataModel *dataModel) {
        
        NSError *error = nil;
        NSArray *arr = [MTLJSONAdapter modelsOfClass:LKNewsSocialListModel.class fromJSONArray:(NSArray*)data error:&error];
        successBlk(arr);
        
    } failure:^(NSString *errMsg, NSInteger errCode) {
        errorBlk(errMsg,errCode);
    }];
}


@end
