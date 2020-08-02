//
//  CommitVerdifyModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "CommitVerdifyModel.h"

@implementation CommitVerdifyModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"price":@"productprice",
             @"peopleNumber":@"usercount",
             @"orderID":@""
             };
}

@end
