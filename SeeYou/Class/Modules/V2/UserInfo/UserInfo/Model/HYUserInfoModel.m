//
//  HYUserInfoModel.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/22.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUserInfoModel.h"

@implementation HYUserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid": @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"photos": @"PhotoModel"};
}

@end
