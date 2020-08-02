//
//  LoginbaseinfoViewModel.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/5.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "LoginbaseinfoViewModel.h"
#import "HYBaseInfoModel.h"
#import "HYBaseInfoVeiwModel.h"
@implementation LoginbaseinfoViewModel
- (id) init
{
    self =[super init];
    if(self)
    {
        [self initalize];
    }
    return self;
}


- (void)initalize
{
    @weakify(self);
    self.doRaccommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary*  _Nullable input) {
        @strongify(self);
        return [[self postuserdetaildata:[NSDictionary convertParams:API_SAVEPARTUSE_DATA dic:input] ] doNext:^(id  _Nullable x) {
            
        }];
    }];

}

- (RACSignal*) postuserdetaildata:(NSDictionary*)dic
{

    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}

@end

