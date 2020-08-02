//
//  HYPickerViewData.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/20.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

//    CPPickerViewTypeWorkPlace=0,       //工作地
//    CPPickerViewTypeHomePlace,         //家乡
//    DataPickerEditTypeBirthDay,        //出生日期
//    CPPickerViewTypeHeight,            //身高
//    CPPickerViewTypeSchoolLevel,       //学历
//    CPPickerViewTypePerfession ,       //职业
//    CPPickerViewTypeSalary,            //收入
//    CPPickerViewTypeConstellation,       //星座
//    CPPickerViewTypeMarrayTime,          //期望结婚时间
//    CPPickerViewTypeMarratStatus,        //婚姻状态
//    CPPickerViewTypeBefreindAgeFanwei ,  //交友年龄范围
//    CPPickerViewTypeBefreindHeightFanwei,  //交友升高范围
//    CPPickerViewTypeSex  //交友升高范围

@interface HYPickerViewData : NSObject

@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *heightRange;
@property (nonatomic, strong) NSArray *degree;
@property (nonatomic, strong) NSArray *perfession;
@property (nonatomic, strong) NSArray *salary;
@property (nonatomic, strong) NSArray *constellation;
@property (nonatomic, strong) NSArray *wantMarrayTime;
@property (nonatomic, strong) NSArray *marryStatus;
@property (nonatomic, strong) NSArray *friendAgeRange;
@property (nonatomic, strong) NSArray *friendHeightRange;
@property (nonatomic, strong) NSArray *friendGender;

+ (instancetype)shareData;

@end
