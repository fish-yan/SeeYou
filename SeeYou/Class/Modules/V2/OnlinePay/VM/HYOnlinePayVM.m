//
//  HYOnlinePayVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/27.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYOnlinePayVM.h"

@interface HYOnlinePayVM ()

//@property (nonatomic, strong) HYOnlinePayHelper *onlinePayHelper;
@property (nonatomic, strong) HYOnlinePayInfoModel *payInfoModel;

@end


@implementation HYOnlinePayVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
//    self.onlinePayHelper = [HYOnlinePayHelper new];
    
    @weakify(self);
    self.payCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[[self payInfoSignal:self.payType]
                 then:^RACSignal * _Nonnull{
                     @strongify(self);
                     return [self payActionSignal];
                 }]
                then:^RACSignal * _Nonnull{
                    @strongify(self);
                    return [self updateDataStatus];
                }] ;
    }];
}

- (RACSignal *)payActionSignal {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [[HYOnlinePayHelper shareHelper] onlinePay:self.payType
                                       withPayInfo:self.payInfoModel
                                            result:^(id obj, NSError *error) {
                                                if (error) {
                                                    [subscriber sendError:error];
                                                    return;
                                                }
                                             
                                                [subscriber sendNext:obj];
                                                [subscriber sendCompleted];
                                            }];
        
        return nil;
    }];
}

- (RACSignal *)updateDataStatus {
    NSDictionary* params = @{@"id":self.orderId};
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:API_CHANGEORDERSTATUS dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeMessage
                                     responseClass:nil]
            map:^id _Nullable(id  _Nullable value) {
                NSLog(@"--%@", value);
                return value;
            }];
    
}

- (RACSignal *)payInfoSignal:(OnlinePayType)type {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.orderId?: @"" forKey:@"id"];
    NSString *api = API_EXECUTEALIPAY;
    
    if (type == OnlinePayTypeWeChat) {
        [params setObject:@"1" forKey:@"apptype"];
        api = API_EXECUTEWECHATPAY;
    }
    
    @weakify(self);
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:api dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeObject
                                     responseClass:[HYOnlinePayInfoModel class]]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                @strongify(self);
                self.payInfoModel = value.data;
                return value.data;
            }];
    
}
@end
