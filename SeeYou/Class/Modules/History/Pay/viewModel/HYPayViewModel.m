//
//  HYPayViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/17.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYPayViewModel.h"
#import "alipayModel.h"
#import "WXApi.h"
@implementation HYPayViewModel

- (id)init {
    self = [super init];
    if (self) {
        [self initalize];
    }
    return self;
}

- (void)initalize {
    @weakify(self);
    self.doCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
        @strongify(self);

        NSString *apicode = API_EXECUTEALIPAY;
        return [[self noticeServerMyorderOk:[NSDictionary convertParams:apicode dic:input]] doNext:^(id _Nullable x){

        }];
    }];

    self.doWechatCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {

        @strongify(self);
        NSString *apicode = API_EXECUTEWECHATPAY;
        return [[self noticeServerMyorderOkWechat:[NSDictionary convertParams:apicode dic:input]] doNext:^(id _Nullable x){

        }];
    }];
}

- (RACSignal *)noticeServerMyorderOkWechat:(NSDictionary *)dic {
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@""
                                                        params:dic
                                                   requestType:WDRequestTypePOST
                                                  responseType:WDResponseTypeObject
                                                 responseClass:[wechatpayModel class]];
    return signal;
}


- (RACSignal *)noticeServerMyorderOk:(NSDictionary *)dic {
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@""
                                                        params:dic
                                                   requestType:WDRequestTypePOST
                                                  responseType:WDResponseTypeObject
                                                 responseClass:[alipayModel class]];
    return signal;
}

@end
