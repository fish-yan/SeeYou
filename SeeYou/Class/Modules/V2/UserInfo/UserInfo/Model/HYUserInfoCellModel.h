//
//  HYUserInfoCellModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/15.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

typedef NS_ENUM(NSInteger, UserInfoCellType) {
    UserInfoCellTypeHeader,
    UserInfoCellTypeInfo,
    UserInfoCellTypePhotos,
    UserInfoCellTypeList,
    UserInfoCellTypeDesc,
    UserInfoCellTypeTags,
};

@interface HYUserInfoCellModel : HYBaseViewModel

@property (nonatomic, strong) id value;
@property (nonatomic, assign) UserInfoCellType cellType;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)modelWithType:(UserInfoCellType)cellType
                        value:(id)values
                        title:(NSString *)title
                         desc:(NSString *)desc;

@end
