//
//  HYMatchMakerVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYMatchMakerVM : HYBaseViewModel

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSDictionary *callBackParams;

@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) NSNumber *agestart;
@property (nonatomic, strong) NSNumber *ageend;

@property (nonatomic, strong) NSNumber *heightstart;
@property (nonatomic, strong) NSNumber *heightend;
@property (nonatomic, strong) NSNumber *degree;
@property (nonatomic, strong) NSNumber *salary;
@property (nonatomic, strong) NSNumber *constellation;
@property (nonatomic, strong) NSNumber *wantmarry;
@property (nonatomic, strong) NSNumber *marry;

@end
