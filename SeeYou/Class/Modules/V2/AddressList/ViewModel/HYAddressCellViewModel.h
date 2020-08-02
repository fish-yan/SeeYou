//
//  HYAddressCellViewModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYAddressSubViewModel.h"
@interface HYAddressCellViewModel : HYBaseViewModel
@property(nonatomic ,strong) HYAddressSubViewModel * leftViewModel;
@property(nonatomic ,strong) HYAddressSubViewModel * rightViewModel;
@end
