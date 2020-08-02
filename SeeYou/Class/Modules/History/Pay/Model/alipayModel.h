//
//  alipayModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface  prepayappointmentModel:HYBaseModel
@property(nonatomic ,strong) NSString * orderid;
@property(nonatomic ,strong) NSString * name;
@property(nonatomic ,strong) NSString * balance;
@property(nonatomic ,strong) NSString * payamount;
@property(nonatomic ,assign) NSNumber * status;//
@end

@interface alipayModel : HYBaseModel
@property(nonatomic ,strong) NSString * body;
@property(nonatomic ,strong) NSString * money;
@property(nonatomic ,strong) NSString * subject;
@property(nonatomic ,strong) NSString * payid;
@property(nonatomic ,strong) NSString * callbackurl;
@property(nonatomic ,strong) NSString *  payno;
@end


@interface wechatpayModel : HYBaseModel
@property(nonatomic ,strong) NSString *payid;
@property(nonatomic ,strong) NSString *prepayid;
@property(nonatomic ,strong) NSString *package;
@property(nonatomic ,strong) NSString *nonceStr;
@property(nonatomic ,strong) NSString *timeStamp;
@property(nonatomic ,strong) NSString * sign;
@end
