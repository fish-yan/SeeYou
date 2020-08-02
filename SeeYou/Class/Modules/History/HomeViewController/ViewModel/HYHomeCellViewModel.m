//
//  HYHomeCellViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYHomeCellViewModel.h"
#import "HYHomeModel.h"
#import "LEEAttributed.h"
@implementation HYHomeCellViewModel


-(id)init
{
    self = [super init];
    if(self)
    {
        [self initaileze];
    }
    return self;
}

+ (instancetype)viewModelWithObj:(id)obj {
    HYHomeCellViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYHomeModel*)obj
{
    self.userId       = obj.userId;
    self.phototUrl    =[NSURL URLWithString:obj.picUrl];
    self.Url = obj.picUrl;
    self.isVerify     = obj.isVerify;
    self.isBeMoved    =obj.isBeMoved;
    self.userName     =obj.userName;
    self.wantToMarrayTime =obj.wantToMarrayTime;
    
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
            make .add([NSString stringWithFormat:@"%@cm",obj.height])
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
    
    self.city = obj.city;
    self.baseinfoString = sttstring;
    self.interduce = obj.interduce;
    
}



- (RACSignal*)requestBeMoved:(NSDictionary *)dic
{
    RACSignal * signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}


- (void)initaileze
{
    @weakify(self);
    self.doBeMovedCommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       @strongify(self);
        NSDictionary *dic =@{@"uid":self.userId,@"type":(self.isBeMoved?@"2":@"1")};
        return [[self  requestBeMoved:[NSDictionary convertParams:API_ISBEMOVED dic:dic]] doNext:^(id  _Nullable x) {
            @strongify(self);
            self.isBeMoved =!self.isBeMoved;
        }];
    }];
}




@end
