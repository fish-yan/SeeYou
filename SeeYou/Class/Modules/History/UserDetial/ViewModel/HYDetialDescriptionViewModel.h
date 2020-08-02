//
//  HYDetialDescriptionViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"


@interface HYDetialDescriptionViewModel : HYBaseViewModel
@property(nonatomic ,copy)NSString *title;
@property(nonatomic ,copy) NSMutableAttributedString * des;

+ (instancetype)viewModelWithObj:(id)obj ;
@end
