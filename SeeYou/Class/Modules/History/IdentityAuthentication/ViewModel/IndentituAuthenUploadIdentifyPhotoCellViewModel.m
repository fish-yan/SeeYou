//
//  IndentituAuthenUploadIdentifyPhotoCellViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IndentituAuthenUploadIdentifyPhotoCellViewModel.h"
#import "IndentifityAuthenDescriptionModel.h"
#import "WDQiniuUploadHelper.h"
@implementation IndentituAuthenUploadIdentifyPhotoCellViewModel



typedef enum _TTGState {
    TTGStateOK  = 0,
    TTGStateError,
    TTGStateUnknow
} TTGState;


-(id)init
{
    self = [super init];
    if(self)
    {
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    
    @weakify(self);
    self.doRacommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        
        NSArray *array =@[self.forwardimage,self.backwardimage];
        
        [[WDQiniuUploadHelper shareInstance] uploadImagesSignalWithImagesWithIdentify:array withSuccessBlock:^(WDResponseModel *model) {
            @strongify(self);
            self.result=model;
            
        } failreBlock:^(NSError *error) {
            
            self.error = error;
        }];
        
        return [RACSignal empty];
        
        
    }];
    
}



+ (instancetype)viewModelWithObj:(id)obj {
    IndentituAuthenUploadIdentifyPhotoCellViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(IndentifityAuthenUploadModel*)obj
{
    self.forwrdUrl =[NSURL URLWithString:obj.forwordPicUrl];
    self.backwrdUrl =[NSURL URLWithString:obj.backPicUrl];
    self.forwardimage =obj.forwardimage;
    self.backwardimage = obj.backwardimage;
}
@end
