//
//  HYCitiesListVM.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/7.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYCitiesListVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *fetchCitiesCmd;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSArray *indexArr;

@end
