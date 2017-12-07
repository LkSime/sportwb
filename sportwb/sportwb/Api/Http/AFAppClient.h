//
//  AFAppClient.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFAppClient : AFHTTPSessionManager

+(AFAppClient *)shared;

-(void)cancelAllOperations;

@end
