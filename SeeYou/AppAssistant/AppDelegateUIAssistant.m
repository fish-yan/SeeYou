//
//  AppDelegateUIAssistant.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "AppDelegateUIAssistant.h"
#import "HYNavigationController.h"
#import "HYRootTabBarViewController.h"

#define LOGIN_VC @"HYLoginRegisterVC"
//#define LOGIN_VC @"HYExclusiveGreetVC"
#define UPLOAD_AVATAR_VC             @"HYCompleteInofUpAvatarVC"
#define COMPLETE_INFO_VC            @"HYCompleteInfoGenderVC"
#define COMMITVERFIFYVC             @"HYCompleteInfoGenderVC"

@implementation AppDelegateUIAssistant

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static AppDelegateUIAssistant *instance =nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
        [instance observerLoginStatus];
    });
    return  instance;
}


-(void)initialize
{
    @weakify(self);
    
    self->_window = [self keyWindow];
    self->_setLoginVCASRootVCComand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        UIViewController *loginVC = [[NSClassFromString(LOGIN_VC) alloc] init];
//        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];;
        if (self.rootNavigationController.presentedViewController) {
            [self.rootNavigationController dismissViewControllerAnimated:NO completion:^{
               
            }];
            @strongify(self);
            self->_rootNavigationController = [self navControllerWithRootViewController:loginVC];
//            self.window.rootViewController = loginVC;
            [self->_rootNavigationController setNavigationBarHidden:NO];
        }
        else {
            self->_rootNavigationController = [self navControllerWithRootViewController:loginVC];
//            self.window.rootViewController = loginVC;
            [self->_rootNavigationController setNavigationBarHidden:NO];
        }
        return [RACSignal empty];
    }];
    
    self->_setTabBarVCAsRootVCCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        self->_rootTabBarController = [self tabBarController];
        self.rootTabBarController.delegate = self;
        self->_rootNavigationController = [self navControllerWithRootViewController:self.rootTabBarController];
        self.window.rootViewController = self.rootNavigationController;
        
        [self->_rootNavigationController setNavigationBarHidden:YES];
        return [RACSignal empty];
    }];
    
    
    //
    self -> _showCompleteInfoVCCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self setupLoadNavRootVC:COMPLETE_INFO_VC];
        return [RACSignal empty];
    }];
    
    // ----
    self -> _showUploadAvatarVCCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self setupLoadNavRootVC:UPLOAD_AVATAR_VC];
        return [RACSignal empty];
    }];
    
    
    self->_setVerfifyVCCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        UIViewController *uploadVC = [[NSClassFromString(COMMITVERFIFYVC) alloc] init];
        if (self.rootNavigationController.presentedViewController) {
            [self.rootNavigationController dismissViewControllerAnimated:NO completion:^{
                
            }];
            @strongify(self);
            self->_rootNavigationController = [self navControllerWithRootViewController:uploadVC];
            self.window.rootViewController = self.rootNavigationController;
            [self->_rootNavigationController setNavigationBarHidden:NO];
        }
        else {
            self->_rootNavigationController = [self navControllerWithRootViewController:uploadVC];
            self.window.rootViewController = self.rootNavigationController;
            [self->_rootNavigationController setNavigationBarHidden:NO];
        }
        return [RACSignal empty];
    }];
}


- (void)setupLoadNavRootVC:(NSString *)vcName {
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    self->_rootNavigationController = [self navControllerWithRootViewController:vc];
    self.window.rootViewController = self.rootNavigationController;
    [self->_rootNavigationController setNavigationBarHidden:NO];
}

///// 监听用户不同登陆操作通知: 登陆成功 / 退出登陆 / 被踢
- (void)observerLoginStatus {
    @weakify(self);
    
    // 监听用户登陆成功的通知
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGIN_NOTIF_KEY object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
         
         [self.setTabBarVCAsRootVCCommand execute:@1];
     }];

    // 监听用户退出的通知
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGOUT_NOTIF_KEY object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
          [[HYUserContext shareContext] deployKickOutAction];
         [self.setLoginVCASRootVCComand execute:@1];
     }];
    

    // 监听用户被踢,Token过期的通知
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOG_KICK_OUT_NOTIF_KEY object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
         // 用户被踢后:
         // 1. 更新用户登录状态为 NO(清楚token信息)
         // 2. 展示 登陆界面
         [[HYUserContext shareContext] deployKickOutAction];
         [self.setLoginVCASRootVCComand execute:@1];
     }];
}


- (UIWindow *)keyWindow {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    UIViewController *loginVC = [[NSClassFromString(LOGIN_VC) alloc] init];
    self->_rootNavigationController = [self navControllerWithRootViewController:loginVC];
    window.rootViewController = self.rootNavigationController;
    [window makeKeyAndVisible];
    return window;
}

- (__kindof HYNavigationController *)navControllerWithRootViewController:(__kindof UIViewController *)vc {
    if (vc == nil) {
        vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
    }
    return [[HYNavigationController alloc] initWithRootViewController:vc];;
}

- (__kindof UITabBarController *)tabBarController {
    return [[HYRootTabBarViewController alloc] init];
}



@end
