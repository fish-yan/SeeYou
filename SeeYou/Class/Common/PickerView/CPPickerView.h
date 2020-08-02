//
//  CPPickerView.h
//  CPPatient
//
//  Created by Joseph Koh on 2017/9/8.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPPickerViewModel.h"

typedef NS_ENUM(NSInteger, CPPickerViewType) {
    CPPickerViewTypeSingle = 1,
    CPPickerViewTypeDouble,
    CPPickerViewTypeTriple,
    CPPickerViewTypeDate,
};

@interface CPPickerView : UIView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) void(^sureHander)(NSArray *m);
@property (nonatomic, copy) NSString *tips;

/// DatePicker显示时间,
@property (nonatomic, strong) NSDate *displayDate;
/// DatePicker限制的最小时间
@property (nonatomic, strong) NSDate *minimumDate;
/// DatePicker限制的最大时间
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, assign) BOOL mutilComponentSameData;
@property (nonatomic, assign) BOOL showTime;

+ (instancetype)pickerViewWithType:(CPPickerViewType)type;

- (void)showPickerViewWithDataArray:(NSArray *)dataArray
                         sureHandle:(void(^)(NSArray *m))sureHander;

- (void)showPickerView;
/// 点击后要显示选中的内容, 如果是日期用 yyyy-MM-dd 格式
- (void)selectRowByDisplayName:(NSString *)name;

@end
