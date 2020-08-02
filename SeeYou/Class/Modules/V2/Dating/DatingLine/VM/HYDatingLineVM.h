//
//  HYDatingLineVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/26.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYDatingLineVM : HYBaseViewModel

@property (nonatomic, copy) NSString *dateId;

@property (nonatomic, copy) NSString *initiatoravatar;
@property (nonatomic, copy) NSString *initiatorname;
@property (nonatomic, copy) NSString *receiveravatar;
@property (nonatomic, copy) NSString *receivername;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL showHeaderInfo;

@property (nonatomic, strong) RACCommand *requestCmd;

@end
