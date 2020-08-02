//
//  HYLoginRegisterVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/5/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYLoginRegisterVM.h"
#import "HYCountDown.h"

@interface HYLoginRegisterVM ()
@property (nonatomic, strong) RACCommand *cutdownCmd;
@end

@implementation HYLoginRegisterVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.getMobileCodeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic = @{@"smstype": @15,
                              @"mobile": self.mobile ?: @""
                              };
        
        return [[[self getMobileCodeSignal:[NSDictionary convertParams:API_VERIFYCODE dic:dic]]
                doNext:^(id  _Nullable x) {
                    [[HYCountDown shareHelper] startWithCountDownType:WDCountDownTypeRegister limitedTime:59];
                }]
                map:^id _Nullable(WDResponseModel * _Nullable value) {
                    return value.msg;
                }];
    }];
    
    // ------------
    self.verifyCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic = @{@"verifycode": self.code ?: @"",
                              @"mobile": self.mobile ?: @""
                              };
        return [[[self verifySignal:[NSDictionary convertParams:API_NEW_VERIFY_CODE dic:dic]]
                doNext:^(WDResponseModel * _Nullable x) {
                    @strongify(self);
                    [[HYUserContext shareContext] deployLoginActionWithUserModel:x.data action:NULL];
                    self.infoType = [HYUserContext shareContext].userModel.iscomplete;
                }]
                map:^id _Nullable(WDResponseModel * _Nullable value) {
                    return value.msg;
                }];
    }];

    [[RACObserve([HYCountDown shareHelper], registerTime) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.cutdownTime = [x integerValue];
        self.resendEnable = [x integerValue] <= 0;
    }];
    
}


- (RACSignal *)verifySignal:(NSDictionary *)params {
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:params
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeObject
                                    responseClass:[HYUserCenterModel class]];
}

- (RACSignal *)getMobileCodeSignal:(NSDictionary *)params {
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:params
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeMessage
                                    responseClass:nil];
}

@end
