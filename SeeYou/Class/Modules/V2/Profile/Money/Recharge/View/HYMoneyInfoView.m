//
//  HYMoneyInfoView.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMoneyInfoView.h"

@interface HYMoneyInfoView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation HYMoneyInfoView

+ (instancetype)viewWithType:(InfoViewType)type andFrame:(CGRect)frame {
    HYMoneyInfoView *v = [[HYMoneyInfoView alloc] initWithFrame:frame];
    v.type = type;
    return v;
}

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubvews];
        [self bind];
    }
    
    return self;
}

- (void)setupSubvews {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.layer.bounds;
    layer.colors = @[
                     (__bridge id)[UIColor colorWithRed:1 green:91/255. blue:156/255. alpha:1].CGColor,
                     (__bridge id)[UIColor colorWithRed:1 green:171/255. blue:105/255. alpha:1].CGColor
                     ];
    layer.startPoint = CGPointZero;
    layer.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:layer];
    
    
    _titleLabel = [UILabel labelWithText:nil
                               textColor:[UIColor whiteColor]
                                fontSize:20
                                  inView:self
                               tapAction:NULL];

    _moneyLabel = [UILabel labelWithText:@"r'm'b"
                               textColor:[UIColor whiteColor]
                                fontSize:36
                                  inView:self
                               tapAction:NULL];
    _moneyLabel.font = [UIFont boldSystemFontOfSize:36];
}

- (void)setType:(InfoViewType)type {
    _type = type;
    
    [self setupSubvewsLayout];
}

- (void)setupSubvewsLayout {
    switch (self.type) {
        case InfoViewTypeLeft: {
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(20);
                make.left.offset(20);
            }];
            
            [_moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom).offset(15);
                make.left.offset(20);
            }];
            break;
        }
        case InfoViewTypeCenter: {
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(35);
                make.centerX.equalTo(self);
            }];
            
            [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom).offset(15);
                make.centerX.equalTo(self);
            }];

            break;
        }
        default:
            break;
    }
    

}

- (void)bind {
    RAC(self.titleLabel, text) = RACObserve(self, title);
    RAC(self.moneyLabel, text) = [RACObserve(self, money) map:^id _Nullable(id  _Nullable value) {
        return value ? [NSString stringWithFormat:@"¥%@", value] : @"¥0.00";
    }];
}

@end
