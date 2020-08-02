//
//  HYMatchMakerPayVC.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/9.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYMatchMakerPayVC : HYBaseTableViewController

@property (nonatomic, copy) void(^payResultHandler)(BOOL isSuccess);

@end

NS_ASSUME_NONNULL_END
