//
//  CPPickerView.m
//  CPPatient
//
//  Created by Joseph Koh on 2017/9/8.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "CPPickerView.h"

#define PICKER_VIEW_HEIGHT 230
#define PICKER_VIEW_ANIM_DURATION 0.2
#define PICKER_VIEW_DATE_FORMATER(b) (b ? @"yyyy-MM-dd HH:mm" : @"yyyy-MM-dd")

@interface CPPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *pickerContentView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *pickerBgView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *conformBtn;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, assign) CPPickerViewType type;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) CPPickerViewModel *sel_m_0;
@property (nonatomic, strong) CPPickerViewModel *sel_m_1;
@property (nonatomic, strong) CPPickerViewModel *sel_m_2;

@property (nonatomic, strong) NSMutableArray *selInfo;

@end

@implementation CPPickerView

+ (instancetype)pickerViewWithType:(CPPickerViewType)type {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CPPickerView *pickerView = [[CPPickerView alloc] initWithFrame:keyWindow.bounds];
  
    pickerView.type = type;
    [pickerView setupSubvews];
    
    return pickerView;
}

- (void)showPickerViewWithDataArray:(NSArray *)dataArray
                         sureHandle:(void(^)(NSArray *m))sureHander {
    self.dataArray = dataArray;
    self.sureHander = sureHander;
    
    [self showPickerView];
    
    if (_type != CPPickerViewTypeDate) {
        for (int i = 0; i < _type; i++) {
            [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
        }
    }

}

- (void)setupSubvews {
    _pickerContentView = [UIView viewWithBackgroundColor:[UIColor clearColor] inView:self];
    _pickerContentView.frame = self.bounds;
    
    [self addMaskView];
    [self addPickerBgView];
    self.pickerBgView.y = SCREEN_HEIGHT;
}


#pragma mark - Action

- (void)showPickerView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:PICKER_VIEW_ANIM_DURATION animations:^{
        self.maskView.alpha = 1.0;
        self.pickerBgView.y = SCREEN_HEIGHT - PICKER_VIEW_HEIGHT;
    }];
}

- (void)hiddenPickerView {
    [UIView animateWithDuration:PICKER_VIEW_ANIM_DURATION animations:^{
        self.maskView.alpha = 0.0;
        self.pickerBgView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)selectRowByDisplayName:(NSString *)name {
    if (self.type == CPPickerViewTypeDate) {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = PICKER_VIEW_DATE_FORMATER(self.showTime);
        NSDate *date = [formater dateFromString:name];
        self.displayDate = date;
    }
    else {
        for (int i = 0 ; i < _dataArray.count; i++) {
            @autoreleasepool {
                id m = _dataArray[i];
                if ([[m name] isEqualToString:name]) {
                    [_pickerView selectRow:i inComponent:0 animated:YES];
                    return;
                }
            }
        }
    }
}

- (void)setTips:(NSString *)tips {
    _tips = tips;
    _tipsLabel.text = tips;
}


#pragma mark - PickerView Datasource && delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.type;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.mutilComponentSameData) {
        return _dataArray.count;
    }
    
    switch (self.type) {
        case CPPickerViewTypeSingle: {
            return _dataArray.count;
        }
        case CPPickerViewTypeDouble: {
            if (0 == component) {
                return _dataArray.count;
            }
            else if (1 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                CPPickerViewModel *m = _dataArray[sel_0];
                return m.subArr.count;
            }
            break;
        }
        case CPPickerViewTypeTriple: {
            if (0 == component) {
                return _dataArray.count;
            }
            else if (1 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                CPPickerViewModel *m_0 = _dataArray[sel_0];
                return m_0.subArr.count;
            }
            else if (2 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                NSInteger sel_1 = [pickerView selectedRowInComponent:1];
                CPPickerViewModel *m_0 = _dataArray[sel_0];
                CPPickerViewModel *m_1 = m_0.subArr[sel_1];
                return m_1.subArr.count;
            }
            break;
        }
        default:
            break;
    }
    return _dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    CGFloat height = [self pickerView:pickerView rowHeightForComponent:component];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,height)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *tl = [[UILabel alloc] init];
    tl.font = [UIFont systemFontOfSize:18];
    tl.frame = CGRectMake(0, 0, pickerView.width, height);
    tl.textAlignment = NSTextAlignmentCenter;
    tl.backgroundColor = [UIColor clearColor];
    [view addSubview:tl];
    
    if (self.mutilComponentSameData) {
        CPPickerViewModel *m_0 = _dataArray[row];
        tl.text = m_0.name;
        return view;
    }
    
    switch (self.type) {
        case CPPickerViewTypeSingle: {
            CPPickerViewModel *m_0 = _dataArray[row];
            tl.text = m_0.name;
            break;
        }
        case CPPickerViewTypeDouble: {
            if (0 == component) {
                CPPickerViewModel *m_0 = _dataArray[row];
                tl.text = m_0.name;
            }
            else if (1 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                CPPickerViewModel *m_0 = _dataArray[sel_0];
                CPPickerViewModel *m_1 = m_0.subArr[row];
                tl.text = m_1.name;
            }
            break;
        }
        case CPPickerViewTypeTriple: {
            if (0 == component) {
                CPPickerViewModel *m_0 = _dataArray[row];
                tl.text = m_0.name;
            }
            else if (1 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                CPPickerViewModel *m_0 = _dataArray[sel_0];
                CPPickerViewModel *m_1 = m_0.subArr[row];
                tl.text = m_1.name;
            }
            else if (2 == component) {
                NSInteger sel_0 = [pickerView selectedRowInComponent:0];
                NSInteger sel_1 = [pickerView selectedRowInComponent:1];
                CPPickerViewModel *m_0 = _dataArray[sel_0];
                CPPickerViewModel *m_1 = m_0.subArr[sel_1];
                CPPickerViewModel *m_2 = m_1.subArr[row];
                tl.text = m_2.name;
            }
            break;
        }
        default:
            break;
    }
    
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.mutilComponentSameData) {
        self.sel_m_0 = _dataArray[row];
        [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_0];
        return;
    }
    
    switch (self.type) {
        case CPPickerViewTypeSingle: {
            self.sel_m_0 = _dataArray[row];
            [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_0];
            break;
        }
        case CPPickerViewTypeDouble: {
            if (0 == component) {
                [pickerView reloadComponent:1];
                
                self.sel_m_0 = _dataArray[row];
                [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_0];

                self.sel_m_1 = self.sel_m_0.subArr[0];
                [self.selInfo replaceObjectAtIndex:1 withObject:self.sel_m_1];
            }
            else if (1 == component) {
                self.sel_m_1 = self.sel_m_0.subArr[row];
                [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_1];
            }
            break;
        }
        case CPPickerViewTypeTriple: {
            if (0 == component) {
                [pickerView reloadComponent:1];
                [pickerView reloadComponent:2];
                
                self.sel_m_0 = _dataArray[row];
                [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_0];
                
                self.sel_m_1 = self.sel_m_0.subArr[0];
                [self.selInfo replaceObjectAtIndex:1 withObject:self.sel_m_1];
                
                self.sel_m_2 = self.sel_m_1.subArr[0];
                [self.selInfo replaceObjectAtIndex:2 withObject:self.sel_m_2];
            }
            else if (1 == component) {
                [pickerView reloadComponent:2];
                
                self.sel_m_1 = self.sel_m_0.subArr[row];
                [self.selInfo replaceObjectAtIndex:component withObject:self.sel_m_1];
                
                self.sel_m_2 = self.sel_m_1.subArr[0];
                [self.selInfo replaceObjectAtIndex:2 withObject:self.sel_m_2];
            }
            else if (2 == component) {
                self.sel_m_2 = self.sel_m_1.subArr[row];
                [self.selInfo replaceObjectAtIndex:2 withObject:self.sel_m_2];

            }
            break;
        }
        default:
            break;
    }
}

- (BOOL)anySubViewScrolling:(UIView *)view {
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    
    return NO;
}



#pragma mark - Lazy Loading

- (UIView *)pickerContentView {
    if (!_pickerContentView) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _pickerContentView = [UIView viewWithBackgroundColor:[UIColor clearColor] inView:keyWindow];
        _pickerContentView.frame = keyWindow.bounds;
        
        [self addMaskView];
    }
    return _pickerContentView;
}

- (void)addPickerBgView {
    _pickerBgView = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:_pickerContentView];
    _pickerBgView.frame = CGRectMake(0,
                                     _pickerContentView.height - PICKER_VIEW_HEIGHT,
                                     _pickerContentView.width,
                                     PICKER_VIEW_HEIGHT);
    
    @weakify(self);
    _cancleBtn = [UIButton buttonWithTitle:@"取消"
                                titleColor:[UIColor lightGrayColor]
                                  fontSize:18
                                   bgColor:nil
                                    inView:_pickerBgView
                                    action:^(UIButton *btn) {
                                        @strongify(self);
                                        [self hiddenPickerView];
                                    }];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    
    
    _conformBtn = [UIButton buttonWithTitle:@"确定"
                                 titleColor:[UIColor blackColor]
                                   fontSize:18
                                    bgColor:nil
                                     inView:_pickerBgView
                                     action:^(UIButton *btn) {
                                         @strongify(self);
                                         
                                         if (self.sureHander) {
                                             NSArray *values = nil;
                                             switch (self.type) {
                                                 case CPPickerViewTypeSingle:
                                                 case CPPickerViewTypeDouble:
                                                 case CPPickerViewTypeTriple: {
                                                     values = self.selInfo.copy;
                                                     break;
                                                 }
                                                 case CPPickerViewTypeDate: {
                                                     NSDate *date = [self.datePicker date];
                                                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                     formatter.dateFormat = PICKER_VIEW_DATE_FORMATER(self.showTime);
                                                     NSString *time = [formatter stringFromDate:date];
                                                    
                                                     CPPickerViewModel *model = [CPPickerViewModel new];
                                                     model.name = time;
                                                     values = @[model];
                                                     break;
                                                 }
                                                 default:
                                                     break;
                                             }
                                             self.sureHander(values);
                                         }
                                         
                                         [self hiddenPickerView];
                                     }];
    [_conformBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_cancleBtn);
    }];
    
    
    _tipsLabel = [UILabel labelWithText:@""
                              textColor:[UIColor grayColor]
                          textAlignment:NSTextAlignmentCenter
                               fontSize:16
                                 inView:_pickerBgView
                              tapAction:NULL];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(55);
        make.centerY.equalTo(_cancleBtn);
        make.right.offset(-55);
    }];
    
    
    [self addPickerView];
}

- (void)addMaskView {
    @weakify(self);
    _maskView = [UIView viewWithBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]
                                         inView:_pickerContentView
                                      tapAction:^(UIView *view, UIGestureRecognizer *tap) {
                                          @strongify(self);
                                          [self hiddenPickerView];
                                      }];
    _maskView.frame = _pickerContentView.bounds;
    _maskView.alpha = 0.0;
}

- (void)addPickerView {
    switch (self.type) {
        case CPPickerViewTypeSingle:
        case CPPickerViewTypeDouble:
        case CPPickerViewTypeTriple: {
            _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 58, SCREEN_WIDTH, 120)];
            _pickerView.dataSource = self;
            _pickerView.delegate = self;
            [_pickerBgView addSubview:_pickerView];
            break;
        }
        case CPPickerViewTypeDate: {
            _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 58, SCREEN_WIDTH, 120)];
            _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
//            _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
            [self.datePicker setCalendar:[NSCalendar currentCalendar]];
            _datePicker.datePickerMode = UIDatePickerModeDate;
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, SCREEN_WIDTH, 37)];
            colorView.backgroundColor = [UIColor whiteColor];
            colorView.alpha = 0.8f;
            colorView.center = _datePicker.center;
            [_pickerBgView addSubview:colorView];
            [_pickerBgView addSubview:_datePicker];
            break;
        }
        default:
            break;
    }

}

#pragma mark - Setter

- (void)setShowTime:(BOOL)showTime {
    _showTime = showTime;
    
    _datePicker.datePickerMode = showTime? UIDatePickerModeDateAndTime : UIDatePickerModeDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    _datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    _datePicker.maximumDate = maximumDate;
}

- (void)setDisplayDate:(NSDate *)displayDate {
    _displayDate = displayDate;

    if (self.type == CPPickerViewTypeDate) {
        _datePicker.date = displayDate ?: [NSDate mt_dateFromISOString:@"1990-01-01"];
    }
}

- (NSMutableArray *)selInfo {
    if (!_selInfo) {
        _selInfo = [NSMutableArray array];
        for (int i = 1; i <= self.type; i++) {
            [_selInfo addObject:[NSNull null]];
        }
    }
    return _selInfo;
}
@end
