//
//  HYHomeModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYHomeModel : HYBaseModel
/*用户Id*/
@property (nonatomic ,copy) NSString *userId;
/*用户照片*/
@property (nonatomic ,copy) NSString *picUrl;
/*是否认证*/
@property (nonatomic ,assign) BOOL isVerify;
/*是否心动*/
@property (nonatomic ,assign) BOOL isBeMoved;
/*用户名字*/
@property (nonatomic ,copy) NSString *userName;
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
/*简介*/
@property(nonatomic ,copy)  NSString *interduce;

@end
