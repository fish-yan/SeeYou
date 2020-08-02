//
//  AppLaunchDeployUIManager.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppLaunchDeployUIManager.h"
#import "AppDelegateUIAssistant.h"
#import "WDSplashViewManager.h"

static NSString *const kAppVersion = @"appVersion";

@implementation AppLaunchDeployUIManager

- (UIWindow *)deplyUI {
    AppDelegateUIAssistant *assistant = [AppDelegateUIAssistant shareInstance];


    // 1. 检查用户是否登录:
    // 已登陆: 执行命令设置根控制器是 LoginViewController,
    // 未登陆: 执行设置根控制器是 tabBarViewController的命令
    if ([HYUserContext shareContext].login) {
        [assistant.setTabBarVCAsRootVCCommand execute:@1];

        //        HYUserCenterModel *model = [HYUserContext shareContext].userModel;
        //        switch (model.iscomplete) {
        //            case UserInfoTypeComplete: {
        //                [assistant.setTabBarVCAsRootVCCommand execute:@1];
        //                break;
        //            }
        //            case UserInfoTypeNoAvatar: {
        //                [assistant.showUploadAvatarVCCmd execute:nil];
        //                break;
        //            }
        //            case UserInfoTypeIncomplte: {
        //                [assistant.showCompleteInfoVCCmd execute:nil];
        //                break;
        //            }
        //            default:
        //                break;
        //        }

    } else {
        [assistant.setLoginVCASRootVCComand execute:@1];
    }

    if ([HYAppContext shareContext].isNewUpdate) {
        [[WDSplashViewManager manager].showCommand execute:nil];
    }
    
     return assistant.window;
}

@end
