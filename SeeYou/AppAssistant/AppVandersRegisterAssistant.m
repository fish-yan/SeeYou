//
//  AppVandersRegisterAssistant.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/8.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "AppVandersRegisterAssistant.h"
#import <Bugly/Bugly.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "WXApi.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <UMMobClick/MobClick.h>

//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//#import "WXApi.h"
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import "WeiboSDK.h"
//#import "AppPushAssistant.h"

@implementation AppVandersRegisterAssistant

+ (void)registerVanders {
    [self registerShareSDK];
    
    
    [Bugly startWithAppId:@"6b71748dda"];
    [WXApi registerApp:kWeChatID];
    [Growing startWithAccountId:kGrowingAppKey ];
    [AMapServices sharedServices].apiKey = @"084c483d10127ffc55fd93d5748c8e8f";

    [YSMediator registerUrlInfos:@{@"com.tm.IwantYou": [NSNull null]}];

//    [[AppPushAssistant shareAssistant] registerPushSDK];

    [self registerUMengAnalytics];
    // 注册 Crashlytics
    [Fabric with:@[[Crashlytics class]]];
}

/// 注册友盟分析
+ (void)registerUMengAnalytics {
    UMConfigInstance.appKey = @"5b851a85f29d980f7300001e";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogEnabled:NO];
    
}


/// 注册ShareSDK
+ (void)registerShareSDK {
//    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeWechat),
//                                        @(SSDKPlatformTypeQQ),
//                                        ]
//                             onImport:^(SSDKPlatformType platformType) {
//                                 switch (platformType) {
//                                     case SSDKPlatformTypeWechat:
//                                         [ShareSDKConnector connectWeChat:[WXApi class]];
//                                         break;
//                                     case SSDKPlatformTypeQQ:
//                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                                         break;
//                                     default:
//                                         break;
//                                 }
//                             }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//                          switch (platformType) {
//                              case SSDKPlatformTypeWechat:
//                                  [appInfo SSDKSetupWeChatByAppId:kWeixinAppID
//                                                        appSecret:kWeixinAppSecret];
//                                  break;
//                              case SSDKPlatformTypeQQ:
//                                  [appInfo SSDKSetupQQByAppId:kQQAppID
//                                                       appKey:kQQAppKey
//                                                     authType:SSDKAuthTypeBoth];
//                                  break;
//
//                              default:
//                                  break;
//                          }
//     }];
}

@end
