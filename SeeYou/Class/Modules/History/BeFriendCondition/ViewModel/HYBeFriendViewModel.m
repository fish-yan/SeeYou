//
//  HYBeFriendViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBeFriendViewModel.h"
#import "HYBaseInfoModel.h"
#import "HYBaseInfoVeiwModel.h"
#import "HYAreaDataInstance.h"

@implementation HYBeFriendViewModel
- (id) init
{
    
    self =[super init];
    if(self)
    {
        NSMutableArray *temp =[NSMutableArray new];
        
        HYBaseInfoModel * m =[HYBaseInfoModel new];
        m.type = HYGOTOWorkPlaceEditorType;
        m.iconName=@"workplace";
        m.title=@"工作所在地";
        m.value= [HYUserContext shareContext].userModel.wantprovincestr.length>0?( [NSString stringWithFormat:@"%@-%@", [HYUserContext shareContext].userModel.wantprovincestr ,[HYUserContext shareContext].userModel.wantcitystr]):@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOHomePlaceEditorType;
        m.iconName=@"homeplace";
        m.title=@"家乡所在地";
        m.value= [HYUserContext shareContext].userModel.wanthomeprovincestr.length>0?( [NSString stringWithFormat:@"%@-%@", [HYUserContext shareContext].userModel.wanthomeprovincestr,[HYUserContext shareContext].userModel.wanthomecitystr ]):@"" ;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOBirthEditorType;
        m.iconName=@"birthday";
        m.title=@"年龄";
        if([HYUserContext shareContext].userModel.wantagestart==nil)
        {
            
             m.value=@"";
        }
        else
        {
            NSString *str =[NSString stringWithFormat:@"%@-%@岁",[HYUserContext shareContext].userModel.wantagestart,[HYUserContext shareContext].userModel.wantageend ];
            
            m.value=str ;
        }
       
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOHeightEditorType;
        m.iconName=@"height";
        m.title=@"身高";
        m.value=[HYUserContext shareContext].userModel.wantheightstart.length>0? [NSString stringWithFormat:@"%@-%@cm",[HYUserContext shareContext].userModel.wantheightstart,[HYUserContext shareContext].userModel.wantheightend]:@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOSchoolLevelEditorType;
        m.iconName=@"schoolLevel";
        m.title=@"学历";
        m.value=[HYUserContext shareContext].userModel.wantdegree.length>0? [NSString stringWithFormat:@"%@",[HYUserContext shareContext].userModel.wantdegree]:@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
   
        m =[HYBaseInfoModel new];
        m.type = HYGOTOSalaryEditorType;
        m.iconName=@"salary";
        m.title=@"月收入";
        m.value=[HYUserContext shareContext].userModel.wantsalary.length>0? [NSString stringWithFormat:@"%@",[HYUserContext shareContext].userModel.wantsalary]:@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        self.listArray =[temp copy];
        
    }
    return self;
}

@end

