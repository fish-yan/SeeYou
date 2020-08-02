//
//  HYHomeModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYHomeModel.h"

@implementation HYHomeModel
+ (NSDictionary*) mj_replacedKeyFromPropertyName
{
    return @{
        @"userId":@"id",
        @"picUrl":@"avatar",
        @"isVerify":@"verifystatus",
        @"isBeMoved":@"beckoningstatus",
        @"userName" :@"name",
        @"wantToMarrayTime":@"wantmarry",
        @"age":@"age",
        @"height":@"height",
        @"reciveSalary":@"msalary",
        @"constellation":@"constellation",
        @"city":@"workcity",
        @"interduce":@"intro"
    };
}
@end
