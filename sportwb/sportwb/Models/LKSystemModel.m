//
//  LKSystemModel.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKSystemModel.h"

@implementation LKSystemModel
@end

@implementation LKSystemBaseModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"appSwitch":@"switch", @"switchUrl":@"url" };
}
@end

@implementation LKHomeBannerAdvertModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"aId":@"aId",
             @"title":@"title",
             @"url":@"url",
             @"imgUrl":@"imgUrl",
             @"startTime":@"startTime",
             @"activeType":@"activeType"
             };
}
@end

@implementation LKHomeBannerAdvertList
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dataList":@"data",
             @"showCount":@"showCount",
             @"totalPage":@"totalPage",
             @"currentPage":@"currentPage",
             @"totalResult":@"totalResult",
             @"currentResult":@"currentResult"
             };
}
+ (NSValueTransformer *)dataListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[LKHomeBannerAdvertModel class]];
}

@end
