//
//  HYWithDarwMoneyVM.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/18.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYWithDarwMoneyVM.h"

@implementation HYWithDarwMoneyVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.withDarwCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self withDarwSignal] doNext:^(id  _Nullable x) {
            NSLog(@"---");
        }];
    }];
}

- (RACSignal *)withDarwSignal {
    NSDictionary *params = @{};
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:[NSDictionary convertParams:@"" dic:params]
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeMessage
                                    responseClass:nil];
}

@end
