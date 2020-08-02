//
//  HYMembershipVM.m
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMembershipVM.h"

@implementation HYMembershipVM
- (id)init {
    self = [super init];
    if (self) {
        [self initalize];
    }
    return self;
}

- (void)initalize {
    @weakify(self);
    self.doRaccommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
        @strongify(self);
        return [[self checkInfo:[NSDictionary convertParams:API_CHECK_APPLE dic:input]]
                doNext:^(WDResponseModel *_Nullable x){
                }];
    }];

    self.getOrderid = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(id _Nullable input) {
        @strongify(self);
        return [[self getorderid:[NSDictionary convertParams:API_GETORDERID dic:input]]
                doNext:^(WDResponseModel *_Nullable x) {
                    @strongify(self);
                    self.orderid = x.extra;
                }];
    }];
}
- (RACSignal *)checkInfo:(NSDictionary *)dic {
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@""
                                                        params:dic
                                                   requestType:WDRequestTypePOST
                                                  responseType:WDResponseTypeMessage
                                                 responseClass:nil];
    return signal;
}

- (RACSignal *)getorderid:(NSDictionary *)dic {
    RACSignal *signal = [WDRequestAdapter requestSignalWithURL:@""
                                                        params:dic
                                                   requestType:WDRequestTypePOST
                                                  responseType:WDResponseTypeObject
                                                 responseClass:[NSString class]];
    return signal;
}

@end
