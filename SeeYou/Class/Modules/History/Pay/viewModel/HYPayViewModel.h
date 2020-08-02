//
//  HYPayViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/17.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYPayViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSString * orderID;
@property(nonatomic ,assign) int type;
@property(nonatomic ,strong) RACCommand *doCommand;
@property(nonatomic ,strong) RACCommand *doWechatCommand;
@end
