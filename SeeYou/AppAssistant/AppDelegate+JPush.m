//
//  AppDelegate+JPush.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/9.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppDelegate+JPush.h"

@implementation AppDelegate (JPush)

- (void)JPushapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL isProduct = NO;
    [JPUSHService setupWithOption:launchOptions
                           appKey:kJPushSdkAppKey
                          channel:@"App Store"
                 apsForProduction:isProduct
            advertisingIdentifier:nil];

    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types                = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setLogOFF];    // 关闭log


    [RACObserve([HYUserContext shareContext], login) subscribeNext:^(NSNumber *_Nullable x) {

        if ([x boolValue]) {
            [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
                if (resCode == 0) {
                    NSLog(@"registrationID获取成功：%@", registrationID);
                    NSDictionary *target = @{ @"targetid": registrationID };
                    NSDictionary *d      = [NSDictionary convertParams:API_BIND_PUSH dic:target];

                    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:nil
                                                                        params:d
                                                                   requestType:WDRequestTypePOST
                                                                  responseType:WDResponseTypeMessage
                                                                 responseClass:nil];
                    [signal subscribeNext:^(id _Nullable x) {
                        NSLog(@"bind ok");
                    }
                    error:^(NSError *_Nullable error) {
                        NSLog(@"bind failed");
                    }];

                } else {
                    NSLog(@"registrationID获取失败，code：%d", resCode);
                }
            }];
        }
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"Device Token: %@", deviceToken];
    NSLog(@"%@", token);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - JPUSHRegisterDelegate


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger options))completionHandler;
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
          withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();    // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
      fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = -1;
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    application.applicationIconBadgeNumber =-1;
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
