//
//  LKNewsModel.h
//  sportwb
//
//  Created by LkSime on 2017/12/8.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKNewsModel : NSObject
@end

@interface LKNewsSocialListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString * ctime; //2017-06-06 07:41
@property (nonatomic, copy) NSString * title; //2400元的音箱贵不贵？苹果HomePod现场体验
@property (nonatomic, copy) NSString * des; //网易VR
@property (nonatomic, copy) NSString * picUrl;
@property (nonatomic, copy) NSString * newsUrl; //http://tech.163.com/photoview/6PGI0009/15180.html
@end
