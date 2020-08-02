//
//  AuthenticationManager.m
//  CPPatient
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "AuthenticationManager.h"

@implementation AuthenticationStatus

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"cardNumber":@"personcard",
             @"reason":@"desc"};
}

@end



@implementation AuthenticationManager

+ (void) GetAuthenticationManagerStatus
{
    
    [WDProgressHUD showInView:nil];
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@"" params:@{@"uid":@""} requestType:WDRequestTypeGET responseType:WDResponseTypeObject responseClass:[AuthenticationStatus class]];
    
    @weakify(self);
    // 获取最新实名认证状态
    [signal subscribeNext:^(WDResponseModel * _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        AuthenticationStatus * m = x.data;
//        [WDUserContext shareContext].userModel.info.identifyStatus = m.status;
//        [[WDUserContext shareContext] updateUserInfo:[WDUserContext shareContext].userModel.info];
        [self switchControllerByAuthentication:m];
    } error:^(NSError * _Nullable error) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:error.localizedDescription];
    }];

 
}

// 
+ (void)switchControllerByAuthentication:(AuthenticationStatus *)identifyStatus {
//    AuthenticationType status = [identifyStatus.status integerValue];
//    switch (status) {
//            // 从未市民认证
//        case AuthenticationNOTYPE:
//            [YSMediator pushViewControllerClassName:@"RealNameAuthenticationViewController" withParams:nil animated:YES callBack:nil];
//            break;
//            // 实名认证成功
//        case AuthenticationSUCCESSTYPE:
//        {
//            [[WDUserContext shareContext] fetchLatestUserInfoWithSuccessHandle:nil failureHandle:nil];
//            
//            [YSMediator pushViewControllerClassName:@"AuthenticationIngCommitSuccessViewController"
//                                         withParams:@{
//                                                      @"username"       : identifyStatus.name?:@"",
//                                                      @"useridentify"   : identifyStatus.cardNumber?:@"",
//                                                      @"type"           : @"3"
//                                                      }
//                                           animated:YES
//                                           callBack:nil];
//        }
//            break;
//            // 实名认证审核中
//        case AuthenticationINGTYPE:
//            [YSMediator pushViewControllerClassName:@"AuthenticationIngCommitSuccessViewController"
//                                         withParams:@{
//                                                      @"username"       : identifyStatus.name?:@"",
//                                                      @"useridentify"   : identifyStatus.cardNumber?:@"",
//                                                      @"type"           : @"2"
//                                                      }
//                                           animated:YES
//                                           callBack:nil];
//            break;
//            // 实名认证失败
//        case AuthenticationFAILEDTYPE:
//            [YSMediator pushViewControllerClassName:@"CPAuthenticationFailedViewController"
//                                         withParams:@{
//                                                      @"username"       : identifyStatus.name?:@"",
//                                                      @"useridentify"   : identifyStatus.cardNumber?:@"",
//                                                      @"reason"         : identifyStatus.reason?:@""
//                                                      }
//                                           animated:YES
//                                           callBack:nil];
//            break;
//        default:
//            break;
//    }
}
@end
