//
//  HYAddressListViewModel.m
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYAddressListViewModel.h"
#import "HYAddressSubModel.h"

@implementation HYAddressListViewModel
-(id)init
{
    self =[super init];
    if(self)
    {
        [self initalize];
    }
    return self;
}

-(void)convertToViewModelArray:(NSArray *)convertArray
{
    NSMutableArray* tem =[NSMutableArray new];
    for (int i=0; i< convertArray.count; i++)
    {
        HYAddressCellViewModel *m =[HYAddressCellViewModel new];
        HYAddressSubViewModel * vm =[HYAddressSubViewModel  viewModelWithObj:[convertArray objectAtIndex:i]];
        vm.type = self.type;
        m.leftViewModel = vm;
        
        i++;
        if(i<convertArray.count)
        {
            HYAddressSubViewModel * vm =[HYAddressSubViewModel  viewModelWithObj:[convertArray objectAtIndex:i]];
            vm.type = self.type;
            m.rightViewModel = vm;
        }
        [tem addObject:m];
        
    }
    
    self.convertArray =[tem copy];
    
    
}

-(void)initalize
{
    self.titleData = [self titleInfosWithData:nil];
    
    @weakify(self);
    self.getAddresslistRaccommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *  _Nullable input) {
        @strongify(self);
        
        return [[self getlist:[NSDictionary convertParams:API_GETADDRESS_API dic:input]] doNext:^(WDResponseModel*  _Nullable x) {
            if(self.page==1)
            {
                self.orginDataArray =@[];
            }
            NSMutableArray * temarray =[NSMutableArray new];
            self.hasMore  = self.page <x.totalpage ?YES:NO;
            if(self.hasMore)
            {
                self.page ++;
            }
            [temarray addObjectsFromArray:self.orginDataArray];
            [temarray addObjectsFromArray:x.data];
            self.orginDataArray = [temarray copy];
            
            
             [self convertToViewModelArray: self.orginDataArray];
        }];
        
    }];
    
    self.fetTitleCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self fetchTitleSignal]
                doNext:^(NSDictionary *  _Nullable x) {
                    @strongify(self);
                    self.titleData = [self titleInfosWithData:x];
                }];
    }];
    
}

- (NSArray *)titleInfosWithData:(NSDictionary *)data {
    return @[[HYAddressTitleModel modelWithTitle:@"我喜欢" hasUnread:NO],
             [HYAddressTitleModel modelWithTitle:@"看过我" hasUnread:[data[@"seeme"] boolValue]],
             [HYAddressTitleModel modelWithTitle:@"喜欢我" hasUnread:[data[@"likemestatus"] boolValue]],
             [HYAddressTitleModel modelWithTitle:@"相互喜欢" hasUnread:[data[@"likeeachotherstatus"] boolValue]]];
}
- (RACSignal *)fetchTitleSignal {
    NSDictionary *params = @{};
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:@"getuseraddressunread" dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeMessage
                                     responseClass:nil]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return [value.data lastObject];
            }];
}

-(RACSignal * )getlist:(NSDictionary*)dic
{
    RACSignal *signale =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeList responseClass:[HYAddressSubModel class]];
    return signale;

                         
}


@end
