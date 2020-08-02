//
//  UITextView+Create.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Create)

+ (instancetype)textViewWithText:(NSString *)text
                       textColor:(UIColor *)textColor
                        fontSize:(CGFloat)fontSize
                        delegate:(id<UITextViewDelegate>)delegate
                           inView:(__kindof UIView *)inView;

+ (instancetype)textViewWithText:(NSString *)text
                       textColor:(UIColor *)textColor
                        fontSize:(CGFloat)fontSize
                     placeHolder:(NSString *)placeHolder
                    placeHolderColor:(UIColor *)placeHolderColor
                        delegate:(id<UITextViewDelegate>)delegate
                          inView:(__kindof UIView *)inView;

@end
