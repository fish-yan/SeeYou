//
//  BailViewModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
@class prepayappointmentModel;
@interface BailViewModel : HYBaseViewModel
@property(nonatomic ,strong) prepayappointmentModel * extraModel;
@property(nonatomic ,strong) RACCommand * getProductListRaccommand;
@property(nonatomic ,strong) NSArray* listArray;
@property(nonatomic ,strong) RACCommand * getOderidInfoRaccommand;
@end
