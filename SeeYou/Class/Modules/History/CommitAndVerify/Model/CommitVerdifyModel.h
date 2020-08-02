//
//  CommitVerdifyModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface CommitVerdifyModel : HYBaseModel
@property(nonatomic ,copy) NSString * price;
@property(nonatomic ,copy) NSString * peopleNumber;
@property(nonatomic ,copy) NSString * orderID;
@property(nonatomic ,strong)NSString *productprice;
@property(nonatomic ,strong)NSString *productprice2;
@property(nonatomic ,strong)NSString *originalprice;
@property(nonatomic ,strong) NSString * discount;

@end
