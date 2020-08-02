//
//  HYCompleteInfoSelectVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/18.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYCompleteInfoBaseVC.h"

typedef NS_ENUM(NSInteger, HYCompleteInfoSelectType) {
    HYCompleteInfoSelectTypeBirthday = 0,
    HYCompleteInfoSelectTypeLocation = 1,
    HYCompleteInfoSelectTypeIncome = 2,
};

@interface HYCompleteInfoSelectVC : HYCompleteInfoBaseVC

@property (nonatomic, assign) HYCompleteInfoSelectType selectType;

@end
