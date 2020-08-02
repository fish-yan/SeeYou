//
//  HYMyAccountVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMyAccountVM.h"
#import "HYMyAccountCellModel.h"
#import "HYMyAccountModel.h"

@implementation HYMyAccountVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self combineDataWithModel:nil];
    
    
    @weakify(self);
    self.requestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[[self requestSignal] map:^id _Nullable(WDResponseModel * _Nullable value) {
            return value.data;
        }] doNext:^(id  _Nullable x) {
            @strongify(self);
            [self combineDataWithModel:x];
        }];
    }];

}

- (void)combineDataWithModel:(HYMyAccountModel *)model {
    self.balance = [model.balance doubleValue] != 0 ? model.balance : @"0.00";
    self.profit = [model.profit doubleValue] != 0 ? model.profit : @"0.00";
    
    self.dataArray = @[
                       [HYMyAccountCellModel modelWithType:HYMyAccountCellTypeWallet
                                                     title:@"我的钱包"
                                                      desc:@"约会保证金账户"
                                                  andValue:[NSString stringWithFormat:@"%@元", self.balance]],
                       [HYMyAccountCellModel modelWithType:HYMyAccountCellTypeIncome
                                                     title:@"我的收益"
                                                      desc:@"邀请好友、收礼获得的利益"
                                                  andValue:[NSString stringWithFormat:@"%@元", self.profit]],
                       ];
}

- (RACSignal *)requestSignal {
    NSDictionary *params = [NSDictionary convertParams:API_USER_BALANCE dic:@{}];
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:params
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeObject
                                    responseClass:[HYMyAccountModel class]];
}

@end
