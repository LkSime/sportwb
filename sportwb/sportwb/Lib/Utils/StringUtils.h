//
//  StringUtils.h
//  doctor
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import <Foundation/Foundation.h>

//对象是否为空
static inline BOOL IsEmpty(id object) {
    return object == nil || [object isEqual:[NSNull null]]
    || ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)
    || ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0);
}

static inline NSString* trimString(NSString *str){
    NSMutableString *mStr = [str mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    return [mStr copy];
}

//UIColor转UIImage
static inline UIImage* imageWithUIColor(UIColor *color){
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@interface StringUtils : NSObject
+ (UIImage *)creatResizableImageFromImageName:(NSString *)name;
+ (BOOL)checkPhoneFormat:(NSString*)strPhone;
+ (NSString*)getMD5NSString:(NSString*)strOrigin;

@end
