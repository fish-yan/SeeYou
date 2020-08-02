//
//  HYMembershipVM.h
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYMembershipVM : HYBaseViewModel
@property (nonatomic ,strong) NSString *orderid;
@property (nonatomic ,strong) RACCommand  *doRaccommand;
@property(nonatomic ,strong) RACCommand * getOrderid;
@end
