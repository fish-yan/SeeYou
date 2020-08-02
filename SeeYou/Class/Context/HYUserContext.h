//
//  HYUserContext.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYUserCenterModel;
@interface HYUserContext : NSObject

@property(nonatomic ,assign) BOOL login; //是否登录

@property(nonatomic ,strong) NSString *uid;

@property(nonatomic ,copy) NSString * token;
@property(nonatomic ,assign) NSNumber * vipverifystatus;//0未交钱，1已近交钱
@property(nonatomic,copy) NSString* identityverifystatus;//判断是否认证过
@property(nonatomic ,strong) HYUserCenterModel *userModel;
@property(nonatomic ,assign) NSInteger defalutsex;

@property(nonatomic,assign) int maxpicture;

@property(nonatomic ,assign) BOOL autoSendCode;

// 对方称呼
@property (nonatomic, copy) NSString *objectCall;
@property (nonatomic, copy) NSString *avatarPlaceholder;

/// 用户数据环境单例
+ (instancetype)shareContext;

@end



@interface HYUserContext (DataAciton)


/// 读取本地用户数据
-(void) readUserInfo:(HYUserCenterModel *)userInfoModel;
///加载本地数据
- (void)loadUserInfoLocalDBData;


///跟新用户数据
- (void)updateUserInfo:(HYUserCenterModel*)model;

/// 获取最新的用户数据

- (void)fetchLatestUserinfoWithSuccessHandle:(void(^)(HYUserCenterModel *infoModel))successHandler
failureHandle:(void(^)(NSError *error))failureHandler;


-(void)getuserphotomaxsize;

@end


@interface HYUserContext (Deploy)

/// 部署退出登录后的操作: 更新状态/清除数据
- (void)deployLogoutAction;
/// 配置登陆成功后数据操作: 更新本地数据库信息
- (void)deployLoginActionWithUserModel:(HYUserCenterModel *)userModel;
- (void)deployLoginActionWithUserModelByRegister:(HYUserCenterModel *)userModel ;
- (void)deployLoginActionWithUserModel:(HYUserCenterModel *)userModel action:(void(^)(void))action;
/// 部署用户被踢操作: 更换登陆状态
- (void)deployKickOutAction;

@end


