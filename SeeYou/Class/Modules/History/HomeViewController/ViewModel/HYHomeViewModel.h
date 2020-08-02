//
//  HYHomeViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYHomeViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSArray * listArray;
@property(nonatomic ,strong) RACCommand *doRaccommand;
@property(nonatomic ,strong) RACCommand  *doOneUserRaccommand;
@property(nonatomic ,strong) NSString* sex;

@property(nonatomic ,assign) int page;

@end
