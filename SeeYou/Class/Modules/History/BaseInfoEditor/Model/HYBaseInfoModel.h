//
//  HYBaseInfoModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYBaseInfoModel : HYBaseModel
@property(nonatomic ,assign) HYEditorType type;
@property(nonatomic ,copy) NSString *iconName;
@property(nonatomic ,copy) NSString *title;
@property(nonatomic ,copy) NSString *value;
@property(nonatomic ,assign) BOOL ishowArrow;
@end
