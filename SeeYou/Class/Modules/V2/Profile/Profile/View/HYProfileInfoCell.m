//
//  HYProfileInfoCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYProfileInfoCell.h"

@interface NSMutableAttributedString (AppendOval)

- (NSMutableAttributedString *)appendString:(NSString *)str;

@end

@implementation NSMutableAttributedString (AppendOval)

- (NSMutableAttributedString *)appendString:(NSString *)str {
    if (!str) return self;
    
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"user_info_gray_oval"];
    NSAttributedString *oval = [NSMutableAttributedString attributedStringWithAttachment:attach];
    [self appendAttributedString:oval];
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", str]]];
    
    return self;
}

@end


@interface HYProfileInfoCell()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIButton *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *memberLabel;
@property (nonatomic, strong) UILabel *infoLabel;
//@property (nonatomic, strong) UILabel *ageLabel;
//@property (nonatomic, strong) UILabel *heightLabel;
//@property (nonatomic, strong) UILabel *wageLabel;

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *friendRequireBtn;
@property (nonatomic, strong) UIButton *vertifyBtn;
@property (nonatomic, strong) UIButton *infoBtn;

@end

@implementation HYProfileInfoCell

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
    [[RACObserve(self, cellModel)
      map:^id _Nullable(HYProfileCellModel * _Nullable value) {
        return value.value;
    }]
     subscribeNext:^(HYUserCenterModel * _Nullable x) {
        @strongify(self);
        self.nameLabel.text = x.name;
         self.memberLabel.text = x.vipstatus ? @"高级会员" : @"";
         
         NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc]
                                                initWithString:[NSString stringWithFormat:@"%@岁", x.age]];
         self.infoLabel.attributedText = [[attrStrM
                                            appendString:[NSString stringWithFormat:@"%@cm", x.height ?: @"-"]]
                                           appendString:x.reciveSalary];
         
         [self.avatarView sd_setImageWithURL:[NSURL URLWithString:x.avatar]
                                    forState:UIControlStateNormal
                            placeholderImage:[UIImage imageNamed:@"male_sel_selected"]];

    }];
 
    
    [[self.avatarView rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         if (self.avatarHandler) {
             self.avatarHandler();
         }
     }];
}


- (NSAttributedString *)attributeNameWithName:(NSString *)name isVip:(BOOL)isVip {
    NSMutableAttributedString *attrStringM = [[NSMutableAttributedString alloc]
                                              initWithString:name
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                                           NSForegroundColorAttributeName: [UIColor whiteColor]
                                                           }];
    if (isVip) {
        NSAttributedString *vipAttr = [[NSAttributedString alloc]
                                       initWithString:@"  高级会员"
                                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],
                                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                    }];
        [attrStringM appendAttributedString:vipAttr];
    }
    return attrStringM;
}

#pragma mark - Action

- (void)go2AccountView {
    if (self.friendRequireHandler) {
        self.friendRequireHandler();
    }
}

- (void)go2VeritfyView {
    if (self.identityHandler) {
        self.identityHandler();
    }
}

- (void)go2InfoView {
    if (self.userInfoHandler) {
        self.userInfoHandler();
    }
}

#pragma mark - Setup UI

- (void)setupSubviews {
    _bgImgView = [UIImageView imageViewWithImageName:@"Bitmap" inView:self.contentView];
    
    _avatarView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_avatarView setImage:[UIImage imageNamed:@"defauleimage1"] forState:UIControlStateNormal];
    [self.contentView addSubview:_avatarView];
    _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarView.layer.borderWidth = 2;
    _avatarView.layer.cornerRadius = 65 * 0.5;
    _avatarView.clipsToBounds = YES;
    
    _nameLabel = [UILabel labelWithText:@"张三"
                              textColor:[UIColor whiteColor]
                               fontSize:20
                                 inView:self.contentView
                              tapAction:NULL];
    _memberLabel = [UILabel labelWithText:@"高级会员"
                                textColor:[UIColor whiteColor]
                                 fontSize:13
                                   inView:self.contentView
                                tapAction:NULL];
    _infoLabel = [UILabel labelWithText:@""
                             textColor:[UIColor whiteColor]
                              fontSize:13
                                inView:self.contentView
                             tapAction:NULL];
    _infoLabel.numberOfLines = 2;
    
    //
    _container = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.contentView];
    _container.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _container.layer.shadowOpacity = 0.2;
    _container.layer.shadowOffset = CGSizeMake(1, 1);
    _container.layer.cornerRadius = 15;
    
    _friendRequireBtn = [self btnWithImageName:@"profile_account" name:@"交友条件" action:@selector(go2AccountView)];
    _vertifyBtn = [self btnWithImageName:@"profile_vertify" name:@"实名认证" action:@selector(go2VeritfyView)];
    _infoBtn = [self btnWithImageName:@"profile_info" name:@"我的资料" action:@selector(go2InfoView)];
}

- (void)setupSubviewsLayout {
    CGFloat scale = SCREEN_WIDTH / 375.0 * 190.0;
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(190).multipliedBy(scale);
    }];
    
    //
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65, 65));
        make.left.offset(30);
        make.top.offset(69);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(10);
        make.top.equalTo(_avatarView).offset(10);
        make.width.mas_lessThanOrEqualTo(140);
    }];
    
    [_memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(10);
    }];
    
    //
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(10);
        make.right.offset(-10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
    }];
    
    // ------
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.height.mas_equalTo(120);
        make.top.offset(174);
    }];
    
    
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(80);
    }];

    [_vertifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container);
        make.top.bottom.width.equalTo(_infoBtn);
    }];

    [_friendRequireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-40);
        make.top.bottom.width.equalTo(_infoBtn);
    }];

}


- (UIButton *)btnWithImageName:(NSString *)imgName name:(NSString *)name action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#313131"] forState:UIControlStateNormal];
    [btn setImagePositionStyle:ImagePositionStyleTop imageTitleMargin:20];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    [self.container addSubview:btn];
    return btn;
}

#pragma mark - Lazy Loading
@end
