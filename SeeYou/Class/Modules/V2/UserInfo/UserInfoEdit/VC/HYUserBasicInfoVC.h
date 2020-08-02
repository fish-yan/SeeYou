//
//  HYUserBasicInfoVC.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"
#import "HYUserBasicInfoVM.h"

@interface HYUserBasicInfoVC : HYBaseTableViewController

@property (nonatomic, strong) HYUserCenterModel *infoModel;

@property (nonatomic, assign) UserInfoEditType type;

@end
