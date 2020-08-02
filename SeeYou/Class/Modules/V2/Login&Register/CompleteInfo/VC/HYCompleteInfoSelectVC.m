//
//  HYCompleteInfoSelectVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/18.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYCompleteInfoSelectVC.h"
#import "CPPickerView.h"
#import "HYPickerViewData.h"

@interface HYCompleteInfoSelectVC ()

@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation HYCompleteInfoSelectVC

+ (void)load {
    [self mapName:kModuleCompleteInfoSelect withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self bind];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputView becomeFirstResponder];
    });
}


#pragma mark - Action

- (void)showPickerView {
    CPPickerViewType type = CPPickerViewTypeSingle;
    NSArray *dataArray = nil;
    switch (self.selectType) {
        case HYCompleteInfoSelectTypeBirthday: {
            type = CPPickerViewTypeDate;
            break;
        }
        case HYCompleteInfoSelectTypeLocation: {
            type = CPPickerViewTypeTriple;
            dataArray = [HYPickerViewData shareData].places;
            break;
        }
        case HYCompleteInfoSelectTypeIncome: {
            type = CPPickerViewTypeSingle;
            dataArray = [HYPickerViewData shareData].salary;
            break;
        }
        default:
            break;
    }
    
    // 显示选择器
    CPPickerView *pickerView = [CPPickerView pickerViewWithType:type];
    @weakify(self);
    [pickerView showPickerViewWithDataArray:dataArray sureHandle:^(NSArray *values) {
        CPPickerViewModel *m = values.firstObject;
        
        NSMutableString *strM = [NSMutableString stringWithString:m.name];
        for (int i = 1; i < values.count; i++) {
            CPPickerViewModel *temp_m = values[i];
            [strM appendString:[NSString stringWithFormat:@" %@", temp_m.name]];
        }
        
        @strongify(self);
            switch (self.selectType) {
                case HYCompleteInfoSelectTypeBirthday: {
                    self.viewModel.birthday = strM;
                    break;
                }
                case HYCompleteInfoSelectTypeLocation: {
                    self.viewModel.workareaCode = [(CPPickerViewModel *)[values lastObject] mid];
                    break;
                }
                case HYCompleteInfoSelectTypeIncome: {
                    self.viewModel.salary = strM;
                    break;
                }
            }
    
            [self.chooseBtn setTitle:strM forState:UIControlStateNormal];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (self.selectType < HYCompleteInfoSelectTypeIncome) {
//                    NSDictionary *params = @{
//                                             @"viewModel": self.viewModel,
//                                             @"selectType": @(self.selectType + 1)
//                                             };
//                    [YSMediator pushToViewController:kModuleCompleteInfoSelect
//                                          withParams:params
//                                            animated:YES
//                                            callBack:NULL];
//                }
//                else {
//                    [self updateInfo];
//                }
//
//            });
    }];
}


- (void)updateInfo {
    [self.viewModel.saveInfoCmd execute:nil];
}


#pragma mark - Bind

- (void)bind {
    if (self.selectType != HYCompleteInfoSelectTypeIncome) return;
    
    [[self.viewModel.saveInfoCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [YSMediator pushToViewController:kModuleCompleteInfoAvatar
                              withParams:nil
                                animated:YES
                                callBack:NULL];
    }];
    
    [[[self.viewModel.saveInfoCmd executing] skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            [WDProgressHUD showIndeterminate];;
        }
    }];
    
    [self.viewModel.saveInfoCmd.errors subscribeNext:^(NSError * _Nullable x) {
        if (x) [WDProgressHUD showTips:x.localizedDescription];
    }];
}


#pragma mark - Initialize

- (void)initialize {
    switch (self.selectType) {
        case HYCompleteInfoSelectTypeBirthday: {
            self.titleLabel.text = @"完善资料";
            self.stepLabel.text = @"(3/5)";
            self.infoLabel.text = @"请选择您的生日";
            self.descLabel.text = @"我们给你准备了生日惊喜";
            break;
        }
        case HYCompleteInfoSelectTypeLocation: {
            self.titleLabel.text = @"完善资料";
            self.stepLabel.text = @"(4/5)";
            self.infoLabel.text = @"请选择您的所在区域";
            self.descLabel.text = @"给您精准推荐附近的异性";
            break;
        }
        case HYCompleteInfoSelectTypeIncome: {
            self.titleLabel.text = @"完善资料";
            self.stepLabel.text = @"(5/5)";
            self.infoLabel.text = @"请选择您的月收入范围";
            self.descLabel.text = @"好的生活也是需要物质保障的呢";
            break;
        }
        default:
            break;
    }
    
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    [super setupSubviews];
    
    _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseBtn.adjustsImageWhenHighlighted = NO;
    [_chooseBtn addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchDown];
    [_chooseBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _chooseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_chooseBtn];
    
    @weakify(self);
    _nextBtn = [UIButton buttonWithTitle:@"下一步"
                              titleColor:[UIColor colorWithHexString:@"#FF5D9C"]
                                fontSize:16
                                 bgColor:[UIColor whiteColor]
                                  inView:self.view
                                  action:^(UIButton *btn) {
                                      @strongify(self);
                                      [self go2NextStep];
                                  }];
    _nextBtn.clipsToBounds = YES;
    _nextBtn.layer.cornerRadius = 45 * 0.5;
}

- (void)go2NextStep {
    if (self.selectType < HYCompleteInfoSelectTypeIncome) {
        NSDictionary *params = @{
                                 @"viewModel": self.viewModel,
                                 @"selectType": @(self.selectType + 1)
                                 };
        [YSMediator pushToViewController:kModuleCompleteInfoSelect
                              withParams:params
                                animated:YES
                                callBack:NULL];
    }
    else {
        [self updateInfo];
    }
}

- (void)setupSubviewsLayout {
    [super setupSubviewsLayout];
    
    CGFloat padding = 30;
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(25);
    }];
    
    UIImageView *arrow = [UIImageView imageViewWithImageName:@"icon_login_btn_arrow" inView:self.view];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(arrow.image.size);
        make.centerY.equalTo(_chooseBtn);
        make.left.equalTo(_chooseBtn.mas_right).offset(10);
    }];
    
    
    UIView *line = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chooseBtn.mas_bottom).offset(15);
        make.left.offset(padding);
        make.right.offset(-padding);
        make.height.mas_equalTo(0.5);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50);
        make.left.offset(padding);
        make.right.offset(-padding);
        make.height.mas_equalTo(45);
    }];
}

@end
