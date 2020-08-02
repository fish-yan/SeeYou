//
//  HYUserCenterModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserCenterModel.h"

@implementation PhotoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"mid":@"id",
             @"url":@"url"};
}
@end

@implementation HYUserCenterModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"uid":@"uid",
             @"avatar":@"avatar",
             @"name":@"name",
             @"vipstatus":@"vipstatus",
             @"wantToMarrayTime":@"wantmarry",
             @"age":@"age",
             @"sex":@"sex",
             @"height":@"height",
             @"reciveSalary":@"msalary",
             @"constellation":@"constellation",
             @"homeprovince2":@"workcity",
             @"showPicArray" :@"photos",
             @"identityverifystatus":@"identityverifystatus",
             @"identityverifystatus2":@"identityverifystatus2",
             @"province":@"province",
             @"provincestr":@"provincestr",
             @"city":@"city",
             @"citystr":@"citystr",
             @"district":@"district",
             @"districtstr":@"districtstr",
             @"homeprovince":@"homeprovince",
             @"homeprovincestr":@"homeprovincestr",
             @"homecity":@"homecity",
             @"homecitystr":@"homecitystr",
             @"homedistrict":@"homedistrict",
             @"homedistrictstr":@"homedistrictstr",
             @"birthday":@"birthday",
             @"schoollevel":@"degree",
             @"personal":@"jobinfo",
             @"salary":@"salary",
             @"wantMarry":@"wantMarry",
             @"marry":@"marry",
             @"intro":@"intro",
             
             @"wantprovince":@"wantprovince",
             @"wantprovincestr":@"wantprovincestr",
             @"wantcity":@"wantcity",
             @"wantcitystr":@"wantcitystr",
             @"wantdistrict":@"wantdistrict",
             @"wantdistrictstr":@"wantdistrictstr",
             @"wanthomeprovince":@"wanthomeprovince",
             @"wanthomeprovincestr":@"wanthomeprovincestr",
             @"wanthomecity":@"wanthomecity",
             @"wanthomecitystr":@"wanthomecitystr",
             @"wanthomedistrict":@"wanthomedistrict",
             @"wanthomedistrictstr":@"wanthomedistrictstr",
             @"wantdegree":@"wantdegree",
             @"wantsalary":@"wantsalary",
             
             
             };
}

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"photos":@"PhotoModel"};
}
@end
