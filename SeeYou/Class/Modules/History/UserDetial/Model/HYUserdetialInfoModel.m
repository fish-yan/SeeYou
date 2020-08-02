//
//  HYUserdetialInfoModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserdetialInfoModel.h"

@implementation HYUserdetialInfoModel

+ (NSDictionary*) mj_replacedKeyFromPropertyName
{
    return @{
             @"uid":@"id",
             @"mobile":@"",
             @"avatar":@"avatar",
             @"name":@"name",
             @"wantToMarrayTime":@"wantmarry",
             @"age":@"age",
             @"height":@"height",
             @"reciveSalary":@"msalary",
             @"constellation":@"constellation",
             @"city":@"workcity",
             @"showPicArray":@"photos",
             
             
             
             
             @"baseinfo":@"baseinfo",
             @"befrindConditionString":@"friendreq",
             @"inteduceString":@"intro",
             
             @"isbemoved":@"beckoningstatus",
             
             };
}

+(NSDictionary *) mj_objectClassInArray
{
    return @{
             @"baseinfo":@"NSString",
             @"showPicArray":@"shwoPicModel"
             };
}
@end
