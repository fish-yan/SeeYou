//
//  HYFilterViewController.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"
#import "HYFilterVM.h"
#import "HYFilterRecordModel.h"

@interface HYFilterViewController : HYBaseTableViewController

@property (nonatomic, copy) void(^callBack)(HYFilterRecordModel *filters);
//@property (nonatomic, strong) NSDictionary *filterInfo;

@property (nonatomic, strong) HYFilterRecordModel *filterInfo;
@end
