//
//  HYProfileCellModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

typedef NS_ENUM(NSInteger, ProfileCellType) {
    ProfileCellTypeNull,
    ProfileCellTypeInfo,
    ProfileCellTypeMenu,
    ProfileCellTypeList,
};

@interface HYProfileCellModel : HYBaseModel

@property (nonatomic, assign) ProfileCellType type;
@property (nonatomic, strong) id value;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *mapStr;

+ (instancetype)modelWithType:(ProfileCellType)type
                        title:(NSString *)title
                         desc:(NSString *)desc
                       mapStr:(NSString *)mapStr
                        value:(id)value;

+ (instancetype)modelWithTitle:(NSString *)title
                          desc:(NSString *)desc
                        mapStr:(NSString *)mapStr
                         value:(id)valu;

@end
