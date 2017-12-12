//
//  UIUtils.h
//  oneping
//
//  Created by jx on 14-11-17.
//  Copyright (c) 2014年 1ping.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EndEditingForKeyWindow [[UIApplication sharedApplication].keyWindow endEditing:YES]
#define Screen_AppShowFrame ([UIScreen mainScreen].applicationFrame)
#define AppContentHeight    (IOS7_OR_LATER?SCREEN_HEIGHT:Screen_AppShowFrame.size.height)

#define RectMake(x, y, w, h)    CGRectMake(x, y, w, h)
#define WidthForView(view)      (view.frame.size.width)
#define HeightForView(view)     (view.frame.size.height)
#define XForView(view)          (view.frame.origin.x)
#define YForView(view)          (view.frame.origin.y)
#define LeftForView(view)       (view.frame.origin.x)
#define TopForView(view)        (view.frame.origin.y)
#define BottomForView(view)     (view.frame.origin.y + view.frame.size.height)
#define RightForView(view)      (view.frame.origin.x + view.frame.size.width)

#define FILTER_WIDTH            SCREEN_WIDTH - 80

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define OP_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define OP_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

@interface UIUtils : NSObject

+(UIViewController*)createVC:(NSString*)vcName;

+(void)pushVC:(UIViewController *)vc;

+(void)popViewControllerAnimated:(BOOL)animated;

+(UIViewController *)getCurrentVC;

+(void)presentTransparentVC:(UIViewController *)vc;

+(void)pushVC:(NSString*)vcName withParam:(NSDictionary *)paramDic;


+(void)adjustLabelFrameFromText:(UILabel *)lab;

+(void)adjustLabelWidthFromText:(UILabel *)lab;

+(UIImage*)getCapImage:(NSString*)imageName;

+(UIImage*)getCapImage:(NSString*)imageName
        withEdgeInsets:(UIEdgeInsets)edgeInsets;

+ (UIImage*)creatResizableImageFromImageName:(NSString *)name;
@end
