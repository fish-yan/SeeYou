//
//  HYOneKeyGreetVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYOneKeyUserModel.h"

@interface HYOneKeyGreetVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *requestCmd;

@property (nonatomic, strong) RACCommand *greetCmd;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *localGreetArr;


@end
