//
//  HYTransactionDetailsVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
typedef NS_ENUM(NSInteger, TransactionDetailsType) {
    TransactionDetailsTypeIncome = 1,
    TransactionDetailsTypePay = 2,
};

@interface HYTransactionDetailsVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *getDetailRaccommand;


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) TransactionDetailsType type;

@end
