//
//  WDReportModel.h
//  youbaner
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface WDReportModel : HYBaseModel
@property (nonatomic ,strong) NSString * content;
@property (nonatomic ,strong) NSString * contentID;
@property (nonatomic ,assign) BOOL Selected;
@end
