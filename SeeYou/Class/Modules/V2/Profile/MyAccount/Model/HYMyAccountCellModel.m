//
//  HYMyAccountCellModel.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMyAccountCellModel.h"

@implementation HYMyAccountCellModel

+ (instancetype)modelWithType:(HYMyAccountCellType)type
                        title:(NSString *)title
                         desc:(NSString *)desc
                     andValue:(NSString *)value {
    HYMyAccountCellModel *model = [HYMyAccountCellModel new];
    model.title = title;
    model.cellType = type;
    model.desc = desc;
    model.value = value;
    return model;
}

@end
