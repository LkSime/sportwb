//
//  PublicInfomation.h
//  penavicoxm
//
//  Created by jx on 14-11-19.
//  Copyright (c) 2014年 1ping.com. All rights reserved
//

#define Audio_Load_Path     @"audio"

#define YIZHU_TYPE 2
#define HUAYANDAN_TYPE 4
#define FAPIAO_TYPE 8
#define JILU_TYPE 16

/**
 * 百度统计
 */
//推荐
#define recommend_layout @"recommend_layout"
#define recommend_layout_label NSLocalizedStringFromEPing(@"common_recomment")
//分享
#define share_thirdparty @"share"
#define share_thirdparty_label NSLocalizedStringFromEPing(@"common_share")
//提交点评
#define submit_btn @"submit_btn"
#define submit_btn_label @"提交点评"
//档案编辑
#define record_edit @"record_edit"
#define record_edit_label @"档案编辑"
//注册
#define registe  @"registe"
#define registe_label @"注册"
//搜索
#define search @"search"
#define search_label NSLocalizedStringFromEPing(@"common_serach")
//资讯评论
#define message_comment @"message_comment"
#define message_comment_label @"资讯评论"

//条件筛选类型
typedef enum{
    OPFitConditionTypeCity,
    OPFitConditionTypeHospitalLevel,
    OPFitConditionTypeHospital,
    OPFitConditionTypeDepartment,
    OPFitConditionTypeJob
} OPFitConditionType;

/**订单列表类型*/
typedef enum {
    /**待付款*/
    OPOrderStatusTypePay,
    /**审核方案*/
    OPOrderStatusTypeHandle,
    /**候诊*/
    OPOrderStatusTypeShipped,
    /**待评论*/
    OPOrderStatusTypeEva,
} OPOrderStatusType;


@interface PublicFunction : NSObject

+ (PublicFunction *)shared;

+ (NSString *)getLogFilePath;

+ (void)needLogin:(BOOL)isPopCurrentVC;

+ (void)popVC:(UIViewController*)vc animated:(BOOL)animated;

+ (void)popVC:(UIViewController*)vc;

+ (void)showWaitingProgress;

+ (void)dissProgress:(NSString*)message;

+ (BOOL)saveToLocaleWithModel:(id)model useFileName:(NSString *)name;

+ (id)getFromLocaleWithName:(NSString *)name;

+ (NSString*)getTokenWithParams:(NSDictionary*)params;

- (void)showReviewTip;

/**联系客服 (群服务)
 2. principal_id  选填  当前对话的客服消息主体ID,一般是消息会话列表进入时带有该参数,在通讯录进入时为空
 3. group_principal_id 选填,获取某一个服务号的客服
 4. business      选填  业务类型,如预约服务:app,如果不传默认为普通服务:common
 */
+ (void)linkEpingService:(NSString *)group_principal_id
                Business:(NSString *)business;

@end
