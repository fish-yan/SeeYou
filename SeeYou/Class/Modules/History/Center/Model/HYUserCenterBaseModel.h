//
//  HYUserCenterBaseModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

typedef enum : NSUInteger {
    HYGotoIndenty,
    HYGotoBaseInfo,
    HYGotoBefriend,
    HYgotoIntduce
} HYbaseInfoType;


@interface HYUserCenterBaseModel : HYBaseModel
@property(nonatomic ,strong) NSString * title;
@property(nonatomic ,strong) NSString * value;
@property(nonatomic, assign) BOOL hiddenArrow;
@property(nonatomic ,assign) HYbaseInfoType type;
@end
