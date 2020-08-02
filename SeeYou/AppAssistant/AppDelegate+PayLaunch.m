//
//  AppDelegate+PayLaunch.m
//  youbaner
//
//  Created by luzhongchang on 17/8/19.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppDelegate+PayLaunch.h"
#import "WXApi.h"
#import "HYOnlinePayHelper.h"
@implementation AppDelegate (PayLaunch)

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([Growing handleUrl:url]) {
        return YES;
    }


    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@", resultDic);
                                                  }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"result = %@", resultDic);
                                             // 解析 auth code
                                             NSString *result   = resultDic[@"result"];
                                             NSString *authCode = nil;
                                             if (result.length > 0) {
                                                 NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                 for (NSString *subResult in resultArr) {
                                                     if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                         authCode = [subResult substringFromIndex:10];
                                                         break;
                                                     }
                                                 }
                                             }
                                             NSLog(@"授权结果 authCode = %@", authCode ?: @"");
                                         }];
    } else if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[HYOnlinePayHelper shareHelper]];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@", resultDic);
                                                  }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"result = %@", resultDic);
                                             // 解析 auth code
                                             NSString *result   = resultDic[@"result"];
                                             NSString *authCode = nil;
                                             if (result.length > 0) {
                                                 NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                 for (NSString *subResult in resultArr) {
                                                     if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                         authCode = [subResult substringFromIndex:10];
                                                         break;
                                                     }
                                                 }
                                             }
                                             NSLog(@"授权结果 authCode = %@", authCode ?: @"");
                                         }];
    } else if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[HYOnlinePayHelper shareHelper]];
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if([url.host isEqualToString:@"pay"])
    {
        return [WXApi handleOpenURL:url delegate:[HYOnlinePayHelper shareHelper]];
    }
    return  YES;
}

@end
