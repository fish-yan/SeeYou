//
//  HYAddressSubModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYAddressSubModel : HYBaseModel
@property(nonatomic ,copy) NSString * userID;
@property(nonatomic ,copy) NSString * userAvatar;
@property(nonatomic ,copy) NSString * userNickName;
@property(nonatomic ,copy) NSString * userAge;
@property(nonatomic ,copy) NSString * city;
@property(nonatomic ,strong) NSNumber * isheart;//1 表示我喜欢 2.我看过，3，喜欢我 ，4，互相喜欢
@property(nonatomic ,strong) NSNumber *isview;
@property (nonatomic, copy) NSString *mid;
@end
