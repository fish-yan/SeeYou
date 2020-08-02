//
//  HYMyAccountCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYMyAccountCellModel.h"

@interface HYMyAccountCell : HYBaseTableViewCell

@property (nonatomic, strong) HYMyAccountCellModel *model;

@property (nonatomic, copy) void(^detailAction)(void);
@property (nonatomic, copy) void(^rechargeAction)(void);
@property (nonatomic, copy) void(^transferAction)(void);
@property (nonatomic, copy) void(^withdarwAction)(void);

@end
