//
//  HySettingViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/21.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HySettingViewModel.h"

@implementation HySettingViewModel

-(id) init
{
    self =[super init];
    if(self)
    {
    
        [self initalize];
    }
    return self;
}

- (void) initalize
{
    @weakify(self);
    self.doCommand  =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        NSDictionary *dic=@{};
        return [[self logout:[NSDictionary convertParams:API_LOGIN_OUT dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            
        }];
    }];
    
}

-(RACSignal * )logout:(NSDictionary *)dic
{
    RACSignal * signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return  signal;
}
@end
