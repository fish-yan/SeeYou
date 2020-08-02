//
//  HYUserdetialBaseinfoViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserdetialBaseinfoViewModel.h"
#import "HYUserdetialInfoModel.h"
@implementation HYUserdetialBaseinfoViewModel
-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
+ (instancetype)viewModelWithObj:(id)obj {
    HYUserdetialBaseinfoViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYUserdetialInfoModel *)obj
{
    self.array = obj.baseinfo;
    
}

@end
