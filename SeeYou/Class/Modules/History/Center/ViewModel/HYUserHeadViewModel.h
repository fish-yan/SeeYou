//
//  HYUserHeadViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYUserHeadViewModel : HYBaseViewModel

@property(nonatomic ,strong) NSURL *avatar;
@property(nonatomic ,strong) NSString * username;
@property(nonatomic ,strong) NSString *marraytime;
@property(nonatomic ,strong) NSMutableAttributedString * baseInfostring;
@property(nonatomic ,strong) NSString * city;

+ (instancetype)viewModelWithObj:(id)obj ;

+ (instancetype)viewModelWithObjByDetial:(id)obj;

@end
