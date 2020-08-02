//
//  HYuserCenterShowPicViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYuserCenterShowPicViewModel.h"
#import "HYUserCenterModel.h"
#import "HYUserdetialInfoModel.h"
@implementation HYuserCenterShowPicViewModel

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
+ (instancetype)viewModelWithObj:(id)obj {
    HYuserCenterShowPicViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYUserCenterModel*)obj
{
    self.picArray = obj.photos;
}



+ (instancetype)viewModelWithObjByDetial:(id)obj {
    HYuserCenterShowPicViewModel *vm = [[self alloc] init];
    [vm setObjbyDetial:obj];
    return vm;
}

-(void)setObjbyDetial:(HYUserdetialInfoModel*)obj
{
    self.picArray = obj.showPicArray;
}

@end
