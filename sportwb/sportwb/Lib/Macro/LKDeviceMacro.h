//
//  LKDeviceMacro.h
//  sportwb
//
//  Created by Mahalo on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#ifndef OPDeviceMacro_h
#define OPDeviceMacro_h

#define Audio_Load_Path     @"audio"

//---------------多语言----------------
#define NSLocalizedStringFromEPing(key) \
NSLocalizedString(key, nil)


//---------------屏幕宽高----------------
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

//banner高度
#define ADHeight (SCREEN_WIDTH * 2.0f / 3.0f)

//暂时放这里，后续处理
#define resizableImageWithImageName(name)  [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake([UIImage imageNamed:name].size.height * 0.5, [UIImage imageNamed:name].size.width * 0.5, [UIImage imageNamed:name].size.height * 0.5, [UIImage imageNamed:name].size.width * 0.5)]

#endif /* OPDeviceMacro_h */

#define ISPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IOS5_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

#define TipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define VERIFY_CODE_TYPE_REG                    @"register"
#define VERIFY_CODE_TYPE_FIND_PWD               @"findPassword"
#define VERIFY_CODE_TYPE_SET_PHONE              @"setPhone"
#define VERIFY_CODE_TYPE_CHANGE_PWD             @"modifyPassword"
#define VERIFY_CODE_TYPE_BIND_PHONE             @"bindPhone"


