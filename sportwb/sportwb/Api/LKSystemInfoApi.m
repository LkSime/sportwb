//
//  LKSystemInfoApi.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKSystemInfoApi.h"

@implementation LKSystemInfoApi

+(LKSystemInfoApi *)shareInstance {
    __strong static LKSystemInfoApi *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
