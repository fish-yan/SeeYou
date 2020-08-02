//
//  HYUserCenterModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"
typedef NS_ENUM(NSInteger, UserInfoType) {
    UserInfoTypeIncomplte = 1,
    UserInfoTypeNoAvatar,
    UserInfoTypeComplete,
};

@interface PhotoModel : HYBaseModel

@property(nonatomic ,copy ) NSString *mid;
@property(nonatomic ,copy) NSString *url;


@end


@interface HYUserCenterModel : HYBaseModel

@property(nonatomic ,copy)NSString * uid;
@property(nonatomic ,copy)NSString * avatar;
@property(nonatomic ,copy)NSString * name;
/*年龄*/
@property (nonatomic ,copy) NSString *age;
/*身高*/
@property (nonatomic ,copy) NSString *height;

/*收入*/
@property (nonatomic ,copy) NSString *reciveSalary;
/*学历*/
@property(nonatomic ,copy) NSString * schoollevel;


@property(nonatomic ,copy) NSString *sex;

/*是否是会员*/
@property(nonatomic ,assign) NSNumber * vipstatus;//0非会员，1会员
/*会员是否到期*/
@property(nonatomic ,copy) NSString * vipdate;//0非会员，1会员

/*是否推荐红娘购买(0:未购买,1:购买)*/
@property(nonatomic,copy) NSNumber * redniangstatus;
@property (nonatomic, copy) NSString *redniangdate;

 // 是否开通置顶服务(0:未开通,1:开通)
@property(nonatomic ,assign) NSNumber * topstatus;

/*置顶服务到期时间*/
@property(nonatomic ,copy) NSString * topdate;//0非会员，1会员

/// 是否信息完整  1:基础信息不完善，2:未上传头像,3:完整
@property (nonatomic, assign) UserInfoType iscomplete;


@property (nonatomic, assign) NSInteger utype;

@property(nonatomic ,copy)NSString *nickname;
@property(nonatomic ,copy) NSString *token;



@property (nonatomic, copy) NSString *workarea;

@property(nonatomic ,copy) NSString * mobile;



/* 期望结婚时间*/
@property (nonatomic ,copy) NSString *wantToMarrayTime;



/*星座*/
@property (nonatomic ,copy) NSString *constellation;
/*城市*/
// 地址
@property (nonatomic ,copy) NSString * homeprovince2;



@property(nonatomic ,copy)  NSArray * photos;


 // 是否身份认证
@property(nonatomic,copy) NSString * identityverifystatus;
@property(nonatomic,copy) NSString * identityverifystatus2;

//基础信息


@property(nonatomic ,copy) NSNumber  *province;
@property(nonatomic ,copy) NSString  *provincestr;

@property(nonatomic ,copy) NSNumber  * city;
@property(nonatomic ,copy) NSString  *citystr;

@property(nonatomic ,copy) NSNumber  * district;
@property(nonatomic ,copy) NSString  *districtstr;
@property (nonatomic, strong) NSNumber *vipverifystatus;


@property(nonatomic ,copy) NSNumber  *homeprovince;
@property(nonatomic ,copy) NSString  *homeprovincestr;

@property(nonatomic ,copy) NSNumber  *homecity;
@property(nonatomic ,copy) NSString  *homecitystr;

@property(nonatomic ,copy) NSNumber  *homedistrict;
@property(nonatomic ,copy) NSString  *homedistrictstr;

@property(nonatomic,copy) NSString * birthyear;
@property(nonatomic ,copy) NSString * birthmonth;
@property(nonatomic ,copy) NSString * birthday;



@property(nonatomic ,copy) NSString *  personal;
@property (nonatomic ,copy) NSString *salary;

//
//@property(nonatomic ,copy) NSString * workplace;
//@property(nonatomic ,copy) NSString * homePlace;
 // 期望结婚时间
@property(nonatomic ,copy) NSString * wantMarry;
 // 目前婚姻状况
@property(nonatomic ,copy) NSString * marry;

//自我介绍
@property(nonatomic ,copy) NSString * intro;

//交友条件



@property(nonatomic ,copy) NSNumber  *wantprovince;
@property(nonatomic ,copy) NSString  *wantprovincestr;

@property(nonatomic ,copy) NSNumber  * wantcity;
@property(nonatomic ,copy) NSString  *wantcitystr;

@property(nonatomic ,copy) NSNumber  * wantdistrict;
@property(nonatomic ,copy) NSString  *wantdistrictstr;


@property(nonatomic ,copy) NSNumber  *wanthomeprovince;
@property(nonatomic ,copy) NSString  *wanthomeprovincestr ;

@property(nonatomic ,copy) NSNumber  *wanthomecity;
@property(nonatomic ,copy) NSString  *wanthomecitystr;

@property(nonatomic ,copy) NSNumber  *wanthomedistrict;
@property(nonatomic ,copy) NSString  *wanthomedistrictstr;
@property(nonatomic ,copy) NSString *wantagestart;
@property(nonatomic ,copy) NSString *wantageend;

@property(nonatomic,copy) NSString * wantheightstart;

@property(nonatomic,copy) NSString * wantheightend;
@property(nonatomic,copy) NSString * wantdegree;
@property(nonatomic,copy) NSString * wantsalary;

@end

