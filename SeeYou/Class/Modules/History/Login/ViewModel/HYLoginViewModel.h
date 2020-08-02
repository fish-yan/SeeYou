//
//  HYLoginViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYLoginViewModel : HYBaseViewModel

@property(nonatomic ,strong) NSString * userName;
@property(nonatomic ,strong) NSString *password;

@property(nonatomic ,strong) RACCommand * loginCommond;


@end
