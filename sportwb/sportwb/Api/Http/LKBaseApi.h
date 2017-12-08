//
//  LKBaseApi.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUrl.h"
#import "LKCommonDataModel.h"

typedef void (^SuccessBlock)();
typedef void (^SuccessArrayBlock)(NSArray* data);
typedef void (^SuccessStringBlock)(NSString* str);
typedef void (^ErrorBlock)(NSString* errMsg,NSInteger errCode);

typedef void (^BaseSuccessBlk)(id data,LKCommonDataModel *dataModel);

@interface LKBaseApi : NSObject

-(NSURLSessionDataTask*)getWithUrl:(NSString*)url
                            params:(NSDictionary *)paramsDic
                           success:(BaseSuccessBlk)successBlk
                           failure:(ErrorBlock)errorBlk;


-(NSURLSessionDataTask*)postWithUrl:(NSString*)url
                             params:(NSDictionary *)paramsDic
                            success:(BaseSuccessBlk)successBlk
                            failure:(ErrorBlock)errorBlk;

@end
