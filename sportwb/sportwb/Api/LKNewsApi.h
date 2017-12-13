//
//  LKNewsApi.h
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseApi.h"

/**新闻资讯的请求类*/
@interface LKNewsApi : LKBaseApi

+(LKNewsApi *)shareInstance;

/**
 * 获取社会新闻列表
 */
-(NSURLSessionDataTask *)getSocialOfNewsIndex:(NSInteger)page_index
                                    page_size:(NSInteger)page_size
                             withSuccessBlock:(void (^)(NSArray * mArray))successBlk
                               withErrorBlock:(ErrorBlock)errorBlk;


-(NSURLSessionDataTask *)getMediaListSuccessBlock:(void (^)(NSArray * mArray))successBlk
                                   withErrorBlock:(ErrorBlock)errorBlk;

@end
