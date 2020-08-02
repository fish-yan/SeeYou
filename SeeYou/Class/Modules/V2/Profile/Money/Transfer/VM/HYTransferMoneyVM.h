//
//  HYTransferMoneyVM.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/18.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYTransferMoneyVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *transferCmd;
@property (nonatomic, copy) NSString *money;

@end
