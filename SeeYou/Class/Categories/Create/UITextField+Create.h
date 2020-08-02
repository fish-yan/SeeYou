//
//  UITextField+Create.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Create)

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView;

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      placeHolder:(NSString *)placeHolder
                 placeHolderColor:(UIColor *)placeHolderColor
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView;

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      placeHolder:(NSString *)placeHolder
                 placeHolderColor:(UIColor *)placeHolderColor
                     keyboardType:(UIKeyboardType)keyboardType
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView;

@end
