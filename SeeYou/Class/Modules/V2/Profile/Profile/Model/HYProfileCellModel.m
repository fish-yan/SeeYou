//
//  HYProfileCellModel.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYProfileCellModel.h"

@implementation HYProfileCellModel

//+ (instancetype)modelWithType:(ProfileCellType)type value:(id)value {
//    HYProfileCellModel *m = [HYProfileCellModel new];
//    m.type = type;
//    m.value = value;
//    return m;
//}

+ (instancetype)modelWithTitle:(NSString *)title
                         desc:(NSString *)desc
                       mapStr:(NSString *)mapStr
                         value:(id)value {
    return [self modelWithType:ProfileCellTypeNull
                         title:title
                          desc:desc
                        mapStr:mapStr
                         value:value];
}

+ (instancetype)modelWithType:(ProfileCellType)type
                        title:(NSString *)title
                         desc:(NSString *)desc
                       mapStr:(NSString *)mapStr
                        value:(id)value {
    HYProfileCellModel *m = [HYProfileCellModel new];
    m.type = type;
    m.title = title;
    m.desc = desc;
    m.mapStr = mapStr;
    m.value = value;
    return m;
}

@end
