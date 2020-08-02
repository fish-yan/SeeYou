//
//  UILabel+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                      fontSize:fontSize
               backgroundColor:nil
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                 textAlignment:alignment
                      fontSize:fontSize
               backgroundColor:nil
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    return [self labelWithText:text
                     textColor:textColor
                 textAlignment:NSTextAlignmentNatural
                      fontSize:fontSize
               backgroundColor:bgColor
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                  fontSize:(CGFloat)fontSize
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    if (fontSize <= 0) fontSize = 14.0;
    
    return [self labelWithText:text
                     textColor:textColor
                 textAlignment:alignment
                          font:Font_PINGFANG_SC(fontSize)
               backgroundColor:bgColor
                        inView:inView
                     tapAction:tapAction];
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)alignment
                      font:(UIFont *)font
           backgroundColor:(UIColor *)bgColor
                    inView:(__kindof UIView *)inView
                 tapAction:(void(^)(UILabel *label, UIGestureRecognizer *tap))tapAction {
    if (textColor == nil) textColor = [UIColor blackColor];
    if (font == nil) Font_PINGFANG_SC(14);
    if (bgColor == nil) bgColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.textAlignment = alignment;
    label.font = font;
    [label sizeToFit];
    
    if (tapAction) {
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [label addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            tapAction(label, x);
        }];
    }
    if (inView && [inView isKindOfClass:[UIView class]]) {
        [inView addSubview:label];
    }
    return label;
}

@end
