//
//  HYBaseViewController.h
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseViewController : UIViewController

/// YES: 有返回    NO:不能返回
@property (nonatomic, assign) BOOL canBack;
@property (nonatomic, assign) BOOL hasBgAction;
/// 返回按钮点击操作
- (void)popBack;

#pragma mark - 键盘监听事件
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardWillChange:(NSNotification *)notification;
- (void)keyboardDidChange:(NSNotification *)notification;
@end
