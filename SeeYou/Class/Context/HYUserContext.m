//
//  HYUserContext.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserContext.h"
#import "HYUserCenterModel.h"
#import "HYDBManager.h"
#import "NSDictionary+Convert.h"
#import "AppVersionModel.h"


@implementation HYUserContext
+ (instancetype)shareContext {
    static dispatch_once_t onceToken;
    static HYUserContext *instance = nil;

    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {
    self.defalutsex = 0;

    NSString *sex = [[NSUserDefaults standardUserDefaults] objectForKey:USER_REGISTER_MOBILE_KEY];
    if (sex.length > 0) {
        self.defalutsex = [sex intValue];
    }
    self.userModel = [[HYUserCenterModel alloc] init];

    [self bindmodel];
}


- (void)bindmodel {
    [RACObserve(self, uid) subscribeNext:^(NSString *_Nullable x) {

        if (x) {
            [self checkAppUpdate];
        }
    }];
}


- (void)checkAppUpdate {
    // cmd must 强制跟新 no 不更新

    NSDictionary *dic = @{ @"appid": @"1002", @"version": APP_VERSION };

    NSDictionary *params = [NSDictionary convertParams:API_CHECKUPDATE dic:dic];

    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@""
                                                        params:params
                                                   requestType:WDRequestTypePOST
                                                  responseType:WDResponseTypeObject
                                                 responseClass:[AppVersionModel class]];


    [signal subscribeNext:^(WDResponseModel *_Nullable x) {


        AppVersionModel *v = x.data;
        if ([v.updatecmd isEqualToString:@"no"]) {
        } else if ([v.updatecmd isEqualToString:@"must"]) {
            id cancelBlock = ^() {

            };
            id sureBlock = ^() {

            };
            NSString *str = [NSString stringWithFormat:@"%@,%@", v.newdate, v.newnote];

            [YSMediator presentToViewController:@"HYAlertViewController"
                                     withParams:@{
                                         @"alertTitle": [NSString stringWithFormat:@"v%@", v.newversion],
                                         @"message": str,
                                         @"type": @1,
                                         @"leftButtonTitle": @"更新",
                                         @"leftTitleColor": [UIColor tcff8bb1Color],
                                         @"cancelBlock": cancelBlock,
                                         @"sureBlock": sureBlock
                                     }
                                       animated:YES
                                       callBack:nil];

        } else if ([v.updatecmd isEqualToString:@"suggest"]) {
            id cancelBlock = ^() {

            };
            id sureBlock = ^() {

            };
            NSString *str = [NSString stringWithFormat:@"%@", v.newnote];

            [YSMediator presentToViewController:@"HYAlertViewController"
                                     withParams:@{
                                         @"alertTitle": v.newversion,
                                         @"message": str,
                                         @"type": @2,
                                         @"leftButtonTitle": @"取消",
                                         @"rightButtonTitle": @"更新",
                                         @"rightTitleColor": [UIColor tcff8bb1Color],
                                         @"cancelBlock": cancelBlock,
                                         @"sureBlock": sureBlock
                                     }
                                       animated:YES
                                       callBack:nil];
        }


        NSLog(@"12313");

    }
                    error:^(NSError *_Nullable error){


                    }];
}

@end


@implementation HYUserContext (DataAciton)

- (void)loadUserInfoLocalDBData {
    HYUserCenterModel *obj = [[HYDBManager shareManager] searchSingle:[HYUserCenterModel class] where:nil orderBy:nil];
    if (obj && [obj isKindOfClass:[HYUserCenterModel class]]) {
        self.userModel = obj;
        [self readUserInfo:obj];
        self.login = [self getLoginStatus];
    }
}

/// 获取登录状态
- (BOOL)getLoginStatus {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LOGIN_KEY];
    return (obj == nil || ![obj boolValue]) ? NO : YES;
}


/// 读取本地用户数据
- (void)readUserInfo:(HYUserCenterModel *)userInfoModel {
    if (self.uid != userInfoModel.uid && userInfoModel.uid != nil) {
        self.uid = userInfoModel.uid;
    }
    if (self.token != userInfoModel.token && userInfoModel.token != nil) {
        self.token = userInfoModel.token;
    }

    self.vipverifystatus      = userInfoModel.vipstatus;
    self.identityverifystatus = userInfoModel.identityverifystatus;
}
/// 更新用户数据
- (void)updateUserInfo:(HYUserCenterModel *)userInfoModel {
    self.userModel = userInfoModel;

    if (self.uid != userInfoModel.uid && userInfoModel.uid != nil) {
        self.uid = userInfoModel.uid;
    }
    if (self.token != userInfoModel.token && userInfoModel.token != nil) {
        self.token = userInfoModel.token;
    }
    if (userInfoModel.vipstatus != nil) {
        self.vipverifystatus = userInfoModel.vipstatus;
    }


    self.identityverifystatus = userInfoModel.identityverifystatus;

    self.userModel.token = self.token;

    [self saveLastestUserDateToDB];
}

/// 保存最新的用户信息
- (void)saveLastestUserDateToDB {
    // 删除数据库中已有的用户信息, 保存最新的
    [self deleteUserDBData];
    [[HYDBManager shareManager] insertToDB:self.userModel];
}

/// 删除本地数据库用户数据
- (void)deleteUserDBData {
    HYDBManager *mgr = [HYDBManager shareManager];
    BOOL b           = [mgr deleteWithClass:[HYUserCenterModel class] where:nil];
    if (b) {
        NSLog(@"ok");
    }
}


/// 清除Token信息
- (void)clearUserModelInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_REGISTER_MOBILE_KEY];
    self.token = nil;
}
//从服务端获取最新的用户基本信息
- (void)fetchLatestUserinfoWithSuccessHandle:(void (^)(HYUserCenterModel *))successHandler
                               failureHandle:(void (^)(NSError *))failureHandler {
    NSDictionary *params = @{};
    RACSignal *s         = [WDRequestAdapter requestSignalWithURL:@""
                                                   params:[NSDictionary convertParams:APT_USERINFO dic:params]
                                              requestType:WDRequestTypePOST
                                             responseType:WDResponseTypeObject
                                            responseClass:[HYUserCenterModel class]];
    @weakify(self);
    [s subscribeNext:^(WDResponseModel *_Nullable x) {
        @strongify(self);
        HYUserCenterModel *infoModel = x.data;
        [self updateUserInfo:infoModel];

        if (successHandler) {
            successHandler(infoModel);
        }
    }
    error:^(NSError *_Nullable error) {
        if (failureHandler) {
            failureHandler(error);
        }
    }];
}


- (void)getuserphotomaxsize {
    NSDictionary *params = @{};
    RACSignal *s         = [WDRequestAdapter requestSignalWithURL:@""
                                                   params:[NSDictionary convertParams:API_GETUPLOADMAXPHOTO dic:params]
                                              requestType:WDRequestTypePOST
                                             responseType:WDResponseTypeObject
                                            responseClass:[WDResponseModel class]];
    @weakify(self);
    [s subscribeNext:^(WDResponseModel *_Nullable x) {
        @strongify(self);

        self.maxpicture = [x.extra intValue];

    }
    error:^(NSError *_Nullable error) {

        @strongify(self);
        self.maxpicture = 9;

    }];
}


@end


@implementation HYUserContext (Deploy)

- (void)deployLogoutAction {
    [self updateLoginStatus:NO];
    [self deleteUserDBData];
    [self clearUserModelInfo];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"forwardimage"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"backwardimage"];


    // 发送退出通知, AppDelegateUIAssistant 接受通知更换控制器为LoginViewController
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NOTIF_KEY object:nil];
}

- (void)deployLoginActionWithUserModel:(HYUserCenterModel *)userModel action:(void (^)(void))action {
    self->_userModel = userModel;
    [self updateUserInfo:userModel];
    [self updateLoginStatus:YES];
}

- (void)deployLoginActionWithUserModel:(HYUserCenterModel *)userModel {
    [self
    deployLoginActionWithUserModel:userModel
                            action:^{
                                // 登陆成功后发送通知, AppDelegateUIAssistant 接受通知更换控制器为TabBarViewController
                                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIF_KEY object:nil];
                            }];
}

- (void)deployLoginActionWithUserModelByRegister:(HYUserCenterModel *)userModel {
    self->_userModel = userModel;
    [self readUserInfo:userModel];
    [self updateUserInfo:userModel];
    [self updateLoginStatus:YES];
    [self saveLastestUserDateToDB];
}


- (void)deployKickOutAction {
    [self updateLoginStatus:NO];
    [self deleteUserDBData];
    [self clearUserModelInfo];
}
- (void)updateLoginStatus:(BOOL)isLogin {
    self.login = isLogin;
    // 更新登录状态
    [[NSUserDefaults standardUserDefaults] setObject:isLogin ? @1 : @0 forKey:USER_DEFAULTS_LOGIN_KEY];
    // 保存上一次登录的用户的手机号码
    [[NSUserDefaults standardUserDefaults] setObject: self.userModel.mobile ?: @""
                                              forKey:USER_REGISTER_MOBILE_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
   
}

- (NSString *)objectCall {
    if ([self.userModel.sex isEqualToString:@"男"]) {
        return @"她";
    }
    return @"他";
}

- (NSString *)avatarPlaceholder {
    if ([self.userModel.sex isEqualToString:@"男"]) {
        return @"pwoman";
    }
    return @"pman";
}

@end
