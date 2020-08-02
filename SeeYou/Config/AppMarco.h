//
//  AppMarco.h
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#ifndef AppMarco_h
#define AppMarco_h


//--------------------------------------------------------------------------------------------------------
// 日志输出
#ifndef __OPTIMIZE__
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define NSLog(...) {}
#endif


//--------------------------------------------------------------------------------------------------------
#pragma mark - 系统信息定义

#define SHARED_APPLICATION      [UIApplication sharedApplication]
#define APP                     ((AppDelegate*)[[UIApplication sharedApplication] delegate])                        // AppDelegate 的指针
#define APP_VERSION             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] // APP版本
#define APP_BUILD_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]            // APPbuild版本
#define APP_USERDEFAULTS        [NSUserDefaults standardUserDefaults]                                               // APP的UserDefaults
#define DEVICE_MODEL            [[UIDevice currentDevice] model]                                                    // 设备型号
#define DEVICE_VERSION          [[UIDevice currentDevice] systemVersion]                                            // 设备系统版本
#define DEVICE_VERSION_FLOAT    [[[UIDevice currentDevice] systemVersion] floatValue]                               // 设备系统版本Float类型

#define SCREEN_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height 
//--------------------------------------------------------------------------------------------------------
#pragma mark - UI
#define SCREEN_BOUNDS           [[UIScreen mainScreen] bounds]                          // 屏幕尺寸
#define SCREEN_HEIGHT           SCREEN_BOUNDS.size.height                               // 屏幕高度
#define SCREEN_HEIGHT_STR       [NSString stringWithFormat: @"%d", (int)SCREEN_HEIGHT]  // 屏幕高度 String
#define SCREEN_WIDTH            SCREEN_BOUNDS.size.width                                // 屏幕宽度
#define SCREEN_WIDTH_STR        [NSString stringWithFormat: @"%d", (int)SCREEN_WIDTH]   // 屏幕宽度 String

#define SCREEN_STSTUESBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height -20) //获取状态栏的高度
//--------------------------------------------------------------------------------------------------------
#pragma mark - 判断定义

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)      // 是否是ipad
#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)    // 是否是iPhone
#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)                    // iPhone4、4S以下的设备
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)                   // iPhone5、5S
#define IS_IPHONE_5_OR_LESS     (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)                        // iPhone5、5S以下的设备
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)                   // iPhone6、6S
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)                   // iPhone6P、6PS
#define IS_RETINA               ([[UIScreen mainScreen] scale] >= 2.0)                      // 是否是Retina屏幕
#define IS_IOS7                 (DEVICE_VERSION_FLOAT >= 7 && DEVICE_VERSION_FLOAT < 8)     // IOS 7系统
#define IS_IOS8                 (DEVICE_VERSION_FLOAT >= 8 && DEVICE_VERSION_FLOAT < 9)     // IOS 8系统
#define IS_IOS9                 (DEVICE_VERSION_FLOAT >= 9)                                 // IOS 9系统
#define IS_IOS7_OR_LATER        (DEVICE_VERSION_FLOAT >= 7)                                 // IOS 7以及以上的系统
#define IS_IOS8_OR_LATER        (DEVICE_VERSION_FLOAT >= 8)                                 // IOS 8以及以上的系统
#define IS_IOS9_OR_LATER        (DEVICE_VERSION_FLOAT >= 9)                                 // IOS 9以及以上的系统
#define IS_IOS10_OR_LATER       (DEVICE_VERSION_FLOAT >= 10)                                // IOS 10以及以上的系统


#endif /* AppMarco_h */
