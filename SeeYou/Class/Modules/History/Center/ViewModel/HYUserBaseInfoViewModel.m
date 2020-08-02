//
//  HYUserBaseInfoViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserBaseInfoViewModel.h"
#import "HYUserCenterBaseModel.h"
@implementation HYUserBaseInfoViewModel
-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
+ (instancetype)viewModelWithObj:(id)obj {
    HYUserBaseInfoViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYUserCenterBaseModel*)obj
{
    self.title = obj.title;
    self.value = obj.value;
    self.hiddenArrow = obj.hiddenArrow;
    self.type = obj.type;
}

@end
