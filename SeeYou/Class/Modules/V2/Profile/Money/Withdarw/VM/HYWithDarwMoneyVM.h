//
//  HYWithDarwMoneyVM.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/18.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYWithDarwMoneyVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *withDarwCmd;

@property (nonatomic, copy) NSString *money;

@end
