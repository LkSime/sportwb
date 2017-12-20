//
//  LKUserModel.h
//  sportwb
//
//  Created by LkSime on 2017/12/20.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LKUserModel : MTLModel<MTLJSONSerializing>

//@property (nonatomic, copy) NSString    *avatar;
@property (nonatomic, copy) NSString    *isLogin;
@property (nonatomic, copy) NSString    *username;
@end
