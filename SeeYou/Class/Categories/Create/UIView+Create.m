//
//  UIView+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UIView+Create.h"

@implementation UIView (Create)

+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor inView:(__kindof UIView *)inView {
    return [self viewWithBackgroundColor:bgColor inView:inView tapAction:NULL];
}

+ (instancetype)viewWithBackgroundColor:(UIColor *)bgColor
                                 inView:(__kindof UIView *)inView
                              tapAction:(void(^)(UIView *view, UIGestureRecognizer *tap))tapAction {
    if (bgColor == nil) bgColor = [UIColor clearColor];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = bgColor;
    
    if (tapAction) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [v addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            tapAction(v, x);
        }];
    }
    
    if (inView) [inView addSubview:v];
    
    return v;
}

@end
