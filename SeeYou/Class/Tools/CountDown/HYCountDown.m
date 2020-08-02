//
//  HYCountDown.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYCountDown.h"


#define COUNTDOWN_TIMER(countDownTimer, countDown, limitedTime)  \
if (countDown > 0) return; \
__block NSInteger timeOut = limitedTime;    \
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); \
countDownTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);    \
dispatch_source_set_timer(countDownTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);\
dispatch_source_set_event_handler(countDownTimer, ^{    \
if(timeOut <= 0){ \
dispatch_source_cancel(countDownTimer); \
dispatch_async(dispatch_get_main_queue(), ^{    \
countDown = 0;  \
}); \
}   \
else{   \
int seconds = timeOut % 60; \
dispatch_async(dispatch_get_main_queue(), ^{ \
countDown = seconds; \
}); \
timeOut--; \
} \
}); \
dispatch_resume(countDownTimer); \

@interface HYCountDown()
{
dispatch_source_t _registerTimer;
dispatch_source_t _loginTimer;
dispatch_source_t _resetPwdTimer;
}
@end

@implementation HYCountDown
+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    static HYCountDown *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
       
    });
    return instance;
}

-(id)init
{
    self =[super init];
    if(self)
    {
        self.registerTime=-1;
        self.LoginTime=-1;
        self.resetPwdTime =-1;
    }
    return self;
}
- (void)startWithCountDownType:(WDCountDownType)countDownType limitedTime:(NSInteger)limitedTime {
    switch (countDownType) {
        case WDCountDownTypeRegister: {
            if(_registerTimer)
                COUNTDOWN_TIMER(_registerTimer, self.registerTime, limitedTime);
            break;
        }
        case WDCountDownTypeLogin: {
            COUNTDOWN_TIMER(_loginTimer, self.LoginTime, limitedTime);
            break;
        }
        case WDCountDownTypeResetPwd: {
            COUNTDOWN_TIMER(_resetPwdTimer, self.resetPwdTime, limitedTime);
            break;
        }
        default:
            break;
    }
}

- (void)stopCountDownWitType:(WDCountDownType)countDownType {
    switch (countDownType) {
        case WDCountDownTypeRegister: {
            dispatch_source_cancel(_registerTimer);
            self.registerTime = 0;
            break;
        }
        case WDCountDownTypeLogin: {
            dispatch_source_cancel(_loginTimer);
            self.LoginTime = 0;
            break;
        }
        case WDCountDownTypeResetPwd: {
            dispatch_source_cancel(_resetPwdTimer);
            self.resetPwdTime = 0;
            break;
        }
        default:
            break;
    }
}

@end
