//
//  MMViewController.h
//
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import <Foundation/Foundation.h>
//#import "IMXUtils.h"
#import "UIUtils.h"
//#import "NSUtils.h"
//#import "PublicFunction.h"

enum
{
    MMNavigationBarItemTypeBack = 0,
    MMNavigationBarItemTypePlain,
    MMNavigationBarItemLeft,
    MMNavigationBarItemRight
};

typedef NSUInteger MMNavigationBarItemType;


@interface MMNavigationBarButtonItem : UIButton
{
    UILabel*        _titleLable;
}

- (id)initWithItemType:(MMNavigationBarItemType)itemType 
                target:(id)target actionSelector:(SEL)actionSel 
           normalImage:(UIImage*)norImage 
        highLightImage:(UIImage*)hgImage
                 title:(NSString*)title;

- (void)setTitle:(NSString*)title;

@end

@interface MMNavigationBar : UIView
{
    UIImageView*            _backgroundView;
    
    //UILabel*                _titleLabel;
    
    MMNavigationBarButtonItem*  _leftBarItem;
    
    MMNavigationBarButtonItem*  _rightBarItem;
}

@property (nonatomic, strong) MMNavigationBarButtonItem* leftBarItem;
@property (nonatomic, strong) MMNavigationBarButtonItem* rightBarItem;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *navLineView;

- (id)initWithFrame:(CGRect)frame backGroundImage:(UIImage*)bgImage;

- (void)setTitle:(NSString*)title;
- (void)setTitle:(NSString *)title withFont:(UIFont*)font withColor:(UIColor*)color;

- (NSString*)title;

@end

@interface MMViewController : UIViewController
{
    MMNavigationBar*    _mmNavigationBar;
    
    UIView*             _mmContentView;
    
    CGRect              _mmContentBounds;
}

@property (nonatomic, strong) MMNavigationBar*  mmNavigationBar;
@property (nonatomic, readonly) UIView*         mmContentView;
@property (nonatomic, assign) CGRect          mmContentBounds;//有时需要调整content的位置

- (id)init;

/**不设置导航栏*/
- (BOOL)isNeedNavigationBar;

/**禁止滑动返回*/
-(BOOL)isNeedSwipeBack;

/**是否模态VC 处理滑动返回导致崩溃  YES*/
-(BOOL)isPresentedViewController;

/**是否需要返回按钮*/
- (BOOL)isNeedLeftBarItem;
/**重新返回按钮事件*/
- (void)leftNavigationBarItemAction:(id)sender;

/**设置标题*/
- (void)setTitle:(NSString *)title;

- (void)setNavBarButtonItem:(NSString *)title
                  title2or4:(NSInteger)tag
                leftorright:(MMNavigationBarItemType)dir
                     target:(id)target
                 turnAction:(SEL)action;

@end
