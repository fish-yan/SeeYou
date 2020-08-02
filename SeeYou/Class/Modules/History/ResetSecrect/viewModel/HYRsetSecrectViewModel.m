//
//  HYRegisterViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYRsetSecrectViewModel.h"
#import "HYUserCenterModel.h"

@implementation HYRsetSecrectViewModel
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
    self.requestResetCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        
        NSString *string =[self.loginName stringByReplacingOccurrencesOfString:@" " withString:@""] ;
        NSDictionary *dic =nil;
        
        NSString * code = nil ;// self.type==1?API_FINDPASSWORD:API_RESETPASSWORD;
        
        if(self.type==1)
        {
        
            dic =@{@"verifycode":self.verifyCode, @"newpass":[AESUtility AES256EncryptPASSword:self.password ]};
            code =API_RESETPASSWORD;
        }
        else
        {
            code =API_FINDPASSWORD;
             dic =@{@"mobile":string, @"verifycode":self.verifyCode, @"newpass":[AESUtility AES256EncryptPASSword:self.password ]};
        
        }
        
        
        return [[self requestRegister:[NSDictionary convertParams:code dic:dic]] doNext:^(id  _Nullable x) {
            
        }];
        
    }];
    
    
    self.cutdownCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
         NSDictionary *dic =@{@"mobile":self.loginName,@"smstype":[NSNumber numberWithUnsignedInteger:self.codeType ]};
        return [[self requestCuntDown:[NSDictionary convertParams:API_VERIFYCODE dic:dic]] doNext:^(id  _Nullable x) {
            
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
