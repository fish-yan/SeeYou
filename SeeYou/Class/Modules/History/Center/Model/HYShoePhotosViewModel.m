//
//  HYShoePhotosViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYShoePhotosViewModel.h"
#import "HYUserCenterModel.h"
@implementation HYShoePhotosViewModel
-(id)init
{
    self =[super init];
    if(self)
    {
        [self initilaize];
    }
    return self;
}

- (void)initilaize
{
   
    @weakify(self);
    self.doCommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        NSDictionary *dic=@{@"id": self.ID};
        
        return [[self deletePicture:[NSDictionary convertParams:API_DELETE_PICTURE dic:dic]] doNext:^(id  _Nullable x) {
            [WDProgressHUD hiddenHUD];
            //        [WDProgressHUD showTips:x.msg];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_UPDATE_USERINFOKEY object:nil];
             
        }];
    }];
    
    

}

-(RACSignal *)deletePicture:(NSDictionary*)dic
{
    RACSignal * signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
    
}

+ (instancetype)viewModelWithObj:(id)obj {
    HYShoePhotosViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:( PhotoModel*)obj
{
    self.url = [NSURL URLWithString:obj.url];
    self.ID = obj.mid;
    self.deleteStatus =NO;

    
}




@end
