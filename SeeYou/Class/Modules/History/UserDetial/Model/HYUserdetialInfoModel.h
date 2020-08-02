//
//  HYUserdetialInfoModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYUserdetialInfoModel : HYBaseModel
@property(nonatomic ,copy)NSString * uid;
@property(nonatomic ,copy)NSString * mobile;
@property(nonatomic ,copy)NSString * avatar;

@property(nonatomic ,copy)NSString * name;
/* 期望结婚时间*/
@property (nonatomic ,copy) NSString *wantToMarrayTime;
/*年龄*/
@property (nonatomic ,copy) NSString *age;
/*身高*/
@property (nonatomic ,copy) NSString *height;
/*收入*/
@property (nonatomic ,copy) NSString *reciveSalary;
/*星座*/
@property (nonatomic ,copy) NSString *constellation;
/*城市*/
@property(nonatomic ,copy)  NSString *city;

@property(nonatomic ,copy)  NSArray * showPicArray;



@property(nonatomic ,strong) NSArray * baseinfo;



@property(nonatomic ,copy) NSString * befrindConditionString;
@property(nonatomic ,copy) NSString * inteduceString;
@property(nonatomic ,assign) BOOL isbemoved;
@end
