//
//  LoginTextfiledView.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "LoginTextfiledView.h"

@interface LoginTextfiledView ()<UITextFieldDelegate>
{
    NSString *previousTextFieldContent;
    UITextRange *previousSelection;
}
@end

@implementation LoginTextfiledView

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.placeholder = @"验证码";
        _textField.font = Font_PINGFANG_SC(15);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


- (UIButton *)showPwdButton{
    if (!_showPwdButton) {
        _showPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showPwdButton setImage:[UIImage imageNamed:@"passwordeye"] forState:UIControlStateNormal];
        [_showPwdButton addTarget:self action:@selector(showPwdFunction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPwdButton;
    
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor line0Color];
    }
    return _lineView;
}


- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type
                              title:(NSString *)title{
    
    self = [super init];
    if (self) {
        [self setupViewByType:type];
        self.textField.placeholder = placeHolder;
        self.viewType = type;
        self.placeHolder = placeHolder;
    }
    return self;
}
- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type withFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewByType:type];
        self.viewType = type;
        self.textField.placeholder = placeHolder;
        self.placeHolder = placeHolder;
    }
    return self;
}


- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type withFrame:(CGRect)frame title:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewByType:type];
        self.textField.placeholder = placeHolder;
        self.viewType = type;
        self.placeHolder = placeHolder;
    }
    return self;
    
}

- (void)setupViewByType:(LoginTextFieldViewType)type{
    @weakify(self);
    [self addSubview:self.textField];
    switch (type) {
        case PwdTextFieldType:
        {
            self.textField.secureTextEntry = YES;
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.equalTo(self).offset(20.);
                make.right.equalTo(self).offset(-60.);
                make.top.equalTo(self.mas_top).offset(20);
                make.height.mas_equalTo(35);
            }];
            [self addSubview: self.showPwdButton];
            [self.showPwdButton setImage:[UIImage imageNamed:@"passwordeye"] forState:UIControlStateNormal];
            [self.showPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.right.equalTo(self).offset(-20);
                make.centerY.equalTo(self.textField);
                make.size.mas_equalTo(CGSizeMake(30., 35.));
            }];
            self.textField.keyboardType    = UIKeyboardTypeASCIICapable;
            
        }
            break;
        case SendCodeTextFieldType:
        {
            self.textField.keyboardType    = UIKeyboardTypeNumberPad;
            self.textField.secureTextEntry = NO;
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.equalTo(self).offset(20.);
                make.right.equalTo(self).offset(-160.);
                make.top.equalTo(self.mas_top).offset(20);
                make.height.mas_equalTo(35.);
            }];
            UIView * rightLine  = [UIView new];
            rightLine.backgroundColor = [UIColor clearColor];
            [self addSubview:rightLine];
            [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
                 @strongify(self);
                make.left.equalTo(self.textField.mas_right);
                make.centerY.equalTo(self.textField.mas_centerY);
                make.width.mas_equalTo(@0.5);
                make.height.mas_equalTo(@16.);
                
            }];
            self.sendCodeButton = [[SendCodeButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 115, 20, 95, 35)];;
            [ self.sendCodeButton setTitle:@"点击获取" forState:UIControlStateNormal];
            [ self.sendCodeButton.titleLabel setFont: [UIFont systemFontOfSize:13.]];
            [ self.sendCodeButton setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
            [ self.sendCodeButton addTarget:self action:@selector(getVeryCodeFunction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:self.sendCodeButton];
            
        }
            break;
        default:
        {
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                 @strongify(self);
                make.left.equalTo(self).offset(20.);
                make.right.equalTo(self).offset(-20.);
                make.top.equalTo(self.mas_top).offset(20);
                make.height.mas_equalTo(35.);
            }];
            
        }
            break;
    }
    
    
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(0.);
        make.height.mas_equalTo(0.5);
    }];
    
    
}
#pragma mark -获取验证码
- (void)getVeryCodeFunction:(id)sender{
    if(self.getVeryCodeBlock){
        self.getVeryCodeBlock();
    }
    
}

#pragma mark -显示密码
- (void)showPwdFunction:(id)sender{
 
    if(self.textField.secureTextEntry ==YES){
        self.textField.secureTextEntry = NO;
        [self.showPwdButton setImage:[UIImage imageNamed:@"passwordshoweye"] forState:UIControlStateNormal];
    }else{
        self.textField.secureTextEntry = YES;
        [self.showPwdButton setImage:[UIImage imageNamed:@"passwordeye"] forState:UIControlStateNormal];
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    self.lineView.backgroundColor = [UIColor line0Color];
    /*WS(weakSelf)
     
     
     [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(weakSelf).offset(30.);
     make.right.equalTo(weakSelf).offset(-30.);
     make.top.equalTo(weakSelf.mas_top).offset(0.);
     make.height.mas_equalTo(12.5);
     }];
     
     textField.placeholder = @"";
     [UIView animateWithDuration:0.3 animations:^{
     weakSelf.titleLabel.alpha = 1.0;
     weakSelf.titleLabel.transform = CGAffineTransformMakeTranslation(0, -25);
     }];
     
     
     [UIView animateWithDuration:5.0 animations:^{
     self.titleLabel.font = [UIFont systemFontOfSize:14.];
     
     [weakSelf.titleLabel layoutIfNeeded];
     }];
     */
    
}
- (void)textFieldEditingChanged:(UITextField *)textField
{
    if(self.viewType == NormalTextFieldType){
        
        //限制手机账号长度（有两个空格）
        if (textField.text.length > 13) {
            textField.text = [textField.text substringToIndex:13];
        }
        
        NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
        
        NSString *currentStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *preStr = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        //正在执行删除操作时为0，否则为1
        char editFlag = 0;
        if (currentStr.length <= preStr.length) {
            editFlag = 0;
        }
        else {
            editFlag = 1;
        }
        
        NSMutableString *tempStr = [NSMutableString new];
        
        int spaceCount = 0;
        if (currentStr.length < 3 && currentStr.length > -1) {
            spaceCount = 0;
        }else if (currentStr.length < 7 && currentStr.length > 2) {
            spaceCount = 1;
        }else if (currentStr.length < 12 && currentStr.length > 6) {
            spaceCount = 2;
        }
        
        for (int i = 0; i < spaceCount; i++) {
            if (i == 0) {
                [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 3)], @" "];
            }else if (i == 1) {
                [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(3, 4)], @" "];
            }else if (i == 2) {
                [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
            }
        }
        
        if (currentStr.length == 11) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
        }
        if (currentStr.length < 4) {
            [tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 3, currentStr.length % 3)]];
        }else if(currentStr.length > 3 && currentStr.length <12) {
            NSString *str = [currentStr substringFromIndex:3];
            [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
            if (currentStr.length == 11) {
                [tempStr deleteCharactersInRange:NSMakeRange(13, 1)];
            }
        }
        textField.text = tempStr;
        // 当前光标的偏移位置
        NSUInteger curTargetCursorPosition = targetCursorPosition;
        
        if (editFlag == 0) {
            //删除
            if (targetCursorPosition == 9 || targetCursorPosition == 4) {
                curTargetCursorPosition = targetCursorPosition - 1;
            }
        }else {
            //添加
            if (currentStr.length == 8 || currentStr.length == 4) {
                curTargetCursorPosition = targetCursorPosition + 1;
            }
        }
        UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:curTargetCursorPosition];
        [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition :targetPosition]];
    }
}

- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:matchedStr];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.viewType == NormalTextFieldType){
        previousTextFieldContent = textField.text;
        previousSelection = textField.selectedTextRange;
    }else if(self.viewType == SendCodeTextFieldType){
        
        return YES;
    }else if (self.viewType == PwdTextFieldType){
        return YES;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    textField.text = @"";
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.lineView.backgroundColor = [UIColor line0Color];
    if([textField.text length] == 0){
        /*WS(weakSelf)
         
         [UIView animateWithDuration:0.3 animations:^{
         weakSelf.titleLabel.alpha = 0;
         weakSelf.titleLabel.transform = CGAffineTransformMakeTranslation(0, 0);
         }completion:^(BOOL finished) {
         textField.placeholder = self.placeHolder;
         }];
         
         [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(weakSelf).offset(30.);
         make.right.equalTo(weakSelf).offset(-30.);
         make.top.equalTo(weakSelf.mas_top).offset(27.5);
         make.height.mas_equalTo(12.5);
         }];
         
         [UIView animateWithDuration:5.0 animations:^{
         
         self.titleLabel.font = [UIFont systemFontOfSize:16.];
         [weakSelf.titleLabel layoutIfNeeded];
         }];
         */
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
