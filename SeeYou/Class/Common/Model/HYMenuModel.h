//
//  HYMenuModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMenuModel : HYBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *menuId;
@property (nonatomic, strong) UIViewController *contentVC;


+ (instancetype)modelWithTitle:(NSString *)title contentVC:(UIViewController *)contentVC andID:(NSString *)mId;

@end
