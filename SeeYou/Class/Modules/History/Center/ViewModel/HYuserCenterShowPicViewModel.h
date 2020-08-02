//
//  HYuserCenterShowPicViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYuserCenterShowPicViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSArray * picArray;
+ (instancetype)viewModelWithObj:(id)obj ;

+ (instancetype)viewModelWithObjByDetial:(id)obj ;
@end
