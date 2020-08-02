//
//  HYUserDetialViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserDetialViewModel.h"
#import "HYUserdetialInfoModel.h"

#import "HYuserCenterShowPicViewModel.h"
#import "HYUserdetialBaseinfoViewModel.h"
#import "HYDetialDescriptionViewModel.h"
#import "HYUserCenterBaseModel.h"
@implementation HYUserDetialViewModel

- (id)init
{
    self =[super init];
    if(self)
    {
        
        [self initilize];
    }
    return self;
}

- (void) initilize
{
    @weakify(self);
    self.doCommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic=@{@"id":self.uid};
        return [[self getUserinfo: [NSDictionary convertParams:API_USER_INFO dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            @strongify(self);
            [self convertUserDetialModel:x.data];
            
            
        }];
    }];
    
    
    self.doBeMoved =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic =@{@"uid":self.uid,@"type":(self.isBemoved?@"2":@"1")};
        return [[self  requestBeMoved:[NSDictionary convertParams:API_ISBEMOVED dic:dic]] doNext:^(id  _Nullable x) {
            @strongify(self);
            self.isBemoved =!self.isBemoved;
        }];
    }];
}

- (RACSignal*)requestBeMoved:(NSDictionary *)dic
{
    RACSignal * signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}


-(RACSignal*)getUserinfo:(NSDictionary*)dic
{
    RACSignal * signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[HYUserdetialInfoModel class]];
    return signal;
}


-(void)convertUserDetialModel:(HYUserdetialInfoModel*)model
{
    
    self.headViewModel =[HYUserHeadViewModel viewModelWithObjByDetial:model];
    if(model.showPicArray.count>0)
    {
        self.picShwoViewModel = [HYuserCenterShowPicViewModel viewModelWithObjByDetial:model];
    }
    if(model.baseinfo.count >0)
    {
        self.baseInfoViewModel = [HYUserdetialBaseinfoViewModel viewModelWithObj:model];
    }
    
    if(model.befrindConditionString.length>0)
    {
        HYUserCenterBaseModel * m = [HYUserCenterBaseModel new];
        m.title=@"交友条件";
        m.value = model.befrindConditionString;

        self.befriendViewModel =[HYDetialDescriptionViewModel viewModelWithObj:m];
    }

    if(model.inteduceString.length>0)
    {
        HYUserCenterBaseModel * m = [HYUserCenterBaseModel new];
        m.title=@"自我介绍";
        m.value = model.inteduceString;
        self.interduceViewModel =[HYDetialDescriptionViewModel viewModelWithObj:m];
    }
    
    self.isBemoved = model.isbemoved;
    
}


-(void)loadSection
{
    NSMutableArray *tem =[NSMutableArray new];
    if(self.headViewModel)
    {
        [tem addObject:[NSNumber numberWithInt:HYDetialMainPicType]];
    }
    if(self.picShwoViewModel)
    {
        [tem addObject:[NSNumber numberWithInt:HYDetialShowPicType]];
    }
    if(self.baseInfoViewModel)
    {
        [tem addObject:[NSNumber numberWithInt:HYDetialBaseInfoType]];
    }
    if(self.befriendViewModel)
    {
        [tem addObject:[NSNumber numberWithInt:HYDetialbeFriendType]];
    }
    if(self.interduceViewModel)
    {
        [tem addObject:[NSNumber numberWithInt:HYDetialInterduceType]];
    }
    
    self.SectionArray = [tem copy];
}

@end
