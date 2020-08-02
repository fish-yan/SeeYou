//
//  HYRechargeViewModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYFinanceModel.h"
#import "HYOrderPayModel.h"

@interface HYRechargeViewModel : HYBaseViewModel

@property (nonatomic, strong) HYOrderPayModel *payModel;
@property (nonatomic, strong) NSArray<HYFinanceModel *> *dataArray;

@property (nonatomic, strong) RACCommand *getProductListCmd;
@property (nonatomic, strong) RACCommand *getOderidInfoRaccommand;

@end
