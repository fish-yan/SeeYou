//
//  HYMembershipBtnView.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/19.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYMembershipBtnView.h"

@interface HYMembershipBtnView()

@property (nonatomic, copy) void(^action)(void);

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation HYMembershipBtnView

+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle action:(void(^)(void))action {
    HYMembershipBtnView *m = [[self alloc] init];
    m.title = title;
    m.subTitle = subTitle;
    m.action = action;
    return m;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubvews];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

- (void)setAction:(void (^)(void))action {
    _action = action;
    
    
}

- (void)setupSubvews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor colorWithHexString:@"#FF5D9C"].CGColor;
    self.layer.borderWidth = 1;
    self.clipsToBounds = YES;
    
    self.titleLabel = [UILabel labelWithText:self.title
                                   textColor:[UIColor colorWithHexString:@"#313131"]
                                    fontSize:15
                                      inView:self
                                   tapAction:NULL];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.subTitleLabel = [UILabel labelWithText:self.subTitle
                                   textColor:[UIColor colorWithHexString:@"#FF5D9C"]
                                    fontSize:15
                                      inView:self
                                   tapAction:NULL];

    self.subTitleLabel.textAlignment=NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        if (self.action) {
            self.action();
        }
    }];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(25);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.equalTo(@15);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
}

@end
