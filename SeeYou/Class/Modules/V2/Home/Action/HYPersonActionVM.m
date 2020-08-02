//
//  HYPersonActionVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/29.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYPersonActionVM.h"

@implementation HYPersonActionVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.heartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [self heartSignalWithParams:input];
    }];
}


- (RACSignal *)heartSignalWithParams:(NSDictionary *)params {
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:API_ISBEMOVED dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeObject
                                     responseClass:[HYObjectListModel class]]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return value.msg;
            }];
}

@end
