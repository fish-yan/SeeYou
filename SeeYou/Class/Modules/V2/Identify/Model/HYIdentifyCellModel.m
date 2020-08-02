//
//  HYIdentifyCellModel.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/16.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYIdentifyCellModel.h"

@implementation HYIdentifyCellModel

+ (instancetype)modelWithCellType:(HYIdentifyCellType)type
                             icon:(NSString *)icon
                            title:(NSString *)title
                             info:(NSString *)info {
    HYIdentifyCellModel *m = [HYIdentifyCellModel new];
    m.cellType = type;
    m.icon = icon;
    m.title = title;
    m.info = info;
    return m;
}

@end
