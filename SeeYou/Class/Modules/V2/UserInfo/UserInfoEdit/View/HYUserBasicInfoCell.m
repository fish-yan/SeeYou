//
//  HYUserBasicInfoCell.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUserBasicInfoCell.h"

@interface HYUserBasicInfoCell ()

@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UIButton *infoBtn;
@property (nonatomic, strong) UIImageView *arrow;

@end

@implementation HYUserBasicInfoCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
        [self setupSubviews];
        [self bind];
    }
    return self;
}

- (void)initialize {
    self.showBottomLine = YES;
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, cellModel.name) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.titleBtn setTitle:[NSString stringWithFormat:@"  %@", x] forState:UIControlStateNormal];
    }];
    
    [RACObserve(self, cellModel.info) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.infoBtn setTitle:self.cellModel.info forState:UIControlStateNormal];
    }];
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _titleBtn = [UIButton buttonWithTitle:nil
                               titleColor:[UIColor colorWithHexString:@"43484D"]
                                 fontSize:14
                            normalImgName:nil
                                  bgColor:nil
                                   inView:self.contentView
                                   action:NULL];
    _infoBtn = [UIButton buttonWithTitle:nil
                              titleColor:[UIColor blackColor]
                                fontSize:14
                           normalImgName:nil
                                 bgColor:nil
                                  inView:self.contentView
                                  action:NULL];
    _infoBtn.userInteractionEnabled = NO;
    
    _arrow = [UIImageView imageViewWithImageName:@"cellarrow" inView:self.contentView];
    
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(15);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(_arrow.image.size);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_arrow.mas_left).offset(-10);
    }];
}
@end
