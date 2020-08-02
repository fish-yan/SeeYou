//
//  HYRechargeViewModel.m
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYRechargeViewModel.h"
#import "HYPopDataModel.h"

@implementation HYRechargeViewModel
- (id)init {
    self = [super init];
    if (self) {
        [self initalize];
    }
    return self;
}
- (void)initalize {
    @weakify(self);
    self.getProductListCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
        @strongify(self);
        return [[self productSignal]
                doNext:^(NSArray * _Nullable x) {
                    @strongify(self);
                    self.dataArray = x.mutableCopy;
                }];
    }];

    self.getOderidInfoRaccommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(id _Nullable input) {
        @strongify(self);
        return [[self requestPayOrderSignalWithID:input]
                doNext:^(WDResponseModel *_Nullable x) {
                    @strongify(self);
                    self.payModel = x.data;
                }];
    }];
}


- (RACSignal *)productSignal {
    NSDictionary *params = @{@"type":@"3"};
    RACSignal *sig = [[WDRequestAdapter requestSignalWithURL:@""
                                                      params:[NSDictionary convertParams:API_getmemberproduct dic:params]
                                                 requestType:WDRequestTypePOST
                                                responseType:WDResponseTypeList
                                               responseClass:[HYFinanceModel class]]
                      map:^id _Nullable(WDResponseModel * _Nullable value) {
                          return value.data;
                      }] ;
    return sig;
}

- (RACSignal *)requestPayOrderSignalWithID:(NSString *)orderID {
    NSDictionary *params = @{@"id":orderID ?: @""};
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:[NSDictionary convertParams:API_PREPAYMENTOEDER dic:params]
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeObject
                                    responseClass:[HYOrderPayModel class]];
}

@end
