//
//  WDCancelMyAppointmentViewModel.m
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDCancelMyAppointmentViewModel.h"
#import "WDReportModel.h"
@interface WDCancelMyAppointmentViewModel ()

@end

@implementation WDCancelMyAppointmentViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
        self.readyUploadImageArray =[NSMutableArray new];
        
    }
    return self;
}

- (void)initialize {
    
    // 提交理由按钮点击执行命令
    @weakify(self);
    
    self.getreportListCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary*  _Nullable input) {
        @strongify(self);
        return [[self reasonReportListRequestSignal:[NSDictionary convertParams:API_GETREPORTLIST dic:@{}]]
                doNext:^(WDResponseModel * _Nullable x) {
                    @strongify(self);
                    
                    NSMutableArray * tem =[NSMutableArray new];
                    NSArray * array = x.data;
                    for (int i=0; i<array.count; i++) {
                        WDReportModel * m =[WDReportModel new];
                        m.content=array[i];
                        m.contentID=[NSString stringWithFormat:@"%d",i];
                        m.Selected=NO;
                        [tem addObject:m];
                    }
                    
                    self.reportContentList = [tem copy];
                }];
    }];
    
    self.submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary*  _Nullable input) {
        @strongify(self);
        
        
        
        
        
        return [[self reasonSubmitRequestSignal:input]
                doNext:^(WDResponseModel * _Nullable x) {
                    
                }];
    }];
}

- (RACSignal *)reasonReportListRequestSignal:(NSDictionary *)params {
    
    RACSignal *s = [WDRequestAdapter requestSignalWithURL:@""
                                                   params:params
                                              requestType:WDRequestTypePOST
                                             responseType:WDResponseTypeList
                                            responseClass:[NSString class]];
    return s;
}


- (RACSignal *)reasonSubmitRequestSignal:(NSDictionary *)params {
    
    RACSignal *s = [WDRequestAdapter requestSignalWithURL:@""
                                                   params:params
                                              requestType:WDRequestTypePOST
                                             responseType:WDResponseTypeMessage
                                            responseClass:nil];
    return s;
}
@end
