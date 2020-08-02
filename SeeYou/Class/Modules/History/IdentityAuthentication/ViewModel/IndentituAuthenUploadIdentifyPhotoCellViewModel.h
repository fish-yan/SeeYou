//
//  IndentituAuthenUploadIdentifyPhotoCellViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface IndentituAuthenUploadIdentifyPhotoCellViewModel : HYBaseViewModel

@property(nonatomic,strong) NSURL * forwrdUrl;
@property(nonatomic,strong) NSURL *backwrdUrl;
@property(nonatomic,strong) UIImage * forwardimage;
@property(nonatomic,strong) UIImage * backwardimage;

@property(nonatomic ,strong) RACCommand * doRacommond;

@property(nonatomic ,strong)WDResponseModel * result;
@property(nonatomic ,strong) NSError *error;


+ (instancetype)viewModelWithObj:(id)obj;

@end
