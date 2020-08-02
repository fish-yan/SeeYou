//
//  HYLoginRegisterVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/5/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"


@interface HYLoginRegisterVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *getMobileCodeCmd;
@property (nonatomic, strong) RACCommand *verifyCmd;

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSInteger cutdownTime;
@property (nonatomic, assign) BOOL resendEnable;
@property (nonatomic, assign) UserInfoType infoType;

@end
