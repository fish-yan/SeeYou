//
//  HYAddressListModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYAddressSubModel.h"
@interface HYAddressListModel : HYBaseModel

@property(nonatomic ,strong) HYAddressSubModel * leftModel;
@property(nonatomic ,strong) HYAddressSubModel * rightModel;
@end
