//
//  HYShopInfoModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYLocation.h"

@interface HYShopInfoModel : HYBaseModel

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *businessArea;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, assign) double range;
@property (nonatomic, strong) HYLocation *location;

@property (nonatomic, copy) NSString *city;

@end
