//
//  HYMyAccountVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYMyAccountModel.h"

@interface HYMyAccountVM : HYBaseViewModel

@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *profit;

@property (nonatomic, strong) RACCommand *requestCmd;
@property (nonatomic, strong) NSArray *dataArray;

@end
