//
//  WDReasonSelectedView.m
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDReasonSelectedView.h"

@interface WDReasonSelectedView ()

@property (nonatomic, strong) UILabel       *reasonLabel;

@property (nonatomic, strong) UIImageView   *reasonImageView;

@end

@implementation WDReasonSelectedView

- (instancetype)init {
    if (self=[super init]) {
        self.reason = @"";
        self.isSelected = NO;
        
        [self setupSubviews];
        [self setupSubviewsLayout];
        [self bindViewModel];
    }
    return self;
}
#pragma mark - Bind 
- (void)bindViewModel {
    //
    RAC(self.reasonLabel, text) = [RACObserve(self, reason) distinctUntilChanged];
    
    @weakify(self);
    //
    [[RACObserve(self, isSelected) distinctUntilChanged] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        self.reasonImageView.image = [x boolValue] ? [UIImage imageNamed:@"sel_单选选中"] : [UIImage imageNamed:@"sel_单选未选中"];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        [self reasonSelectedAction];
    }];

}

#pragma mark - Action
- (void)reasonSelectedAction {
    if (self.isSelected) return;
    
    self.isSelected = !self.isSelected;
    if (self.selectedBlock) {
        self.selectedBlock(self.isSelected);
    }
}


#pragma mark - Setup Subview
- (void)setupSubviews {
    //
    self.reasonImageView = [UIImageView imageViewWithImageName:nil
                                                        inView:self];
    
    //
    self.reasonLabel =  [UILabel labelWithText:nil
                                     textColor:[UIColor tc31Color]
                                      fontSize:16.0
                                        inView:self
                                     tapAction:nil];
    self.reasonLabel.numberOfLines = 0;
    self.reasonLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setupSubviewsLayout {
    //
    [self.reasonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(2);
        make.size.mas_equalTo(CGSizeMake(20.0, 20.0));
    }];
    
    //
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reasonImageView.mas_right).offset(10);
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.bottom.equalTo(self).offset(-2);
    }];
}


@end
