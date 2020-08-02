//
//  HYLoginRegisterBaseVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYLoginRegisterBaseVC.h"

@interface HYLoginRegisterBaseVC ()

@end

@implementation HYLoginRegisterBaseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasBgAction = NO;
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = [UIApplication sharedApplication].keyWindow.bounds;
    layer.colors = @[
                     (__bridge id)[UIColor colorWithRed:253/255. green:166/255. blue:112/255. alpha:1].CGColor,
                     (__bridge id)[UIColor colorWithRed:253/255. green:107/255. blue:148/255. alpha:1].CGColor
                     ];
    layer.startPoint = CGPointZero;
    layer.endPoint = CGPointMake(0, 1);
    [bgView.layer addSublayer:layer];

    [self.view insertSubview:bgView atIndex:0];
    
//    CAGradientLayer *layer = [CAGradientLayer layer];
//    layer.frame = [UIApplication sharedApplication].keyWindow.bounds;
//    layer.colors = @[
//                     (__bridge id)[UIColor colorWithRed:253/255. green:166/255. blue:112/255. alpha:1].CGColor,
//                     (__bridge id)[UIColor colorWithRed:253/255. green:107/255. blue:148/255. alpha:1].CGColor
//                     ];
//    layer.startPoint = CGPointZero;
//    layer.endPoint = CGPointMake(0, 1);
//    [self.view.layer insertSublayer:layer atIndex:0];
    
    _goBackBtn = [UIButton buttonWithNormalImgName:@"nav_back_white"
                                           bgColor:nil
                                            inView:self.view
                                            action:^(UIButton *btn) {
                                                [self popBack];
                                            }];
    
    
    [_goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
