//
//  HYRegisterViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYRegisterViewModel.h"
#import "HYUserCenterModel.h"

@implementation HYRegisterViewModel
- (id)init
{
    self =[super init];
    if(self)
    {
        [self initialize];
    }
    return self;
}


#pragma mark initialize
- (void)initialize
{

    @weakify(self);
    self.requestRegisterCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       
        @strongify(self);
        
        NSString * sex = [HYUserContext shareContext].defalutsex ==1? @"男":@"女";
        
        NSString *string =[self.loginName stringByReplacingOccurrencesOfString:@" " withString:@""] ;
        NSDictionary *dic =@{@"mobile":string, @"verifycode":self.verifyCode, @"password":[AESUtility AES256EncryptPASSword:self.password ],@"sex":sex};
        
        return [[self requestRegister:[NSDictionary convertParams:API_REGISTER dic:dic ]] doNext:^(WDResponseModel *  _Nullable x) {
            
            
            [[HYUserContext shareContext] readUserInfo:x.data];
            [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
                 [[HYUserContext shareContext] deployLoginActionWithUserModelByRegister:infoModel];
                
                
                AppDelegateUIAssistant *assistant = [AppDelegateUIAssistant shareInstance];
                if ([HYUserContext shareContext].login) {
                    
                    if([[HYUserContext shareContext].userModel.vipstatus boolValue])
                    {
                        [assistant.setTabBarVCAsRootVCCommand execute:@1];
                    }
                    else
                    {
                        if([[HYUserContext shareContext].identityverifystatus isEqualToString:@"1"])
                        {
                            [assistant.setUploadMonayVCCommand execute:@1];
                        }
                        else
                        {
                            [assistant.setVerfifyVCCommand execute:@1];
                        }
                        
                    }
                    
                } else {
                    [assistant.setLoginVCASRootVCComand execute:@1];
                }
                
            } failureHandle:^(NSError *error) {
               
            }];
         
            
        }];
        
    }];
    
    
    self.cutdownCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic =@{@"mobile":self.loginName,@"smstype":[NSNumber numberWithUnsignedInteger:self.codeType ]};
        
        return [[self requestCuntDown: [NSDictionary convertParams:API_VERIFYCODE dic:dic ]] doNext:^(id  _Nullable x) {
            
        } ];
        
    }];
}


-(RACSignal *)requestRegister:(NSDictionary* )dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[HYUserCenterModel class]];
    return signal;
}


-(RACSignal *)requestCuntDown:(NSDictionary* )dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}
@end
