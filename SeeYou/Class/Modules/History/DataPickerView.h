//
//  DataPickerView.h
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Color.h"
#import "HYAreaDataInstance.h"


typedef NS_ENUM(NSUInteger, DataPickerEditType) {
    DataPickerEditTypeWorkPlace=0,       //工作地
    DataPickerEditTypeHomePlace,         //家乡
    DataPickerEditBirthDay,              //出生日期
    DataPickerEditTypeHeight,            //身高
    DataPickerEditTypeSchoolLevel,       //学历
    DataPickerEditTypePerfession ,       //职业
    DataPickerEditTypeSalary,            //收入
    DataPickerEditTypeConstellation,       //星座
    DataPickerEditTypeMarrayTime,          //期望结婚时间
    DataPickerEditTypeMarratStatus,        //婚姻状态
    DataPickerEditTypeBefreindAgeFanwei ,  //交友年龄范围
    DataPickerEditTypeBefreindHeightFanwei,  //交友升高范围
    DataPickerEditTypeSex  //交友升高范围
    
};

@interface DataPickerView : UIView

- (instancetype)initWithSelType:(DataPickerEditType)editType;
- (void)loadData; //刷新数据源
- (void)show;

@property (nonatomic, copy) dispatch_block_t saveBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, assign) NSInteger selIndex;
@property (nonatomic, strong) NSArray  *dataArray;


@property (nonatomic, strong) NSArray  *monthArray;//年龄时才用到的月份
@property (nonatomic, assign) NSInteger selMonthIndex;
@property (nonatomic ,strong) NSArray *dayArray;//日
@property (nonatomic, assign) NSInteger selDayIndex;

@property (strong, nonatomic) NSArray *areaArray;//服务器获取数据
@property (nonatomic, strong) AreaDataModel *provinceModel;
@property (nonatomic, strong) AreaDataModel *cityModel;
@property (nonatomic, strong) AreaDataModel *distictModel;

@property (nonatomic, copy) NSString *yearStr;
@property (nonatomic, copy) NSString *monthStr;
@property (nonatomic, copy) NSString *dayStr;

//自设定value
@property (nonatomic, assign) int givenValueMin;
@property (nonatomic, assign) int givenValueMax;



@end
