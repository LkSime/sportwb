//
//  OPMyBottomView.m
//  oneping
//
//  Created by LkSime on 15/12/9.
//  Copyright © 2015年 1ping.com All rights reserved.
//

#import "OPMyBottomView.h"
#import "OPFeedbackViewController.h"
#import "LKLieViewController.h"
//#import "LKLoginViewController.h"
//#import "LKCollectViewController.h"
//#import "LKUserModel.h"
//#import "LKUserInfoManager.h"

@interface OPMyBottomView () {

}

@end

@implementation OPMyBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    _opHealthrecord = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [_opHealthrecord setMyBottomViewCellWithTitle:@"做任务赚取积分"
                                            Image:@"thinking_list_qrcode"
                                      PushVCClass:@"LKLieViewController"];
    [self addSubview:_opHealthrecord];
    
    _opOrderForm = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    [_opOrderForm setMyBottomViewCellWithTitle:@"消息"
                                         Image:@"icon_my_order"
                                   PushVCClass:@"LKLieViewController"];
    [self addSubview:_opOrderForm];
    _opOrderForm.unReadLabel.hidden = YES;
    
    _opTaskList = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 50)];
    [_opTaskList setMyBottomViewCellWithTitle:@"心水收藏"
                                        Image:@"icon_my_todotask"
                                  PushVCClass:@"collect"];
    
    [self addSubview:_opTaskList];
    _opTaskList.unReadLabel.hidden = YES;
    
//    _opMessage = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
//    [_opMessage setMyBottomViewCellWithTitle:@"心水评论"
//                                       Image:@"thinking_list_msg"
//                                 PushVCClass:@"LKLieViewController"];
//    [self addSubview:_opMessage];
    
//    _opAddress = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 50)];
//    [_opAddress setMyBottomViewCellWithTitle:@"通讯录"
//                                       Image:@"thinking_list_friend"
//                                 PushVCClass:@"LKLieViewController"];
//    CGRect adFrame = _opAddress.unReadLabel.frame;
//    adFrame.origin.y += 2;
//    adFrame.origin.x += 2;
//    adFrame.size.width = 10;
//    adFrame.size.height = 10;
//    _opAddress.unReadLabel.frame = adFrame;
//    [self addSubview:_opAddress];
    
    _opDoctor = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
    [_opDoctor setMyBottomViewCellWithTitle:@"意见反馈"
                                      Image:@"thinking_list_doctor"
                                PushVCClass:@"OPFeedbackViewController"];
    [self addSubview:_opDoctor];

}

@end
