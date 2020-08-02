//
//  AppDelegateUIAssistant.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDelegateUIAssistant : NSObject<UITabBarControllerDelegate>

@property(nonatomic ,strong ,readonly) UIWindow *window;
@property(nonatomic ,strong ,readonly) UINavigationController * rootNavigationController;
@property(nonatomic,strong ,readonly) UITabBarController * rootTabBarController;


/// 设置登录页面为根控制器, 执行时显示登陆页面
@property(nonatomic ,strong, readonly) RACCommand *setLoginVCASRootVCComand;

/// 设置tabbar控制器为根控制器, 执行后进入首页
@property (nonatomic, strong, readonly) RACCommand *setTabBarVCAsRootVCCommand;

@property (nonatomic, strong, readonly) RACCommand *showCompleteInfoVCCmd;
@property (nonatomic, strong, readonly) RACCommand *showUploadAvatarVCCmd;

///判断用户是否交过钱去交钱

@property(nonatomic,strong ,readonly) RACCommand * setUploadMonayVCCommand;
@property(nonatomic ,strong,readonly) RACCommand * setVerfifyVCCommand;

/// 启动UI助手单例对象
+ (instancetype)shareInstance;

@end
