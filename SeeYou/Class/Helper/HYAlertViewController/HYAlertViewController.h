//
//  HYAlertViewController.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//


/******
 *
 *for example
 id cancelBlock=^()
 {
 NSLog(@"1231");
 };
 id sureBlock=^()
 {
 NSLog(@"1231");
 };
 
 
 [YSMediator presentViewControllerClassName:@"HYAlertViewController"  withParams:@{@"message":@"一杯咖啡即换来一生幸福，你离对的人只差最后一步了",
 @"type":@2,
 @"alertTitle":@"WAring",
 @"rightButtonTitle":@"我要幸福",
 @"rightTitleColor":[UIColor redColor],
 @"cancelBlock":cancelBlock,
 @"sureBlock":sureBlock
 } animated:YES callBack:nil];
 *
 *
 ******/
#import "HYBaseViewController.h"

typedef enum : NSUInteger {
    HYALERTYPETONE =1,
    HYALERTTYPETWO =2,
} HYAlertType;


typedef void(^CancelBlock)();
typedef void(^SureBlock)();

@interface HYAlertAnimator :NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

@end

@interface HYAlertViewController : HYBaseViewController


@property(nonatomic ,copy)    NSString *alertTitle;
@property(nonatomic ,copy)    NSString *message;
@property(nonatomic ,strong)  UIView *maskView;
@property(nonatomic ,assign)  HYAlertType type;
@property(nonatomic ,strong)  UILabel *messageLabel;
@property(nonatomic ,copy)    NSString * leftButtonTitle;
@property(nonatomic ,copy)    UIColor * leftTitleColor;
@property(nonatomic ,copy)    NSString * rightButtonTitle;
@property(nonatomic ,copy)    UIColor * rightTitleColor;
@property(nonatomic ,assign)  int fontsize;


@property(nonatomic ,strong) UIView *alertView;


+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
@end
