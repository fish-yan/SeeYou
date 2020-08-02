//
//  HYMatchMakerCellModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"
typedef NS_ENUM(NSInteger, FilterCellType) {
    FilterCellTypeLocation,
    FilterCellTypeAge,
    FilterCellTypeHeight,
    FilterCellTypeEdu,
    FilterCellTypeJob,
    FilterCellTypeIncome,
    FilterCellTypeConstellation,
    FilterCellTypeMarryDate,
    FilterCellTypeMarryStatus,
};

@interface HYMatchMakerCellModel : HYBaseModel

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) FilterCellType type;

+ (instancetype)modelWithType:(FilterCellType)type
                         name:(NSString *)name
                         icon:(NSString *)icon
                         info:(NSString *)info
                     isLocked:(BOOL)isLocked;

@end
