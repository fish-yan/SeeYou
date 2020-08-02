//
//  AppToolsConfigAssistant.m
//  HCDoctor
//
//  Created by Joseph Gao on 2017/6/26.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "AppToolsConfigAssistant.h"
#import "IQKeyboardManager.h"
#import "IQToolbar.h"
#import "SDImageCacheConfig.h"

@implementation AppToolsConfigAssistant

+ (void)setupTools {
    [self setupIQKeyboardManager];
    [self setupYSMediatorMap];
    [self setupSDWebImageView];
}

/// 配置 SDWebImage 属性
+ (void)setupSDWebImageView {
    [SDImageCache sharedImageCache].config.maxCacheSize = 300 * 1024 * 1024;
}

/// 配置IQKeyboardManager
+ (void)setupIQKeyboardManager {
    IQKeyboardManager *keyboardMgr = [IQKeyboardManager sharedManager];
    // keyboardMgr.keyboardDistanceFromTextField = 50;
    keyboardMgr.enable            = YES;
    keyboardMgr.enableAutoToolbar = NO;
    [[IQToolbar appearance] setBackgroundColor:[UIColor whiteColor]];
}

/// 配置YSMediator注册Scheme 和 映射
+ (void)setupYSMediatorMap {
    // 注册router url scheme
    // TODO: 多Scheme和host的支持, 暂时支持单一Scheme 和 host的url跳转
    //[YSMediator registerScheme:APP_URL_SCHEME andHost:APP_URL_HOST];

}

@end
