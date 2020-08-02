//
//  HYShoePhotosViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYShoePhotosViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSString * ID;
@property(nonatomic ,strong) NSURL * url;
@property(nonatomic ,assign) BOOL deleteStatus;
@property(nonatomic ,strong) RACCommand * doCommand;

@property(nonatomic ,assign) BOOL delButton;
+ (instancetype)viewModelWithObj:(id)obj;
@end
