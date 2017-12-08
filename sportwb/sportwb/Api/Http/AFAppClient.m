//
//  AFAppClient.m
//  sportwb
//
//  Created by LkSime on 2017/12/7.
//  Copyright © 2017年 Mahalo. All rights reserved.
//

#import "AFAppClient.h"
#import "ApiUrl.h"

@class AFHTTPSessionManager;

@implementation AFAppClient : AFHTTPSessionManager

+ (instancetype)shared {
    static AFAppClient *_Client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _Client = [[AFAppClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.allowInvalidCertificates = YES;
        _Client.securityPolicy = securityPolicy;
        
        //自定义ssl
        [_Client setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
            
            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            NSString *method = challenge.protectionSpace.authenticationMethod;
            
            if([method isEqualToString:NSURLAuthenticationMethodServerTrust]){
                *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                disposition = NSURLSessionAuthChallengeUseCredential;
                return disposition;
            }
            
            NSString *theName = @"";
#if DEBUG
            theName = @"1pingtestclient";
#else
            theName = @"client";
#endif
            //导入证书
            NSString *thePath = [[NSBundle mainBundle] pathForResource:theName ofType:@"p12"];
            NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
            CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(PKCS12Data);
            SecIdentityRef identity;
            
            // 读取p12证书中的内容
            OSStatus result = [AFAppClient extractP12Data:inPKCS12Data toIdentity:&identity PKCS12Password:@"xeping"];
            if(result != errSecSuccess){
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                return disposition;
            }
            
            SecCertificateRef certificate = NULL;
            SecIdentityCopyCertificate (identity, &certificate);
            
            const void *certs[] = {certificate};
            CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
            
            *credential = [NSURLCredential credentialWithIdentity:identity certificates:(NSArray*)CFBridgingRelease(certArray) persistence:NSURLCredentialPersistencePermanent];
            disposition = NSURLSessionAuthChallengeUseCredential;
            return disposition;
        }];
    });
    
    return _Client;
}

+(OSStatus) extractP12Data:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity PKCS12Password:(NSString*)p12Pwd{
    
    OSStatus securityError = errSecSuccess;
    
    //    CFStringRef password = CFSTR(p12Pwd);
    CFStringRef password = (__bridge CFStringRef) p12Pwd;
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    
    if (options) {
        CFRelease(options);
    }
    
    return securityError;
}

-(void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
