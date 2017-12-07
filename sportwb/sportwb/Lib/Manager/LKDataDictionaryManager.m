//
//  LKDataDictionaryManager.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "LKDataDictionaryManager.h"

#define DICT_LOCAL_FILE             @"dictionary.plist"
#define MAX_TRY                     3

@implementation LKDictionaryModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end

@interface LKDataDictionaryManager()
{
    NSMutableDictionary     *_dictData;
    NSString                *_localFile;
    
    NSInteger               _iTry;
}

@end

@implementation LKDataDictionaryManager
+ (LKDataDictionaryManager *)getInstance
{
    __strong static LKDataDictionaryManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _iTry = 0;
        _dictData = [[NSMutableDictionary alloc] init];
        
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [paths lastObject];
        _localFile = [docPath stringByAppendingPathComponent:DICT_LOCAL_FILE];
        
        [self initFromNet];
        
    }
    
    return self;
}

- (NSArray*)getDataForType:(NSString *)type
{
    NSArray *ret = nil;
    if (IsEmpty(_dictData)) {
        [self initFromLocal];
    }
    ret = [_dictData objectForKey:type];
    
    return ret;
}

#pragma mark - private functions

- (void)initFromLocal
{
    NSArray *arryRaw = [[NSArray alloc] initWithContentsOfFile:_localFile];
    [self processData:arryRaw];
}

- (void)initFromNet
{
//    NSMutableDictionary* paramsDic = [[NSMutableDictionary alloc] init];
//    [paramsDic setObject:@"10033" forKey:@"op"];
//    [self postWithUrl:GET_DICTIONARYLIST params:paramsDic success:^(id data,LKCommonDataModel *dataModel) {
//        
//        NSArray *arryRaw = (NSArray *)data;
//        
//        @try {
//            
//            // 处理 NSNull 不能写入文件的问题
//            NSMutableArray *marryRaw = [[NSMutableArray alloc] init];
//            for (NSDictionary *dict in arryRaw) {
//                NSMutableDictionary *mdict = [[NSMutableDictionary alloc] init];
//                NSEnumerator *enumerator = [dict keyEnumerator];
//                id key;
//                while ((key = [enumerator nextObject])) {
//                    if ([dict objectForKey:key] == [NSNull null]) {
//                        //                                        [mdict setObject:@"" forKey:key];
//                    }
//                    else {
//                        NSArray *arryRawVal = [dict objectForKey:@"dictionary"];
//                        if (!IsEmpty(arryRawVal)) {
//                            
//                            for (NSDictionary *dic in arryRawVal) {
//                                NSError * error = nil;
//                                [MTLJSONAdapter modelOfClass:OPDictionaryModel.class fromJSONDictionary:dic error:&error];
//                            }
//                        }
//                        [mdict setObject:[dict objectForKey:key] forKey:key];
//                    }
//                }
//                [marryRaw addObject:mdict];
//            }
//            [marryRaw writeToFile:_localFile atomically:YES];
//            
//            [self processData:arryRaw];
//            
//        } @catch (NSException *exception) {
//            NSLog(@"OPDictionaryMgr ----=====  %@",exception.name);
//        } @finally {
//            
//        }
//    } failure:^(NSString *errMsg, NSInteger errCode) {
//        if (_iTry < MAX_TRY) {
//            _iTry ++;
//            
//            float delayInSeconds = 0.3;
//            dispatch_time_t delalyTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(delalyTime, dispatch_get_main_queue(), ^{
//                [self initFromNet];
//            });
//        }
//    }];
    
}

- (void)processData:(NSArray*)arryRaw
{
//    if (NO == IsEmpty(arryRaw)) {
//        for (NSDictionary *dictKeyVals in arryRaw) {
//            NSString *strKey = [dictKeyVals objectForKey:@"identity"];
//            NSMutableArray *arryVal = [[NSMutableArray alloc] init];
//            NSArray *arryRawVal = [dictKeyVals objectForKey:@"dictionary"];
//
//            if (NO == IsEmpty(arryRawVal)) {
//                for (NSDictionary *dictVals in arryRawVal) {
//                    NSError * error = nil;
//                    LKDictionaryModel * dictM = [MTLJSONAdapter modelOfClass:LKDictionaryModel.class fromJSONDictionary:dictVals error:&error];
//                    [arryVal addObject:dictM];
//                }
//                [_dictData setObject:arryVal forKey:strKey];
//            }
//        }
//    }
}
@end
