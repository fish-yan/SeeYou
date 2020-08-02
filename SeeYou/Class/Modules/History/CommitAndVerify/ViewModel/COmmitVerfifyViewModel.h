//
//  COmmitVerfifyViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "CommitVerdifyModel.h"
@interface COmmitVerfifyViewModel : HYBaseViewModel
@property(nonatomic ,copy) NSString * price;
@property(nonatomic ,copy) NSString * peopleNumber;
@property(nonatomic ,copy) NSString * orderID;

@property(nonatomic ,copy) NSString * productprice2;
@property(nonatomic ,copy) NSString * originalprice;
@property(nonatomic ,copy) NSString * discount;


@property(nonatomic ,strong) RACCommand * doRaccommand;
@end
