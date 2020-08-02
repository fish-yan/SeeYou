//
//  CPAuthenticationViewModel.h
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface CPAuthenticationViewModel : HYBaseViewModel
@property(nonatomic ,strong) NSString * userName;
@property(nonatomic ,strong) NSString * identifyNumber;
@property(nonatomic ,strong) NSString * forwardPicUrl;
@property(nonatomic ,strong) NSString * backwardPicUrl;
@property(nonatomic ,strong) NSString * allPicurl;//合照
@property(nonatomic ,strong) RACCommand * doUploadForwardImageRaccomand;//上传正面照
@property(nonatomic ,strong) RACCommand * doUploadBackImageRaccomand;//上传背面照
@property(nonatomic ,strong) RACCommand * doUploadAllImageRaccomand;//上传背面照
@property(nonatomic ,strong) RACCommand * doRaccomand;
@end
