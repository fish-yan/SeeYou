//
//  HYMatchMakerPayCellModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/9.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HYMatchMakerPayCellType) {
    HYMatchMakerPayCellTypeIntro,
    HYMatchMakerPayCellTypeItems,
};

@interface HYMatchMakerPayCellModel : HYBaseModel

@property (nonatomic, assign) HYMatchMakerPayCellType type;
@property (nonatomic, strong) id date;

+ (instancetype)modelWithType:(HYMatchMakerPayCellType)type date:(nullable id)date;

@end

NS_ASSUME_NONNULL_END
