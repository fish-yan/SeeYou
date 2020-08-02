//
//  HYMenuModel.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMenuModel.h"

@implementation HYMenuModel


+ (instancetype)modelWithTitle:(NSString *)title contentVC:(UIViewController *)contentVC andID:(NSString *)mId {
    HYMenuModel *menu = [[HYMenuModel alloc] init];
    menu.menuId = mId;
    menu.contentVC = contentVC;
    menu.title = title;
    return menu;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p title: %@ menuId: %@>", [self class], self, _title, _menuId];
}

@end
