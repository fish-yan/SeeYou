//
//  HYLoginViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYLoginViewModel.h"
#import "HYUserCenterModel.h"

@implementation HYLoginViewModel
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
    self.loginCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        
        NSString *usernameString = [self.userName stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[NSUserDefaults standardUserDefaults] setObject:usernameString  forKey:USER_REGISTER_MOBILE_KEY];
        NSDictionary *dictionary = @{@"mobile":usernameString,@"password":[AESUtility AES256EncryptPASSword:self.password ]};
        return [[self requestLogin: [NSDictionary convertParams:API_LOGIN dic:dictionary]] doNext:^(WDResponseModel *  _Nullable x) {
            
            [[HYUserContext shareContext] readUserInfo:x.data];
            [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
             
                  [[HYUserContext shareContext] readUserInfo:x.data];
                
                [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
                    
                    [[HYUserContext shareContext] deployLoginActionWithUserModelByRegister:infoModel];
                    
                    
                    
                    AppDelegateUIAssistant *assistant = [AppDelegateUIAssistant shareInstance];
                    if ([HYUserContext shareContext].login) {

                        if([[HYUserContext shareContext].vipverifystatus boolValue])
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
                
                
                
                
                
                
                
                
                
                
            } failureHandle:^(NSError *error) {
                
            }];
            
            
            
           
        }];
        
    }];
    
    
  
}


- (RACSignal*)requestLogin:(NSDictionary *)dic
{
    
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@""  params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[HYUserCenterModel class]];
    return signal;
}



@end
