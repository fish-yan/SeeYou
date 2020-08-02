//
//  HYMyAccountCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMyAccountCell.h"

@interface HYMyAccountCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIButton *rechargeBtn;
@property (nonatomic, strong) UIButton *transferBtn;
@property (nonatomic, strong) UIButton *withdarwBtn;

@end

@implementation HYMyAccountCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
        [self setupSubviews];
        [self setupSubviewsLayout];
        [self bind];
    }
    return self;
}

- (void)initialize {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.showBottomLine = YES;
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, model) subscribeNext:^(HYMyAccountCellModel * _Nullable x) {
        if (x == nil) return ;
        
        @strongify(self);
        switch (x.cellType) {
            case HYMyAccountCellTypeWallet: {
                self.detailBtn.hidden = NO;
                self.rechargeBtn.hidden = NO;
                self.transferBtn.hidden = YES;
                self.withdarwBtn.hidden = YES;
                break;
            }
            case HYMyAccountCellTypeIncome: {
                self.detailBtn.hidden = YES;
                self.rechargeBtn.hidden = YES;
                self.transferBtn.hidden = NO;
                self.withdarwBtn.hidden = NO;
                break;
            }
            default:
                break;
        }
        
        self.titleLabel.text = x.title;
        self.descLabel.text = x.desc;
        self.valueLabel.text = x.value;
    }];
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:nil
                               textColor:[UIColor colorWithHexString:@"#313131"]
                                fontSize:20
                                  inView:self.contentView
                               tapAction:NULL];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    _descLabel = [UILabel labelWithText:nil
                               textColor:[UIColor colorWithHexString:@"#A6A6A6"]
                                fontSize:12
                                  inView:self.contentView
                               tapAction:NULL];
    
    
    _valueLabel = [UILabel labelWithText:nil
                               textColor:[UIColor colorWithHexString:@"#464446"]
                                fontSize:18
                                  inView:self.contentView
                               tapAction:NULL];
    _valueLabel.font = [UIFont boldSystemFontOfSize:18];
    
    @weakify(self);
    _detailBtn = [self actionBtnWithTitle:@"明细" handle:^(UIButton *btn) {
        @strongify(self);
        if (self.detailAction) {
            self.detailAction();
        }
    }];
    
    _rechargeBtn = [self actionBtnWithTitle:@"充值" handle:^(UIButton *btn) {
        @strongify(self);
        if (self.rechargeAction) {
            self.rechargeAction();
        }
    }];
    
    _withdarwBtn = [self actionBtnWithTitle:@"提现" handle:^(UIButton *btn) {
        @strongify(self);
        if (self.withdarwAction) {
            self.withdarwAction();
        }
    }];
    
    _transferBtn = [self actionBtnWithTitle:@"转钱包" handle:^(UIButton *btn) {
        @strongify(self);
        if (self.transferAction) {
            self.transferAction();
        }
    }];
}

- (void)setupSubviewsLayout {
    CGFloat padding = 15;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(22);
        make.left.offset(padding);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.equalTo(_titleLabel.mas_bottom);//.offset(3);
    }];
    
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.equalTo(_descLabel.mas_bottom).offset(5);
    }];
    
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_valueLabel);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [_rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_valueLabel);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [_withdarwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_valueLabel);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [_transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_withdarwBtn.mas_left).offset(-13);
        make.centerY.equalTo(_valueLabel);
        make.size.mas_equalTo(CGSizeMake(77, 30));
    }];
    

}

- (UIButton *)actionBtnWithTitle:(NSString *)title handle:(void(^)(UIButton *btn))hander {
    UIButton *btn = [UIButton buttonWithTitle:title
                                   titleColor:[UIColor whiteColor]
                                     fontSize:15
                                normalImgName:nil
                            normalBgImageName:nil
                                       inView:self.contentView
                                       action:hander];
    btn.hidden = YES;
    btn.layer.cornerRadius = 15;
    btn.clipsToBounds = YES;
    UIImage *bgImg1 = [UIImage gradientImageOfSize:CGSizeMake(60, 30)];
    [btn setBackgroundImage:bgImg1 forState:UIControlStateNormal];
    return btn;
}
#pragma mark - Lazy Loading
@end
