//
//  AppDelegate+PayLaunch.h
//  youbaner
//
//  Created by luzhongchang on 17/8/19.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (PayLaunch)

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

@end
