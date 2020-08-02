//
//  PrivateMessageDetialListViewModel.h
//  huanyuan
//
//  Created by luzhongchang on 17/8/7.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface PrivateMessageDetialListViewModel : HYBaseViewModel
@property(nonatomic ,strong) RACCommand *doCommond;
@property(nonatomic ,strong) NSString * uid;
@property(nonatomic ,strong) NSArray *listArray;
@property(nonatomic,copy) NSString * lastdate;
@property(nonatomic ,strong) NSString *content;
@property(nonatomic ,strong) RACCommand *doSendMessageCommond;
@property(nonatomic ,strong) RACCommand *pBUserCommand;

@end
