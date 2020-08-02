//
//  HYusercenterViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYusercenterViewModel.h"
#import "HYUserCenterModel.h"
#import "HYUserCenterBaseModel.h"
@implementation HYusercenterViewModel
- (id)init
{
    self = [super init];
    if(self)
    {
    
      
    }
    
    return self;
}


-(void)getinfo
{

    self.headViewModel =[HYUserHeadViewModel viewModelWithObj:[HYUserContext shareContext].userModel];
    self.picShwoViewModel = [HYuserCenterShowPicViewModel viewModelWithObj:[HYUserContext shareContext].userModel];
    
    
    
    /////
    HYUserCenterBaseModel * m1 = [HYUserCenterBaseModel new];
    m1.title=@"身份证信息";
    m1.value =[HYUserContext shareContext].userModel.identityverifystatus2;
    if([[HYUserContext shareContext].userModel.identityverifystatus boolValue])
        m1.hiddenArrow =YES;
    else
        m1.hiddenArrow=NO;
    m1.type = HYGotoIndenty;
    HYUserBaseInfoViewModel * indentify =[HYUserBaseInfoViewModel viewModelWithObj:m1];
    
    
    HYUserCenterBaseModel * m2 = [HYUserCenterBaseModel new];
    m2.title=@"基本资料";
    m2.value =@"";
    m2.hiddenArrow =NO;
    m2.type= HYGotoBaseInfo;
    HYUserBaseInfoViewModel * baseInfo =[HYUserBaseInfoViewModel viewModelWithObj:m2];
    
    
    
    HYUserCenterBaseModel * m3 = [HYUserCenterBaseModel new];
    m3.title=@"交友条件";
    m3.value =@"";
    m3.hiddenArrow =NO;
    m3.type= HYGotoBefriend;
    HYUserBaseInfoViewModel * becondition=[HYUserBaseInfoViewModel viewModelWithObj:m3];
    
    
    HYUserCenterBaseModel * m4 = [HYUserCenterBaseModel new];
    m4.title=@"自我介绍";
    m4.value =@"";
    m4.hiddenArrow =NO;
    m4.type= HYgotoIntduce;
    HYUserBaseInfoViewModel * interduce=[HYUserBaseInfoViewModel viewModelWithObj:m4];
    
    self.UserbaseInfoArray =@[indentify,baseInfo,becondition,interduce];
    
    
    HYUserCenterBaseModel * m5 = [HYUserCenterBaseModel new];
    m5.title=@"设置";
    m5.value =@"";
    m5.hiddenArrow =NO;
    self.settingViewModel=[HYUserBaseInfoViewModel viewModelWithObj:m5];
    
}

-(void) loadSection
{
    NSMutableArray * tem = [NSMutableArray new];
    [tem addObject:[NSNumber numberWithInt:HYUserBaseInfoType]];
    [tem addObject:[NSNumber numberWithInt:HYUserPicType]];
    [tem addObject:[NSNumber numberWithInt:HyBefriendConditionType]];
    [tem addObject:[NSNumber numberWithInt:HySettingType]];
    self.SectionArray = [tem copy];

}
@end
