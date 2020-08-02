//
//  HYUpdateUserInfoHelper.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/29.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUpdateUserInfoHelper.h"

@implementation HYUpdateUserInfoHelper

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.updateCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self updateSignalWithParams:input] doNext:^(id  _Nullable x) {
            NSLog(@"--");
        }];
    }];
}

- (RACSignal *)updateSignalWithParams:(NSDictionary *)params {
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:API_EDITORUSERINFO dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeMessage
                                     responseClass:nil]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return value.msg;
            }];
}

@end
