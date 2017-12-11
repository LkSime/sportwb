//
//  LKColorMacro.h
//  sportwb
//
//  Created by Mahalo on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#ifndef OPColorMacro_h
#define OPColorMacro_h

//-----------------颜色-----------------
#define ColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
///16进制颜色
#define ColorFromHex(hexValue)  ColorFromHexWithAlpha(hexValue,1.0)
#define ColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorFromRGB(r,g,b)     ColorFromRGBA(r,g,b,1.0)

//主色调
#define COLOR_FOR_MAIN_36A6C7         ColorFromHex(0x36a6c7)

//背景色
#define COLOR_FOR_BACKGROUND_F2    ColorFromHex(0xf2f2f2)

//分割线
#define COLOR_FOR_LINE_EC    ColorFromHex(0xececec)

//白色
#define COLOR_FOR_WHITE     [UIColor whiteColor]
//灰色
#define COLOR_FOR_GRAY      [UIColor grayColor]
//透明
#define COLOR_FOR_CLEAR     [UIColor clearColor]
///医评橙色
#define COLOR_FOR_ORANGE   ColorFromHex(0xef9c63)
#define COLOR_FOR_BLUE     ColorFromHex(0x6496c8)

#define NAV_COLOR           ColorFromHex(0x6496c8)


/**文字颜色*/
#define COLOR_FOR_TEXT_33  ColorFromHex(0x333333)
#define COLOR_FOR_TEXT_4D  ColorFromHex(0x4d4d4d)
#define COLOR_FOR_TEXT_80  ColorFromHex(0x808080)
#define COLOR_FOR_TEXT_B3  ColorFromHex(0xb3b3b3)
#define COLOR_FOR_TEXT_E6  ColorFromHex(0xe6e6e6)

#endif /* OPColorMacro_h */
