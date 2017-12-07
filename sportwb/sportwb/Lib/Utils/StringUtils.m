//
//  StringUtils.m
//  doctor
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "StringUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation StringUtils

+ (UIImage *)creatResizableImageFromImageName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)];
    return image;
}

+ (BOOL)checkPhoneFormat:(NSString*)strPhone
{
    BOOL bRet = NO;
    
    NSString *phoneRegex = @"\\d{11}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    bRet = [phoneTest evaluateWithObject:strPhone];
    
    return bRet;
}

+(NSString*)getMD5NSString:(NSString*)strOrigin
{
    const char *original_str = [strOrigin UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}
@end
