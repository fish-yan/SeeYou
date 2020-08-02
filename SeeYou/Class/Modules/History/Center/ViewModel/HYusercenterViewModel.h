//
//  HYusercenterViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYUserHeadViewModel.h"
#import "HYuserCenterShowPicViewModel.h"
#import "HYUserBaseInfoViewModel.h"
typedef enum : NSUInteger {
    HYUserBaseInfoType,
    HYUserPicType,
    HyBefriendConditionType,
    HySettingType
} HYUserInfoType;

@interface HYusercenterViewModel : HYBaseViewModel

@property(nonatomic ,strong) NSArray *SectionArray;
@property(nonatomic ,strong) RACCommand  * doCommand;
@property(nonatomic ,strong) HYUserHeadViewModel * headViewModel;
@property(nonatomic ,strong) HYuserCenterShowPicViewModel * picShwoViewModel;
@property(nonatomic ,strong) NSArray * UserbaseInfoArray;
@property(nonatomic ,strong) HYUserBaseInfoViewModel *settingViewModel;
-(void)getinfo;
-(void)loadSection;

@end
