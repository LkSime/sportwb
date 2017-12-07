//
//  LKParamsUtils.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKParamsUtils.h"
//#import "NSString+MD5.h"
#import "ApiUrl.h"

@implementation LKParamsUtils

//+ (NSString*)getTokenWithParams:(NSDictionary*)params
//{
//    NSString *key = @"M#4zg^MBwB9fYmVRdbi!zw[8qEygTQ";
//    NSMutableString* rawData = nil;
//    rawData = [[NSMutableString alloc] init];
//    [rawData appendString:key];
//    if([params count] > 0 && key)
//    {
//        NSArray* allKeys = [params allKeys];
//        NSMutableArray* mutableKeys = [NSMutableArray arrayWithArray:allKeys];
//        [mutableKeys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//            NSString* strKey1 = obj1;
//            NSString* strKey2 = obj2;
//            NSComparisonResult comResult = [strKey1 compare:strKey2];
//            return comResult;
//        }];
//
//        for(NSInteger index = 0; index < [mutableKeys count]; ++index)
//        {
//            NSString* valueKey = [mutableKeys objectAtIndex:index];
//            NSString* value = [NSString stringWithFormat:@"%@",[params objectForKey:valueKey]];
//            [rawData appendString:valueKey];
//            [rawData appendString:value];
//        }
//    }
//    [rawData appendString:key];
//
//    NSString* token = nil;
//    if(rawData)
//    {
//        token = [[rawData md5] uppercaseString];
//    }
//    return token;
//}

+ (NSString*)getVersion{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"OPVersion"];
}

+ (NSString*)getPlatform{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"OPPlatform"];
}

+ (NSString*)getAppID{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"appid"];
}

#pragma mark -- 网络请求添加自定义cookie
//+ (void)manuallyAddCookies{
//
//    NSArray *name = @[@"token",@"platform",@"ver"];
//    NSArray *value = @[[[LKUserInfoManager sharedInstance]token],@"app",[OPParamsUtils getVersion]];
//
//    /*
//     手动设置cookies
//     在设置特定的cookis时，需要注意以下：
//     1：在NSDictionary设置字典的时候必须包含以下几项：NSHTTPCookieValue, NSHTTPCookieName, NSHTTPCookiePath, NSHTTPCookieDomain。
//     2：在甚至键值对NSHTTPCookiePath时，value必须是url的Domain。
//     */
//    NSMutableDictionary * cookieProperties = [NSMutableDictionary dictionary];
//    if (!IsEmpty(name)) {
//        for (int i = 0; i < [name count]; i++) {
//            [cookieProperties setObject:[name objectAtIndex:i] forKey:NSHTTPCookieName];
//            [cookieProperties setObject:[value objectAtIndex:i] forKey:NSHTTPCookieValue];
//            [cookieProperties setObject:BASE_HTML5_URLHEARD forKey:NSHTTPCookieDomain];
//            [cookieProperties setObject:BASE_HTML5_URLHEARD forKey:NSHTTPCookieOriginURL];
//            [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//            [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//            NSHTTPCookie * customCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:customCookie];
//        }
//    }
//
//}

@end
