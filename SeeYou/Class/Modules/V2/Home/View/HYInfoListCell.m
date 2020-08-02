//
//  HYInfoListCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYInfoListCell.h"
#import "HYPersonActionView.h"

@interface HYInfoListCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel * memberLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UILabel *localLabel;

@property (nonatomic, strong) HYPersonActionView *actionView;

@end

@implementation HYInfoListCell

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
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, model) subscribeNext:^(HYObjectListModel * _Nullable x) {
        if (!x) return;
        
        @strongify(self);
        self.nameLabel.text = x.name;
        self.infoLabel.text = [NSString stringWithFormat:@"%@岁", x.age ?: @"-"];
        self.memberLabel.hidden = !x.vipstatus;
        if (x.vipstatus) {
            [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.iconView);
                make.left.equalTo(self.iconView.mas_right).offset(10);
                make.width.mas_lessThanOrEqualTo(150);
            }];
        }
        else {
            [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.equalTo(self.iconView);
                make.left.equalTo(self.iconView.mas_right).offset(10);
                make.right.offset(-15);
            }];
        }
        self.localLabel.text = self.cellType == InfoListCellTypeCity ? x.workcity : x.distance;
        self.introLabel.text = x.intro;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:x.avatar] placeholderImage:[UIImage imageNamed:AVATAR_PLACEHOLDER]];
    }];
//    [RACObserve(self, model.beckoningstatus) subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        self.actionView.heartBtn.selected = [x boolValue];
//    }];
//    RAC(self.actionView.heartBtn, selected) = RACObserve(self, model.beckoningstatus);
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _iconView = [UIImageView imageViewWithImageName:@"pwoman" inView:self.contentView];
    _iconView.clipsToBounds = YES;
    _iconView.layer.cornerRadius = 65 * 0.5;
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    
    _nameLabel = [UILabel labelWithText:@""
                              textColor:[UIColor colorWithHexString:@"#4A4A4A"]
                               fontSize:20
                                 inView:self.contentView
                              tapAction:NULL];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    
    @weakify(self);
    _memberLabel = [UILabel labelWithText:@"高级会员"
                                textColor:[UIColor colorWithHexString:@"#FF5D9C"]
                                 fontSize:13
                                   inView:self.contentView
                                tapAction:^(UILabel *label, UIGestureRecognizer *tap) {
                                    @strongify(self);
                                    if (self.memberClicked) {
                                        self.memberClicked();
                                    }
                                }];
    
    _infoLabel = [UILabel labelWithText:@"岁"
                              textColor:[UIColor colorWithHexString:@"#464446"]
                               fontSize:13
                                 inView:self.contentView
                              tapAction:NULL];
    
    _localLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"6F6F6F"]
                                fontSize:13
                                  inView:self.contentView
                               tapAction:NULL];
    
    _introLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"#7D7D7D"]
                                fontSize:12
                                  inView:self.contentView
                               tapAction:NULL];

    self.actionView = [HYPersonActionView viewWithHeartClickAction:^(UIButton *btn) {
        @strongify(self);
        if (self.heartClickHandler) {
            self.heartClickHandler(self.model.uid, self.model.beckoningstatus);
        }

    }
    dateClickAction:^(UIButton *btn) {
        @strongify(self);
        if (self.dateClickHandler) {
            self.dateClickHandler(self.model.appointmentid, self.model.uid);
        }
    }
    messageClickAction:^(UIButton *btn) {
        @strongify(self);
        if (self.msgClickHandler) {
            self.msgClickHandler(self.model.uid, self.model.name, self.model.avatar);
        }
    }];
    [self.contentView addSubview:self.actionView];
}

- (void)setupSubviewsLayout {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(20);
        make.width.height.mas_equalTo(66);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView);
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    [_memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(10);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
    }];
    
    [_localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_infoLabel);
        make.right.offset(-15);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_infoLabel.mas_bottom).offset(5);
        make.right.offset(-15);
    }];
    
    
    // line
    UIView *line = [UIView viewWithBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"] inView:self.contentView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(_iconView.mas_bottom).offset(20);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(line.mas_bottom);
        make.height.mas_equalTo(48);
    }];
    
    
    // separator View
    UIView *separator = [UIView viewWithBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"] inView:self.contentView];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(10);
    }];
}


#pragma mark - Lazy Loading

@end
