//
//  HYCompleteInfoVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/5/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYCompleteInfoVM : HYBaseViewModel

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) BOOL isMale;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, strong) NSNumber *workareaCode;
@property (nonatomic, copy) NSString *salary;

@property (nonatomic, strong) RACCommand *saveInfoCmd;


@end
