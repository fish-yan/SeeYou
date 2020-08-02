//
//  HYBaseViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseViewModel : NSObject
/// 是否还有更多数据
@property (nonatomic, assign) BOOL hasMore;

/// 是否还有更多数据传给服务器的字典
@property (nonatomic, strong) NSDictionary *moreParams;

/// 分页标志, 来自 列表数据中more_params 的flag
@property (nonatomic, strong) NSNumber *flag;

/// 用于发送请求成功信号. 不推荐使用, 建议订阅Command方式
@property (nonatomic, strong) RACSubject *successSignal;
/// 用于发送请求失败信号. 不推荐使用, 建议订阅Command方式
@property (nonatomic, strong) RACSubject *errorSignal;
/// 用于发送请求结果为空的信号. 不推荐使用, 建议订阅Command方式
@property (nonatomic, strong) RACSubject *emptySignal;


/**
 工厂方法快速创建viewModel对象
 
 @return 实例化的viewModel对象
 */
+ (instancetype)viewModel;
@end
