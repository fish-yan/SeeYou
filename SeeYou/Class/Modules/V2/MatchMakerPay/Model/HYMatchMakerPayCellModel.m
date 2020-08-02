//
//  HYMatchMakerPayCellModel.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/9.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYMatchMakerPayCellModel.h"

@implementation HYMatchMakerPayCellModel

+ (instancetype)modelWithType:(HYMatchMakerPayCellType)type date:(id)date {
    HYMatchMakerPayCellModel *m = [HYMatchMakerPayCellModel new];
    m.type = type;
    m.date = date;
    return m;
}
@end
