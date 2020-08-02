//
//  HYPrivateModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYPrivateModel : HYBaseModel

@property(nonatomic,copy) NSString *messageID;
/*用户ID*/
@property(nonatomic,copy) NSString *userId;
/*用户头像*/
@property(nonatomic,copy) NSString *picUrl;
/*用户昵称*/
@property(nonatomic,copy) NSString *nickname;
/*用户接受时间*/
@property(nonatomic,copy) NSString *reciveTime;

/*用户最后一条消息内容*/
@property(nonatomic,copy) NSString *lastContent;
/*是否有新消息*/
@property(nonatomic,assign) NSNumber* isRead;
@property(nonatomic,copy) NSString *fromsex;
@property(nonatomic,assign)NSNumber *usertype;
@property (nonatomic, copy) NSString *newcount;




//扩充字段
@property (nonatomic,strong) NSString * age;
@property (nonatomic,strong) NSString * height;
@property (nonatomic,strong) NSString * salary;
@property (nonatomic,assign) NSNumber * isVip;

@end
