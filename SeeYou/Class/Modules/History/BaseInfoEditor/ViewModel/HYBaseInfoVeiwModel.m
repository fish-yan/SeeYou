//
//  HYBaseInfoVeiwModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseInfoVeiwModel.h"
#import "HYBaseInfoModel.h"

@implementation HYBaseInfoVeiwModelForViewController
- (id) init
{
    self =[super init];
    if(self)
    {
        NSMutableArray *temp =[NSMutableArray new];
        HYBaseInfoModel * m =[HYBaseInfoModel new];
        m.type = HYGOTOUserNameEditorType;
        m.iconName=@"man";
        m.title=@"姓名";
        m.value=[HYUserContext shareContext].userModel.name;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        
        
        m.type = HYGOTOWorkPlaceEditorType;
        m.iconName=@"workplace";
        m.title=@"工作所在地";
        m.value=[HYUserContext shareContext].userModel.provincestr.length>0?(  [NSString stringWithFormat:@"%@-%@",[HYUserContext shareContext].userModel.provincestr , [HYUserContext shareContext].userModel.citystr ]):@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOHomePlaceEditorType;
        m.iconName=@"homeplace";
        m.title=@"家乡所在地";
        m.value= [HYUserContext shareContext].userModel.homeprovincestr.length>0?(  [NSString stringWithFormat:@"%@-%@",[HYUserContext shareContext].userModel.homeprovincestr , [HYUserContext shareContext].userModel.homecitystr ]):@"";//[HYUserContext shareContext].userModel.homedistrictstr;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOBirthEditorType;
        m.iconName=@"birthday";
        m.title=@"日期";
        
        
        if([HYUserContext shareContext].userModel.birthyear==nil)
        {
        
            m.value=@"";
        }
        else
        {
            NSString *str =[NSString stringWithFormat:@"%@-%@-%@",[HYUserContext shareContext].userModel.birthyear,[HYUserContext shareContext].userModel.birthmonth,[HYUserContext shareContext].userModel.birthday ];
            m.value=str ;
        
        }
        
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOHeightEditorType;
        m.iconName=@"height";
        m.title=@"身高";
        m.value=[HYUserContext shareContext].userModel.height.length>0? [NSString stringWithFormat:@"%@cm",[HYUserContext shareContext].userModel.height]:@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOSchoolLevelEditorType;
        m.iconName=@"schoolLevel";
        m.title=@"学历";
        m.value=[HYUserContext shareContext].userModel.schoollevel;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOProfessialEditorType;
        m.iconName=@"profession";
        m.title=@"职业";
        m.value=[HYUserContext shareContext].userModel.personal;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOSalaryEditorType;
        m.iconName=@"salary";
        m.title=@"月收入";
        m.value=[HYUserContext shareContext].userModel.reciveSalary.length>0? [NSString stringWithFormat:@"%@",[HYUserContext shareContext].userModel.reciveSalary]:@"";
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOConstellationEditorType;
        m.iconName=@"constellation";
        m.title=@"星座";
        m.value=[HYUserContext shareContext].userModel.constellation;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOWantMarrayTimeEditorType;
        m.iconName=@"marrytime";
        m.title=@"期望结婚时间";
        m.value=[HYUserContext shareContext].userModel.wantToMarrayTime;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        m =[HYBaseInfoModel new];
        m.type = HYGOTOMarrayStatusEditorType;
        m.iconName=@"marrayStatus";
        m.title=@"目前婚姻状况";
        m.value=[HYUserContext shareContext].userModel.marry;
        m.ishowArrow=YES;
        [temp addObject:[HYBaseInfoVeiwModel viewModelWithObj:m]];
        
        self.listArray =[temp copy];
        
    }
    return self;
}

@end

@implementation HYBaseInfoVeiwModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self initialize];
    }
    return self;
}

+ (instancetype) viewModelWithObj:(id)obj
{
    HYBaseInfoVeiwModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
    
}

- (void) setObj:(HYBaseInfoModel *)obj
{
    self.type = obj.type;
    self.iconName =obj.iconName;
    self.title = obj.title;
    self.value =obj.value;
    self.ishowArrow= obj.ishowArrow;
}


- (void)initialize
{
    @weakify(self);
    self.doCommond=[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        [WDProgressHUD showInView:nil];
        NSDictionary *dic =@{@"dk":self.dk,@"dv":self.dv};
        return [[self upDateUserBaseInfo:[NSDictionary convertParams:API_EDITORUSERINFO dic:dic]] doNext:^(id  _Nullable x) {
            @strongify(self);
            self.value =self.showValue;
        }];
    }];

    [self bindmodel];
}

-(void) bindmodel
{
    [[self.doCommond .executionSignals switchToLatest] subscribeNext:^(WDResponseModel*  _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.msg];
        
            [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
                
            } failureHandle:^(NSError *error) {
                
            }];
    }];
    [[self.doCommond errors] subscribeNext:^(NSError * _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
}

- (RACSignal*)upDateUserBaseInfo:(NSDictionary*)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}

@end
