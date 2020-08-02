//
//  HYAddressListViewModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "hyaddressTitleModel.h"

#import "HYAddressCellViewModel.h"

@interface HYAddressListViewModel : HYBaseViewModel

@property (nonatomic, strong) RACCommand *fetTitleCmd;
@property (nonatomic, strong) NSArray *titleData;

@property(nonatomic ,strong) RACCommand * getAddresslistRaccommand;
@property(nonatomic ,strong) NSArray  * orginDataArray;
@property(nonatomic ,strong) NSArray * convertArray;
@property(nonatomic, assign) int page;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) RACCommand *markCmd;
@end
