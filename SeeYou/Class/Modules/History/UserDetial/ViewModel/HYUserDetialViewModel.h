//
//  HYUserDetialViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYUserHeadViewModel.h"


typedef enum : NSUInteger {
    HYDetialMainPicType,
    HYDetialShowPicType,
    HYDetialBaseInfoType,
    HYDetialbeFriendType,
    HYDetialInterduceType
} HYDetialType;


@class HYuserCenterShowPicViewModel;
@class HYDetialDescriptionViewModel;
@class HYUserdetialBaseinfoViewModel;

@interface HYUserDetialViewModel : HYBaseViewModel

@property(nonatomic ,strong) NSString *uid;
@property(nonatomic ,strong) NSArray *SectionArray;


@property(nonatomic ,strong) RACCommand * doCommand;

@property(nonatomic ,strong) RACCommand *doBeMoved;

@property(nonatomic ,strong) HYUserHeadViewModel * headViewModel;
@property(nonatomic ,strong) HYuserCenterShowPicViewModel * picShwoViewModel;
@property(nonatomic ,strong) HYUserdetialBaseinfoViewModel * baseInfoViewModel;
@property(nonatomic ,strong) HYDetialDescriptionViewModel  *befriendViewModel;
@property(nonatomic ,strong) HYDetialDescriptionViewModel  *interduceViewModel;
@property(nonatomic ,assign) BOOL isBemoved;
//-(void)getinfo;
-(void)loadSection;
@end
