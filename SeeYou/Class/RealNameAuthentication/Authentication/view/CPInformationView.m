//
//  CPInformationView.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "CPInformationView.h"

@interface  CPInformationView()<UITextFieldDelegate>


@end

@implementation CPInformationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor =[UIColor whiteColor];
        [self setUpview];
        [self setupViewLayout];
        
        [self.contextflied addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self bind];
    }
    return self;
}


static NSInteger length;
- (void)bind {
    [[self.contextflied rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        //字数限制
#pragma mark - James
        NSInteger limitNumb = 18;
        
        NSString *toBeString = textField.text;
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            // textField.markedTextRange == nil 表示没有未选中的字
            if (toBeString.length > limitNumb && textField.markedTextRange == nil) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:limitNumb];
                
                if (rangeIndex.length == 1) {
                    textField.text = [toBeString substringToIndex:limitNumb];
                }
                else {
                    textField.text = [toBeString substringWithRange:NSMakeRange(0, length)];
                }
            }
            else {
                length = toBeString.length;
            }
        }
    }];
}
//
//-(void) limit
//{
//
//    if(self.type == CPInformationViewUserNameType)
//    {
//
//        if(self.contextflied.text.length>12)
//        {
//            self.contextflied.text = [self.contextflied.text substringToIndex:12];
//        }
//
//    }
//    else if(self.type ==CPInformationViewIdentifyType)
//    {
//        if(self.contextflied.text.length>18)
//        {
//            self.contextflied.text = [self.contextflied.text substringToIndex:18];
//        }
//    }
//
//    NSLog(@"%@",self.contextflied.text);
//
//}

- (void) setUpview
{
    self.siginLabel =[UILabel labelWithText:@"" textColor:[UIColor tcfd5492Color] fontSize:16 inView:self tapAction:nil];
    
    self.contextflied =[UITextField textFieldWithText:@"" textColor:[UIColor tcfd5492Color] fontSize:16 andDelegate:self inView:self];
    self.contextflied.returnKeyType=UIReturnKeyDone;
    self.contextflied.textAlignment =NSTextAlignmentRight;
}

- (void) setupViewLayout
{
    @weakify(self);
    [self.siginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(14);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
        make.width.equalTo(@70);
    }];
    
    
    [self.contextflied mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.siginLabel.mas_right).offset(10);
        make.centerY.equalTo(self.siginLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@16);
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if(self.type == CPInformationViewUserNameType)
    {
    
        NSInteger kMaxLength = 12;
        NSString *toBeString = textField.text;
        NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
        if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (toBeString.length > kMaxLength) {
                    textField.text = [toBeString substringToIndex:kMaxLength];
    //                self.nameStr = textField.text;
                    [WDProgressHUD showTips:@"姓名不允许输入超过12个字"];
                }
            }
            else {//有高亮选择的字符串，则暂不对文字进行统计和限制
            }
        } else {//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
                [WDProgressHUD showTips:@"姓名不允许输入超过12个字"];
            }
        }
    }
    
//    self.nameStr = textField.text;
}



@end
