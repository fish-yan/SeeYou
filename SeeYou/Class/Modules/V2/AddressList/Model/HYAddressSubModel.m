//
//  HYAddressSubModel.m
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYAddressSubModel.h"

@implementation HYAddressSubModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"userID":@"uid",
             @"userAvatar":@"avatar",
             @"userNickName":@"name",
             @"userAge":@"age",
             @"city":@"workcity",
             @"isheart":@"beckoningstatus",
             @"mid": @"id"
             };
}
@end
