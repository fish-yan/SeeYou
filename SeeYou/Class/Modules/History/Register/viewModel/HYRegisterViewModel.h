//
//  HYRegisterViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"


typedef enum {
    LoginViewTypeCode,              //验证码登录
    LoginViewTypePWD ,              //账号密码登录
    LoginViewTypeForget,            //忘记密码登录
    LoginViewTypeFirst,             //第一次安装APP注册登录
    
} LoginViewType;
typedef NS_ENUM(NSUInteger, VerifyCodeType) {
    VerifyCodeTypeDeafult = 0,  // 默认
    VerifyCodeTypeRegist = 10,   //注册
    VerifyCodeTypePhoneLogin = 2,  //手机动态码
    VerifyCodeTypeResetPassword = 12,  //重置密码
    
    VerifyCodeTypeFindPassword = 13,//找回密码
    VerifyCodeTypeBindPhoneNew = 5,
    VerifyCodeTypeBindPhoneNew1 = 6,
    VerifyCodeTypeNewCodeLogin = 7,
};
@interface HYRegisterViewModel : HYBaseViewModel

@property (nonatomic, assign) LoginViewType viewType;

//用户登录账户
@property (nonatomic, copy) NSString *loginName;

//密码
@property (nonatomic, copy) NSString *password;


//验证码
@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, assign) VerifyCodeType codeType;


@property(nonatomic ,strong) RACCommand *requestRegisterCommond;
@property(nonatomic ,strong) RACCommand *cutdownCommond;

@end
