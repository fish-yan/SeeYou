//
//  HYPrivateCellViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYPrivateCellViewModel.h"
#import "HYPrivateCellViewModel.h"
#import "HYPrivateModel.h"
#import "LEEAttributed.h"
@implementation HYPrivateCellViewModel

-(id)init
{
    self = [super init];
    if(self)
    {
        [self initialze];
    }
    return self;
}


- (void)initialze
{
    @weakify(self);
    self.doRecommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        NSDictionary *dic=@{@"fromuid":self.uid};
        return [[self postMessage:[NSDictionary convertParams:API_MESSAGE_DELETEUNREAD dic:dic]] doNext:^(id  _Nullable x) {
            @strongify(self);
            self.isread=@0;
        }];
    }];
}

- (RACSignal *)postMessage:(NSDictionary *)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}

+ (instancetype)viewModelWithObj:(id)obj {
    HYPrivateCellViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}


- (void)setObj:(HYPrivateModel*)obj
{
    self.uid = obj.userId;
    self.fromsex     = obj.fromsex;
    self.phtotUrl = [NSURL URLWithString:obj.picUrl];
    self.photoString = obj.picUrl==nil?@"":obj.picUrl;
    self.userName = obj.nickname;
    self.time     = obj.reciveTime;
    self.lastMessage = obj.lastContent;
    self.isVip = obj.isVip;
    self.isread      = obj.isRead;
    self.usertype  = obj.usertype;
    self.messageID   = obj.messageID;
    self.newcount = [self covertNewMessageCount:obj.newcount];
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
        if(obj.salary.length>0)
        {
            make.add([NSString stringWithFormat:@"%@",obj.salary]);
        } }];
         
    self.des = sttstring;
   
}

- (NSString *)covertNewMessageCount:(NSString *)cnt {
    NSInteger numb = [cnt integerValue];
    if (numb == 0) return @"";
    if (numb > 99) return @"  99+  ";
    return [NSString stringWithFormat:@"  +%@  ", cnt];
}

@end
