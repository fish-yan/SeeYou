//
//  HYUserDetialViewController.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

typedef void(^resetViewModelBlock)(NSString *string , BOOL status);

@interface HYUserDetialViewController : HYBaseViewController

@property(nonatomic ,copy) resetViewModelBlock block;


@end
