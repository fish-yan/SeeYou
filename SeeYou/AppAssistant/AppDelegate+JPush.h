//
//  AppDelegate+JPush.h
//  youbaner
//
//  Created by luzhongchang on 2017/9/9.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)<JPUSHRegisterDelegate>

-(void) JPushapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
