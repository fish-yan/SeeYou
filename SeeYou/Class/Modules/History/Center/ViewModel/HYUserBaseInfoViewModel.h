//
//  HYUserBaseInfoViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYUserCenterBaseModel.h"
@interface HYUserBaseInfoViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSString * title;
@property(nonatomic ,strong) NSString * value;
@property(nonatomic ,assign) BOOL hiddenArrow;
@property(nonatomic ,assign) HYbaseInfoType type;
+ (instancetype)viewModelWithObj:(id)obj ;
@end
