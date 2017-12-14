//
//  OPMyBottomView.h
//  oneping
//
//  Created by LkSime on 15/12/9.
//  Copyright © 2015年 1ping.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPMyBottomViewCell.h"

/**我的界面顶部个人视图*/
@interface OPMyBottomView : UIView

@property (nonatomic, strong) OPMyBottomViewCell * opHealthrecord;
@property (nonatomic, strong) OPMyBottomViewCell * opOrderForm;
@property (nonatomic, strong) OPMyBottomViewCell * opTaskList;
@property (nonatomic, strong) OPMyBottomViewCell * opMessage;
@property (nonatomic, strong) OPMyBottomViewCell * opAddress;
@property (nonatomic, strong) OPMyBottomViewCell * opDoctor;
@property (nonatomic, strong) OPMyBottomViewCell * opComment;
@property (nonatomic, strong) OPMyBottomViewCell * opFeedback;

///获取好友添加未处理消息数
- (void)getNewFriendsCount;
@end
