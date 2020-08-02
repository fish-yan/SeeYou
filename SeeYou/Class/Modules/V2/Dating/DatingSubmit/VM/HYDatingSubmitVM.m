//
//  HYDatingSubmitVM.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/11.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYDatingSubmitVM.h"

@implementation HYDatingSubmitVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.requestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self requestSignal] doNext:^(id  _Nullable x) {
            @strongify(self);
            self.ruleHtmlString = x;
        }];
    }];
}

- (RACSignal *)requestSignal {
    NSDictionary *params = @{};
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:@"getbailexplain" dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeMessage
                                     responseClass:nil]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return value.extra;
            }] ;
}

@end
