//
//  IAPHelperViewModel.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/10.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "IAPHelperViewModel.h"

@interface IAPHelperViewModel ()

@property (nonatomic, strong) IAPHelper *iapHelper;

@end

@implementation IAPHelperViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self __initialize];
    }
    return self;
}

- (void)__initialize {
    self.iapHelper = [IAPHelper helper];
    
    @weakify(self);
    self.checkReceiptCmd =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString *  _Nullable receipt) {
        @strongify(self);
        NSDictionary *params = @{@"receipt_data": receipt ?: @"",
                                 @"id": self.orderid ?: @""};
        return [self checkReceiptSignal:[NSDictionary convertParams:API_CHECK_APPLE dic:params]];
    }];
    
    self.fetchOrderIDCmd =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        
        [self.iapHelper finishUncomplatePurchase];
        NSDictionary *params = @{@"no": self.identifier ?: @""};
        return [[self fetchOrderIDSignal:[NSDictionary convertParams:API_GETORDERID dic:params]]
                doNext:^(WDResponseModel *  _Nullable x) {
                    @strongify(self);
                    self.orderid = x.extra;
                }];
    }];
}

- (void)fetchDataWithResult:(void(^)(NSArray *dataArray, NSError *error))result {
    if (!self.productIdentifiers || self.productIdentifiers.count == 0) {
        NSError *error = [NSError errorWithDomain:NSArgumentDomain
                                             code:1004
                                         userInfo:@{NSLocalizedDescriptionKey: @"参数错误"}];
        if (result) {
            result(nil, error);
        }
        return;
    }
    [self.iapHelper fetchIAPProducts:self.productIdentifiers
                          withResult:^(NSArray<SKProduct *> * _Nonnull products, NSError * _Nonnull error) {
                              if (error) {
                                  if (result) {
                                      result(products, error);
                                  }
                                  return;
                              }
                              if ([products count] == 0) {
                                  NSError *emptyError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                                            code:1001
                                                                        userInfo:@{NSLocalizedDescriptionKey: @"暂无商品可以销售"}];
                                  if (result) {
                                      result(products, emptyError);
                                  }
                                  return;
                              }
                              
                              if (result) {
                                  result(products, nil);
                              }
                          }];
    
}

- (void)purchaseWithResult:(void(^)(NSString *receipt, NSError *error))result {
    [self.iapHelper purchaseIdentrifier:self.identifier withRestult:result];
}


-(RACSignal *)checkReceiptSignal:(NSDictionary*)dic {
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@""
                                                       params:dic
                                                  requestType:WDRequestTypePOST
                                                 responseType:WDResponseTypeMessage
                                                responseClass:nil];
    return signal;
}

-(RACSignal *)fetchOrderIDSignal:(NSDictionary*)dic {
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@""
                                                       params:dic
                                                  requestType:WDRequestTypePOST
                                                 responseType:WDResponseTypeObject
                                                responseClass:[NSString class]];
    return signal;
}


@end
