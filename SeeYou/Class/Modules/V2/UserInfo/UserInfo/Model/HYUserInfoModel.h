//
//  HYUserInfoModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/22.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYUserInfoModel : HYBaseModel

@property (nonatomic, copy) NSString *uid;
// 认证状态(0:未认证,1:已认证)
@property (nonatomic, assign) BOOL vipverifystatus;
// 头像
@property (nonatomic, copy) NSString *avatar;
// 名称
@property (nonatomic, copy) NSString *name;
// 期望结婚
@property (nonatomic, copy) NSString *wantmarry;
// 年龄
@property (nonatomic, copy) NSString *age;
// 身高
@property (nonatomic, copy) NSString *height;
// 收入
@property (nonatomic, copy) NSString *msalary;
// 星座
@property (nonatomic, copy) NSString *constellation;
// 地址
@property (nonatomic, copy) NSString *homeprovince;

@property (nonatomic, strong) NSArray *photos;
// 基本资料
@property (nonatomic, strong) NSArray *baseinfo;
// 交友条件
@property (nonatomic, copy) NSString *friendreq;
// 自我介绍
@property (nonatomic, copy) NSString *intro;
// 心动状态(0:未心动,1:已心动)
@property (nonatomic, strong) NSNumber *beckoningstatus;
@property (nonatomic, assign) BOOL appointmentstatus;
@property (nonatomic, copy) NSString *workcity;
@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *appointmentid;

@end
