//
//  HYTransferMoneyVM.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/18.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYTransferMoneyVM.h"

@implementation HYTransferMoneyVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.transferCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [self transferSignal];
    }];
}

- (RACSignal *)transferSignal {
    NSDictionary *params = @{@"balance": self.money};
    // BigDecimal balance;
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:[NSDictionary convertParams:@"profitreturnbalance" dic:params]
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeMessage
                                    responseClass:nil];
}

@end
