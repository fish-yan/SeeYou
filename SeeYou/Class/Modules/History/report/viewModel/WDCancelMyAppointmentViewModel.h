//
//  WDCancelMyAppointmentViewModel.h
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface WDCancelMyAppointmentViewModel : HYBaseViewModel

@property(nonatomic ,strong)NSArray * reportContentList;

@property(nonatomic ,strong) NSMutableArray * readyUploadImageArray;

/// 提交理由的请求命令

@property(nonatomic ,strong) RACCommand * getreportListCommand;
@property (nonatomic, strong) RACCommand *submitCommand;


@end
