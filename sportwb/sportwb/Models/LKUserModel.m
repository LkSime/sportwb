//
//  LKUserModel.m
//  sportwb
//
//  Created by LkSime on 2017/12/20.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKUserModel.h"

@implementation LKUserModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
//             @"avatar":@"avatar",
             @"isLogin":@"isLogin",
             @"username":@"username"
             };
}
@end
