//
//  IAPHelper.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/6.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "WDProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface IAPHelper : NSObject

+ (instancetype)helper;

- (void)fetchIAPProducts:(NSArray<NSString *> *)identifiers
              withResult:(void(^)(NSArray<SKProduct *> *products, NSError *error))result;

- (void)purchaseIdentrifier:(NSString *)identifier
                withRestult:(void(^)(NSString *receipt, NSError *error))result;

- (void)finishUncomplatePurchase;

@end

NS_ASSUME_NONNULL_END
