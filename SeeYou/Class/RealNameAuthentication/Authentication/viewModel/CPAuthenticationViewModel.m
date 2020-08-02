//
//  CPAuthenticationViewModel.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "CPAuthenticationViewModel.h"

@implementation CPAuthenticationViewModel
- (id)init
{
    self =[ super init];
    if (self)
    {
        [self initalize];
    }
    return self;
}

- (void)initalize
{
    @weakify(self);

    self.doRaccomand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic =@{
                             @"uid":@"",
                             @"name":self.userName,
                             @"personcard":self.identifyNumber,
                             @"image1":self.forwardPicUrl,
                             @"image2":self.backwardPicUrl,
                             @"image3":self.allPicurl};
        return [[self uploadRealData:dic ] doNext:^(id  _Nullable x) {
            
        }];
    }];
    
    self.doUploadForwardImageRaccomand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSArray*  _Nullable input) {
        
        return [[self uploadImgae:input] doNext:^(NSArray*  _Nullable x) {
            @strongify(self);
            self.forwardPicUrl =x[0];
        }];
        
    }];
    
    self.doUploadBackImageRaccomand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSArray*  _Nullable input) {
        
        return [[self uploadImgae:input] doNext:^(NSArray* _Nullable x) {
            @strongify(self);
            self.backwardPicUrl =x[0];
        }];
        
    }];
    
    self.doUploadAllImageRaccomand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSArray*  _Nullable input) {
        
        return [[self uploadImgae:input] doNext:^(NSArray*  _Nullable x) {
            @strongify(self);
            self.allPicurl =x[0];
        }];
        
    }];
    
}

- (RACSignal *) uploadImgae:(NSArray*)photoArray
{
    RACSignal *signal ;//=[WDRequestAdapter uploadImagesSignalWithImages:photoArray];
    return signal;
}

- (RACSignal*) uploadRealData:(NSDictionary*)dic
{
    RACSignal * signal;// =[WDRequestAdapter requestSignalWithURL:AUTHENTICATION_COMMIT_API params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeMessage responseClass:nil];
    return signal;
}

@end
