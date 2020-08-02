//
//  HYPrivateModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYPrivateModel.h"

@implementation HYPrivateModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
              @"messageID":@"id",
              @"userId":@"fromuid",
              @"picUrl":@"fromavatar",
              @"nickname":@"fromname",
              @"reciveTime":@"lastdate2",
              @"lastContent":@"lastmsg",
              @"isRead":@"newcount",
              @"salary":@"msalary"
             };
}

@end
