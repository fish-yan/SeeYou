//
//  HYCItiesListVC.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/7.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYNavigationController.h"

@interface HYCItiesListVC : HYNavigationController

@property (nonatomic, copy) void(^callBack)(NSDictionary *info);

@end
