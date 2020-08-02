//
//  WDNumTextView.m
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDNumTextView.h"

@interface WDNumTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel    *numLabel;

@property (nonatomic, strong) UILabel    *placeHolderLabel;

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UIColor    *limitColor;

@end

@implementation WDNumTextView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 添加监听器，监听自己的文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        self.textViewEnabled = NO;
        [self setupSubviews];
        [self setupSubviewsLayout];
        [self bindViewModel];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Bind
- (void)bindViewModel {
    
    @weakify(self);
    //
    [[RACObserve(self, contentText) distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.numLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)x.length, (long)self.limitNum];
        self.placeHolderLabel.hidden = [x length];
        self.limitColor = [x length] > 20 ? [UIColor redColor] :  [UIColor tc7d7d7dColor];
    }];
    
    //
    RAC(self.numLabel, textColor) = [RACObserve(self, limitColor) distinctUntilChanged];
    
    //
    RAC(self.contentTextView, editable) = [RACObserve(self, textViewEnabled) distinctUntilChanged];
    
    //
    [[RACObserve(self.contentTextView, editable) distinctUntilChanged] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.contentTextView becomeFirstResponder];
            [self.contentTextView setTextColor:[UIColor tc31Color]];
        }
        else {
            [self.contentTextView resignFirstResponder];
            [self.contentTextView setTextColor:[UIColor tc7d7d7dColor]];
        }
    }];
}

#pragma mark - Action
// 时刻监听文字键盘文字的变化，文字一旦改变便调用setNeedsDisplay方法
- (void)textDidChange {
    // 该方法会调用drawRect:方法，立即重新绘制占位文字
    self.contentText = self.contentTextView.text;
}

// 占位文字的setter方法
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
    // 文字一旦改变，立马重写绘制（内部会调drawRect:方法）
//    [self setNeedsDisplay];
}

- (void)setLimitNum:(NSInteger)limitNum {
    _limitNum = limitNum;
    self.numLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.contentTextView.text.length, (long)limitNum];
}

#pragma mark - Setup Subview
- (void)setupSubviews {
    //
    self.contentTextView = [UITextView textViewWithText:nil
                                              textColor:[UIColor tc31Color]
                                               fontSize:14.0
                                               delegate:self
                                                 inView:self];
    
    //
    self.numLabel = [UILabel labelWithText:@"0/0"
                                 textColor:[UIColor tc7d7d7dColor]
                                  fontSize:14.0
                                    inView:self
                                 tapAction:nil];
    
    //
    self.placeHolderLabel = [UILabel labelWithText:nil
                                         textColor:[UIColor tc7d7d7dColor]
                                          fontSize:14.0
                                            inView:self
                                         tapAction:nil];
}

- (void)setupSubviewsLayout {
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.contentTextView.mas_bottom);
    }];
    
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(11);
        make.top.equalTo(self).offset(8);
    }];

}

@end
