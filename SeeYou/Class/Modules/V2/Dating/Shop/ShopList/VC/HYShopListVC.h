//
//  HYShopListVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"

@interface HYShopListVC : HYBaseTableViewController

@property (nonatomic, copy) void(^selected)(NSDictionary *dict);

@end
