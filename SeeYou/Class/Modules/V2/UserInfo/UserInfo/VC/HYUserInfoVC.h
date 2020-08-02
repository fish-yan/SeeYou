//
//  HYUserInfoVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/15.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"
#import "HYUserInfoVM.h"

@interface HYUserInfoVC : HYBaseTableViewController

@property (nonatomic, assign) UserType type;
@property (nonatomic, copy) NSString *uid;

@end
