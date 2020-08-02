//
//  PayOnlineViewController.h
//  youbaner
//
//  Created by 卢中昌 on 2018/6/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

typedef void(^CompleteBlcok)(NSString * status);
@interface PayOnlineViewController : HYBaseViewController

@property(nonatomic ,copy) CompleteBlcok block;

@end
