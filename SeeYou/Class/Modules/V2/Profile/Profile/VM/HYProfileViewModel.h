//
//  HYProfileViewModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYProfileViewModel : HYBaseViewModel

@property (nonatomic, strong) RACCommand *requestCmd;
@property (nonatomic, strong) RACCommand *logoutCmd;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HYUserCenterModel *detailModel;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) BOOL hasBuyMatchMaker;

// 是否已经认证
@property (nonatomic, assign) BOOL hasIdentify;

@end
