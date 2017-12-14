//
//  OPMyBottomView.m
//  oneping
//
//  Created by LkSime on 15/12/9.
//  Copyright © 2015年 1ping.com All rights reserved.
//

#import "OPMyBottomView.h"

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
    [_opHealthrecord setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"record_daily_string")
                                            Image:@"thinking_list_qrcode"
                                      PushVCClass:@"OPHealthRecordViewController"];
    [self addSubview:_opHealthrecord];
    _opHealthrecord.unReadLabel.hidden = YES;
    
    _opOrderForm = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    [_opOrderForm setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"busi_order_my")
                                         Image:@"icon_my_order"
                                   PushVCClass:@"OPOrderManagementViewController"];
    [self addSubview:_opOrderForm];
    _opOrderForm.unReadLabel.hidden = YES;
    
    _opTaskList = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 50)];
    [_opTaskList setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"point_do_task")
                                        Image:@"icon_my_todotask"
                                  PushVCClass:@"OPPointTaskVC"];
    [self addSubview:_opTaskList];
    _opTaskList.unReadLabel.hidden = YES;
    
    _opMessage = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
    [_opMessage setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"tim_message_string")
                                       Image:@"thinking_list_msg"
                                 PushVCClass:@"OPIMChatListViewController"];
    [self addSubview:_opMessage];
    
    _opAddress = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 50)];
    [_opAddress setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"friend_address_book")
                                       Image:@"thinking_list_friend"
                                 PushVCClass:@"OPMyfriendsVC"];
    CGRect adFrame = _opAddress.unReadLabel.frame;
    adFrame.origin.y += 2;
    adFrame.origin.x += 2;
    adFrame.size.width = 10;
    adFrame.size.height = 10;
    _opAddress.unReadLabel.frame = adFrame;
    [self addSubview:_opAddress];
    
    _opDoctor = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 50)];
    [_opDoctor setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"medical_doctor_xinshui")
                                      Image:@"thinking_list_doctor"
                                PushVCClass:@"OPDoctorPagerViewController"];
    [self addSubview:_opDoctor];
    
    _opComment = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, 50)];
    [_opComment setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"comment_xinshui_string")
                                       Image:@"thinking_list_comment"
                                 PushVCClass:@"OPCommentPagerViewController"];
    [self addSubview:_opComment];
    
    _opFeedback = [[OPMyBottomViewCell alloc] initWithFrame:CGRectMake(0, 380, SCREEN_WIDTH, 50)];
    [_opFeedback setMyBottomViewCellWithTitle:NSLocalizedStringFromEPing(@"more_feedback")
                                        Image:@"icon_my_feedback"
                                  PushVCClass:@"OPFeedbackViewController"];
    [self addSubview:_opFeedback];
    _opFeedback.unReadLabel.hidden = YES;
}

@end
