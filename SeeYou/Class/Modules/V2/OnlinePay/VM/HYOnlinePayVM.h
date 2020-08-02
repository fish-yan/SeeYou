//
//  HYOnlinePayVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/27.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYOnlinePayHelper.h"

@interface HYOnlinePayVM : HYBaseViewModel

@property (nonatomic, assign) OnlinePayType payType;

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, strong) RACCommand *payCmd;

@end
