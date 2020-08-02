//
//  HYAppContext.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/28.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYAppContext.h"

static NSString *const kAppVersion = @"appVersion";

@implementation HYAppContext

+ (instancetype)shareContext {
    static dispatch_once_t onceToken;
    static HYAppContext *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [HYAppContext new];
        instance->_isNewUpdate = [self __isNewUpdate];
    });
    return instance;
}

+ (BOOL)__isNewUpdate {
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    else{
        return NO;
    }
}



@end
