//
//  HYUserBasicInfoCellModel.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUserBasicInfoCellModel.h"

@implementation HYUserBasicInfoCellModel

+ (instancetype)modelWithType:(BasicInfoCellType)type
                         name:(NSString *)name
                         icon:(NSString *)icon
                         info:(NSString *)info {
    HYUserBasicInfoCellModel *model = [HYUserBasicInfoCellModel new];
    model.name = name;
    model.icon = icon;
    model.info = info;
    model.type = type;
    return model;
}


@end
