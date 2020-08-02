//
//  HYAddressSubViewModel.h
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYAddressSubViewModel : HYBaseViewModel
@property(nonatomic ,copy) NSString * userID;
@property (nonatomic, copy) NSString *mid;
@property(nonatomic ,copy) NSURL * userAvatar;
@property(nonatomic ,copy) NSString * userNickName;
@property(nonatomic ,copy) NSString * userAge;
@property(nonatomic ,copy) NSString * city;
@property(nonatomic ,copy) NSString * userAgeAndcity;
@property(nonatomic ,strong) NSNumber * isheart;//1 表示我喜欢 2.我看过，3，喜欢我 ，4，互相喜欢
@property(nonatomic ,strong) RACCommand *heartCmd;
@property(nonatomic ,strong) NSNumber *isview;
/// 查看类型(0:我喜欢的 1:看过去我,2:喜欢我,互相喜欢)
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) RACCommand *markCmd;

+ (instancetype)viewModelWithObj:(id)obj;
@end
