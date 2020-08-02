//
//  HYRegisterViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYRegisterViewModel.h"
@interface HYRsetSecrectViewModel : HYBaseViewModel

@property (nonatomic, assign) LoginViewType viewType;

//用户登录账户
@property (nonatomic, copy) NSString *loginName;

//密码
@property (nonatomic, copy) NSString *password;

//验证码
@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, assign) VerifyCodeType codeType;


@property (nonatomic ,assign) int type; //1 表示修改密码 其他 忘记密码

@property(nonatomic ,strong) RACCommand *requestResetCommond;
@property(nonatomic ,strong) RACCommand *cutdownCommond;



@end
