//
//  HYHomeCellViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYHomeCellViewModel : HYBaseViewModel
@property(nonatomic ,copy) NSString *userId;
@property(nonatomic ,strong) NSURL  *phototUrl;
@property(nonatomic ,strong) NSString   *Url;
@property(nonatomic ,assign) BOOL  isVerify;
@property(nonatomic ,assign) BOOL  isBeMoved;
@property(nonatomic ,copy)   NSString *userName;
@property(nonatomic ,copy)   NSString *wantToMarrayTime;
@property(nonatomic ,copy)   NSAttributedString *baseinfoString;
@property(nonatomic ,copy)   NSString *city;
@property(nonatomic ,copy)   NSString *interduce;





@property(nonatomic ,strong) RACCommand * doBeMovedCommand;


+ (instancetype)viewModelWithObj:(id)obj;

@end
