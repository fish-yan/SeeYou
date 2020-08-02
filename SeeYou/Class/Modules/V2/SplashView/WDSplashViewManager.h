//
//  WDSplashViewManager.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/4.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 启动引导页显示管理器
@interface WDSplashViewManager : NSObject

/// 显示启动引导页命令
@property (nonatomic, strong) RACCommand *showCommand;

/// 类方法,快速创建引导页对象
+ (instancetype)manager;

- (void)addSplashViewDismissObserver:(NSObject *)observer selector:(SEL)selector;
@end
