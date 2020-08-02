//
//  HYPrivateCellViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYPrivateCellViewModel : HYBaseViewModel
@property(nonatomic ,copy) NSURL *phtotUrl;
@property(nonatomic ,copy) NSString * photoString;
@property(nonatomic ,copy) NSString *uid;
@property(nonatomic ,copy) NSString *userName;
@property(nonatomic ,copy) NSString * time;
@property(nonatomic ,copy) NSString *lastMessage;
@property(nonatomic ,assign) NSNumber* isread;
@property(nonatomic ,copy) NSString * messageID;
@property(nonatomic ,copy) NSString * fromsex;
@property (nonatomic, copy) NSString *newcount;
@property(nonatomic ,assign) NSNumber * isVip;
@property(nonatomic ,copy) NSMutableAttributedString * des;
@property(nonatomic ,assign) NSNumber *usertype;

@property(nonatomic ,strong)RACCommand * doRecommand;

@property (nonatomic, assign) BOOL hasRead;

+ (instancetype)viewModelWithObj:(id)obj;
@end
