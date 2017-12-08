//
//  LKNewsModel.m
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKNewsModel.h"

@implementation LKNewsModel
@end

@implementation LKNewsSocialListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ctime":@"ctime",
             @"title":@"title",
             @"des":@"description",
             @"picUrl":@"picUrl",
             @"newsUrl":@"url"
             };
}
@end
