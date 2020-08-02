//
//  IAPHelperViewModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/10.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "IAPHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface IAPHelperViewModel : HYBaseViewModel

@property (nonatomic, strong) NSArray *productIdentifiers;

@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, strong) RACCommand *checkReceiptCmd;
@property (nonatomic, strong) RACCommand *fetchOrderIDCmd;

- (void)fetchDataWithResult:(void(^)(NSArray *dataArray, NSError *error))result;
- (void)purchaseWithResult:(void(^)(NSString *receipt, NSError *error))result;

@end

NS_ASSUME_NONNULL_END
