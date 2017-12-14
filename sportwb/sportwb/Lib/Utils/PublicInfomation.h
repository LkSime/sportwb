//
//  PublicInfomation.h
//  penavicoxm
//
//  Created by jx on 14-11-19.
//  Copyright (c) 2014年 1ping.com. All rights reserved
//

//#import "OPUserModel.h"
//#import "OPSearchModel.h"

@interface PublicInfomation : NSObject

//@property (nonatomic,strong) OPUserContextDataModel *mUserContextModel;//用户上下文信息
@property(nonatomic,strong) NSArray *mDepartmentArr;//科室信息

@property (nonatomic, assign) BOOL     is_product;
@property (nonatomic, copy) NSString * base_url_build;
@property (nonatomic, copy) NSString * base_html_url;
@property (nonatomic, copy) NSString * base_html_urlheard;

+ (PublicInfomation *)shared;

+ (void)initDB;

@end
