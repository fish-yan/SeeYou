//
//  UITextField+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UITextField+Create.h"

@implementation UITextField (Create)

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView {
    return [self textFieldWithText:text
                         textColor:textColor
                          fontSize:fontSize
                       placeHolder:nil
                  placeHolderColor:nil
                      keyboardType:UIKeyboardTypeDefault
                       andDelegate:delegate
                            inView:inView];
}

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      placeHolder:(NSString *)placeHolder
                 placeHolderColor:(UIColor *)placeHolderColor
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView {
    return [self textFieldWithText:text
                         textColor:textColor
                          fontSize:fontSize
                       placeHolder:placeHolder
                  placeHolderColor:placeHolderColor
                      keyboardType:UIKeyboardTypeDefault
                       andDelegate:delegate
                            inView:inView];
}

+ (instancetype)textFieldWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         fontSize:(CGFloat)fontSize
                      placeHolder:(NSString *)placeHolder
                 placeHolderColor:(UIColor *)placeHolderColor
                     keyboardType:(UIKeyboardType)keyboardType
                      andDelegate:(id<UITextFieldDelegate>)delegate
                           inView:(__kindof UIView *)inView {
    UITextField *textField = [[UITextField alloc] init];
    
    textField.text = text;
    textField.keyboardType = keyboardType;

    if (textColor) textField.textColor = textColor;
    if (fontSize > 0) textField.font = [UIFont systemFontOfSize:fontSize];
   
    if (placeHolderColor
        && [textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textField.attributedPlaceholder = [[NSAttributedString alloc]
                                           initWithString:placeHolder ?: @""
                                           attributes:@{NSForegroundColorAttributeName : placeHolderColor}];
    }
    else {
        if (placeHolder) textField.placeholder = placeHolder;
    }
    
    
    if (delegate && [delegate conformsToProtocol:@protocol(UITextFieldDelegate)]) {
        textField.delegate = delegate;
    }
    
    if (inView && [inView isKindOfClass:[UIView class]]) [inView addSubview:textField];
    
    return textField;
}
@end
