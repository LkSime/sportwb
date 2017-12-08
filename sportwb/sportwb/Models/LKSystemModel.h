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
