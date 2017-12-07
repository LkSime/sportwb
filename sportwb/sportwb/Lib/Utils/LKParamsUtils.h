//
//  LKParamsUtils.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKParamsUtils : NSObject

//+ (NSString*)getTokenWithParams:(NSDictionary*)params;

+ (NSString*)getVersion;

+ (NSString*)getPlatform;

+ (NSString*)getAppID;

/**网络请求添加自定义cookie*/
//+ (void)manuallyAddCookies;

@end
