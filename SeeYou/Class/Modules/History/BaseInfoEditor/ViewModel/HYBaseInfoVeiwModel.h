//
//  HYBaseInfoVeiwModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"


@interface   HYBaseInfoVeiwModelForViewController : HYBaseViewModel
@property(nonatomic ,strong) NSArray *listArray;
@end



@interface HYBaseInfoVeiwModel : HYBaseViewModel
@property(nonatomic ,assign) HYEditorType type;
@property(nonatomic ,copy) NSString *iconName;
@property(nonatomic ,copy) NSString *title;
@property(nonatomic ,copy) NSString *value;
@property(nonatomic ,assign) BOOL ishowArrow;
@property(nonatomic ,strong) RACCommand * doCommond;

@property(nonatomic,strong) NSString *dk;
@property(nonatomic,strong) NSString *dv;
@property(nonatomic,strong) NSString * showValue;


+ (instancetype)viewModelWithObj:(id)obj;
@end
