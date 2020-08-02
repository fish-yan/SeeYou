//
//  LoginTextfiledView.h
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendCodeButton.h"
typedef NS_ENUM(NSInteger, LoginTextFieldViewType){
    PwdTextFieldType, //密码型
    SendCodeTextFieldType,
    NormalTextFieldType,
};
@interface LoginTextfiledView : UIView

@property (nonatomic,strong)UITextField * textField;

@property (nonatomic,strong)UIView * lineView;

@property (nonatomic,strong)UIButton * showPwdButton;

@property (nonatomic,assign)LoginTextFieldViewType viewType;

@property (nonatomic,strong)SendCodeButton * sendCodeButton;

@property (nonatomic,copy)NSString * placeHolder;

@property (nonatomic,copy)dispatch_block_t getVeryCodeBlock;

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type
                              title:(NSString *)title;


- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type withFrame:(CGRect)frame;

- (instancetype)initWithPlaceHolder:(NSString *)placeHolder
             LoginTextFieldViewType:(LoginTextFieldViewType)type withFrame:(CGRect)frame title:(NSString *)title;
@end
