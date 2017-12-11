//
//  LKSystemModel.h
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKSystemModel : NSObject
@end

@interface LKSystemBaseModel : MTLModel<MTLJSONSerializing>
@property (assign)          NSInteger  appSwitch;
@property (nonatomic, copy) NSString * switchUrl;
@end

@interface LKHomeBannerAdvertModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString * aId;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * imgUrl;
@property (assign)          NSInteger startTime;
@property (assign)          NSInteger activeType;
@end

@interface LKHomeBannerAdvertList : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSArray * dataList;
@property (assign)            NSInteger showCount;
@property (assign)            NSInteger totalPage;
@property (assign)            NSInteger currentPage;
@property (assign)            NSInteger totalResult;
@property (assign)            NSInteger currentResult;
@end
