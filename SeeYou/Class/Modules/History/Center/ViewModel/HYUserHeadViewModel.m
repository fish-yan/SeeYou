//
//  HYUserHeadViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserHeadViewModel.h"
#import "HYUserCenterModel.h"
#import "LEEAttributed.h"
#import "HYUserdetialInfoModel.h"
@implementation HYUserHeadViewModel

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
+ (instancetype)viewModelWithObj:(id)obj {
    HYUserHeadViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYUserCenterModel*)obj
{
    self.avatar = [NSURL URLWithString:obj.avatar];
    self.username = obj.name;
    self.marraytime = obj.wantToMarrayTime;
    NSMutableAttributedString * sttstring = [LEEAttributed attributedMake:^(LEEAttributedMake *make) {
        if([obj.age intValue]>0)
        {
            make.add([NSString stringWithFormat:@"%@岁",obj.age])
            .add(@" ")
            .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
            .add(@" ");
        }
        if(obj.height.length>0)
        {
            make.add([NSString stringWithFormat:@"%@cm",obj.height])
            .add(@" ")
            .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
            .add(@" ");
        }
        if(obj.reciveSalary.length>0)
        {
        make.add([NSString stringWithFormat:@"%@",obj.reciveSalary])
        .add(@" ")
        .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
        .add(@" ");
        }
        if(obj.constellation.length>0)
        {
            make.add([NSString stringWithFormat:@"%@",obj.constellation]);
        }
    }];
    
    self.baseInfostring = sttstring;
     self.city = obj.citystr;
    
}


+ (instancetype)viewModelWithObjByDetial:(id)obj {
    HYUserHeadViewModel *vm = [[self alloc] init];
    [vm setObjByDetial:obj];
    return vm;
}

-(void)setObjByDetial:(HYUserdetialInfoModel*)obj
{
    self.avatar = [NSURL URLWithString:obj.avatar];
    self.username = obj.name;
    self.marraytime = obj.wantToMarrayTime;
    
    NSMutableAttributedString * sttstring = [LEEAttributed attributedMake:^(LEEAttributedMake *make) {
        if([obj.age intValue]>0)
        {
            make.add([NSString stringWithFormat:@"%@岁",obj.age])
            .add(@" ")
            .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
            .add(@" ");
        }
        if(obj.height.length>0)
        {
            make.add([NSString stringWithFormat:@"%@cm",obj.height])
            .add(@" ")
            .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
            .add(@" ");
        }
        if(obj.reciveSalary.length>0)
        {
            make.add([NSString stringWithFormat:@"%@",obj.reciveSalary])
            .add(@" ")
            .add(@"●").style(@{@"color":[UIColor bgdbdbdbdColor],@"font":Font_PINGFANG_SC(8)})
            .add(@" ");
        }
        if(obj.constellation.length>0)
        {
            make.add([NSString stringWithFormat:@"%@",obj.constellation]);
        }
    }];
    self.baseInfostring = sttstring;
    self.city = obj.city;
    
}


@end
