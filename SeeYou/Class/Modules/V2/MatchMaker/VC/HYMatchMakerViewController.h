//
//  HYMatchMakerViewController.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"
#import "HYMatchMakerVM.h"

@interface HYMatchMakerViewController : HYBaseTableViewController

@property (nonatomic, copy) void(^callBack)(NSDictionary *filters);

@end
