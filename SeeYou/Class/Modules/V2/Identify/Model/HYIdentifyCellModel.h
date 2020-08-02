//
//  HYIdentifyCellModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/16.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

typedef NS_ENUM(NSInteger, HYIdentifyCellType) {
    HYIdentifyCellTypeInfo,
    HYIdentifyCellTypeUpIDImage,
};

@interface HYIdentifyCellModel : HYBaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) HYIdentifyCellType cellType;

+ (instancetype)modelWithCellType:(HYIdentifyCellType)type
                             icon:(NSString *)icon
                            title:(NSString *)title
                             info:(NSString *)info;
@end
