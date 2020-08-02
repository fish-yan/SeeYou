//
//  HYMapViewController.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYMapViewController : HYBaseViewController

@property (nonatomic, strong) HYCoordinate *endLocation;
@property (nonatomic, strong) HYCoordinate *currentLocation;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *range;

@end
