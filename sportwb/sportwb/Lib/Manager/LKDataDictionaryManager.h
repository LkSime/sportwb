//
//  LKDataDictionaryManager.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKBaseApi.h"

#define DICT_ONLINESTATUS   @"10033"    //在线状态

@interface LKDictionaryModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString    *code;
@property (nonatomic, copy) NSString    *name;
@end

@interface LKDataDictionaryManager : LKBaseApi

@end
