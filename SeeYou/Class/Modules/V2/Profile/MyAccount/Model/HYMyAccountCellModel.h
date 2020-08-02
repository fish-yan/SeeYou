//
//  HYMyAccountCellModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

typedef NS_ENUM(NSInteger, HYMyAccountCellType) {
    HYMyAccountCellTypeWallet,
    HYMyAccountCellTypeIncome,
};

@interface HYMyAccountCellModel : HYBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, assign) HYMyAccountCellType cellType;

+ (instancetype)modelWithType:(HYMyAccountCellType)type
                        title:(NSString *)title
                         desc:(NSString *)desc
                     andValue:(NSString *)value;

@end
