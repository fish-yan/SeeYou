//
//  HYTransationDetailsModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYTransationDetailsModel : HYBaseModel

@property (nonatomic, copy) NSString *transtype;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *amount2;
@property (nonatomic, copy) NSString *date;

@end
