//
//  HYCountDown.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, WDCountDownType) {
    WDCountDownTypeRegister,   // 注册
    WDCountDownTypeLogin,   // 登录
    WDCountDownTypeResetPwd,    // 重置密码
};

@interface HYCountDown : NSObject

+ (instancetype)shareHelper;

/// 注册号倒计时剩下的时间
@property (nonatomic, assign) NSInteger registerTime;
/// 登陆倒计时剩下的时间
@property (nonatomic, assign) NSInteger LoginTime;
/// 重置密码验证手机倒计时剩下的时间
@property (nonatomic, assign) NSInteger resetPwdTime;

- (void)startWithCountDownType:(WDCountDownType)countDownType limitedTime:(NSInteger)limitedTime;
- (void)stopCountDownWitType:(WDCountDownType)countDownType;

@end
