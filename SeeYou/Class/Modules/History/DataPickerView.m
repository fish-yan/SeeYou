//
//  DataPickerView.m
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "DataPickerView.h"
#import "NSDate+YN.h"
#import "HYAreaDataInstance.h"
#define minHeight 150
#define maxHeight 200

#define minWeight 20
#define maxWeight 151

#define minWaist  50
#define maxWaist  151


@interface DataPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView    *dataPicker;
    NSString        *unitStr;       //单位
    DataPickerEditType selType;
    CGFloat         kViewWidth;
    CGFloat         kViewHeight;
}

@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, strong) UIView *editSelView;

@end
@implementation DataPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.givenValueMin =150;
        self.givenValueMax=199;
    }
    return self;
}


- (instancetype)initWithSelType:(DataPickerEditType)editType {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        selType = editType;
        
        UITapGestureRecognizer *tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapped];
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
    }
    return self;
}


- (void)loadData {
    //Picker的数组
    
    self.monthArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    self.dataArray = [NSArray arrayWithArray: [self loadPickerData]];
    
    
    
    if (selType == DataPickerEditTypeBefreindAgeFanwei)
    {
        
        NSMutableArray * array  =[NSMutableArray new];
        NSMutableArray * array1  =[NSMutableArray new];
//        NSInteger s =[[NSDate date] getYear];
//        NSInteger begin = s-47;
//        NSInteger last = s-17;
        for (int i=18; i<=80 ; i++) {

            [array addObject:[NSString stringWithFormat:@"%d",i]];
            [array1 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        unitStr = @"岁";
        
        self.dataArray = [array copy];
        self.monthArray = [array1 copy];
        
        
        
        
    }
    else if(selType == DataPickerEditTypeBefreindHeightFanwei)
    {
        NSMutableArray * array  =[NSMutableArray new];
        NSMutableArray * array1  =[NSMutableArray new];
        for (int i = minHeight; i<maxHeight; i++) {
            [array addObject: [NSString stringWithFormat: @"%d", i]];
            [array1 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        unitStr = @"cm";
        
        self.dataArray = [array copy];
        self.monthArray = [array1 copy];
        
    }
  
    
    //Picker的顶端View
    UIView *topView = [self setupTopView];
    //PickerView
    dataPicker = [self setupPickerView];
    CGRect pickerFrame = dataPicker.frame;
    
    kViewWidth  = SCREEN_WIDTH;
    kViewHeight = topView.frame.size.height + dataPicker.frame.size.height;
    
    UIView *selView = [[UIView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kViewHeight)];
    [selView setBackgroundColor: [UIColor clearColor]];
    self.editSelView = selView;
    
    [selView addSubview: topView];
    pickerFrame.origin.x = 0;
    pickerFrame.origin.y = topView.frame.size.height;
    [dataPicker setFrame: pickerFrame];
    [selView addSubview: dataPicker];
    
    [self addSubview: selView];
    
    
    
    
    
    if(selType ==DataPickerEditBirthDay)
    {
        if(self.selIndex ==-1 || self.selMonthIndex ==-1 || self.selDayIndex==-1)
        {
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy";
            NSInteger year = [[formatter stringFromDate:[NSDate date]] intValue]-17;
            formatter.dateFormat = @"MM";
            NSInteger month = [[formatter stringFromDate:[NSDate date]] intValue];
            formatter.dateFormat = @"dd";
            NSInteger day = [[formatter stringFromDate:[NSDate date]] intValue];
            
            if(self.yearStr ==nil)
            {
                self.selIndex = [self.dataArray indexOfObject:[NSString stringWithFormat:@"%ld" ,(long)year ]];
                
            }
            if(self.monthStr ==nil)
            {
                self.selMonthIndex =[self.monthArray indexOfObject:[NSString stringWithFormat:@"%ld" ,(long)month ]];
            }
            if(self.dayStr ==nil)
            {
                
                self.selDayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%ld" ,(long)day ]];
            }
        }
    
    }
    else if (selType == DataPickerEditTypeBefreindAgeFanwei)
    {
    
    }
    else if(selType == DataPickerEditTypeBefreindHeightFanwei)
    {
    
    }
    
}


#pragma mark - 加载顶部显示、保存、取消的界面
- (UIView *)setupTopView {
    UIView *topView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 44.0)];
    [topView setBackgroundColor: [UIColor whiteColor]];
    //保存按钮
    UIButton *save = [UIButton buttonWithType: UIButtonTypeCustom];
    [save setTitleColor: [UIColor tc31Color] forState: UIControlStateNormal];
    [save setTitle: @"确定" forState: UIControlStateNormal];
    [save.titleLabel setFont: Font_PINGFANG_SC(16)];
    [save setFrame: CGRectMake(topView.frame.size.width - 60, 0, 60, topView.frame.size.height)];
    [save addTarget: self action: @selector(saveAction:) forControlEvents: UIControlEventTouchUpInside];
    [topView addSubview: save];
    
    
    //取消按钮
    UIButton *cancel = [UIButton buttonWithType: UIButtonTypeCustom];
    [cancel setTitleColor: [UIColor tc31Color] forState: UIControlStateNormal];
    [cancel setTitle: @"取消" forState: UIControlStateNormal];
    [cancel.titleLabel setFont: Font_PINGFANG_SC(16)];
    [cancel setFrame: CGRectMake(0, 0, 60, topView.frame.size.height)];
    [cancel addTarget: self action: @selector(cancelAction:) forControlEvents: UIControlEventTouchUpInside];
    [topView addSubview: cancel];

    UIView *topLine = [[UIView alloc] initWithFrame: CGRectMake(0, 0.5, topView.frame.size.width, 0.5)];
    [topLine setBackgroundColor: [UIColor line0Color]];
    [topView addSubview: topLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame: CGRectMake(0, topView.frame.size.height-0.5, topView.frame.size.width, 0.5)];
    [bottomLine setBackgroundColor: [UIColor line0Color]];
    [topView addSubview: bottomLine];
    
    return topView;
}


#pragma mark - 加载PickerView
- (UIPickerView *)setupPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, pickerView.frame.size.height)];
    [pickerView setBackgroundColor: [UIColor whiteColor]];
    
    pickerView.delegate   = self;
    pickerView.dataSource = self;
    
    return pickerView;
}


#pragma mark - 加载选择数组
- (NSArray *)loadPickerData {
    self.selIndex = -1;
    self.selMonthIndex = -1;
    self.selDayIndex = -1;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    if(selType == DataPickerEditTypeHomePlace || selType ==DataPickerEditTypeWorkPlace)
    {
    
        self.dataArray = [HYAreaDataInstance shareInstance].proviceArray;
        AreaDataModel * model = [self.dataArray objectAtIndex:0];
        self.monthArray = [[HYAreaDataInstance shareInstance] getDistritData:[model.iD intValue]];
        model = [self.monthArray objectAtIndex:0];
        self.dayArray =[[HYAreaDataInstance shareInstance] getAreaData:[model.iD intValue]];
        
        unitStr = @"";
        array = [self.dataArray mutableCopy];
        
    }
    else if(selType ==DataPickerEditTypeBefreindAgeFanwei)
    {
    }
    else if(selType == DataPickerEditTypeBefreindHeightFanwei)
    {
        
        
    
    }
     else if (selType == DataPickerEditTypeHeight) {
        if (self.givenValueMax!=0 && self.givenValueMin!=0) {
            //身高
            for (int i = _givenValueMin; i<=_givenValueMax; i++) {
                [array addObject: [NSString stringWithFormat: @"%i", i]];
            }
            unitStr = @"cm";
        }else{
            //身高
            for (int i = minHeight; i<maxHeight; i++) {
                [array addObject: [NSString stringWithFormat: @"%d", i]];
            }
            unitStr = @"cm";
            
        }
        
    }
    else if(selType ==DataPickerEditBirthDay)
    {
        NSInteger s =[[NSDate date] getYear];
        NSInteger begin = s-47;
        NSInteger last = s-17;
        for (int i=(int)begin; i<=last ; i++) {
            
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        unitStr = @"年";
        
    }
    else if (selType == DataPickerEditTypeSchoolLevel) {
       {
           [array addObject:@"小学"];
           [array addObject:@"高中"];
           [array addObject:@"中专"];
           [array addObject:@"本科"];
           [array addObject:@"研究生"];
           [array addObject:@"MBA"];
           [array addObject:@"博士"];
           [array addObject:@"博士后"];
        }
        unitStr = @"";
    }
    else if (selType == DataPickerEditTypeSalary) {
        [array addObject:@"2k以下"];
        [array addObject:@"2k-5k"];
        [array addObject:@"5k-10k"];
        [array addObject:@"10k-15k"];
        [array addObject:@"15k-25k"];
        [array addObject:@"25k-50k"];
        [array addObject:@"50k-100k"];
        [array addObject:@"100k以上"];
        unitStr = @"";
        
    }
    else if (selType == DataPickerEditTypeConstellation) {
        
        [array addObject:@"白羊座"];
        [array addObject:@"金牛座"];
        [array addObject:@"双子座"];
        [array addObject:@"巨蟹座"];
        [array addObject:@"狮子座"];
        [array addObject:@"处女座"];
        [array addObject:@"天秤座"];
        [array addObject:@"天蝎座"];
        [array addObject:@"射手座"];
        [array addObject:@"魔蝎座"];
        [array addObject:@"水瓶座"];
        [array addObject:@"双鱼座"];
        
        unitStr = @"";
    }else if (selType == DataPickerEditTypeMarrayTime) {
        
        [array addObject:@"期望一年内结婚"];
        [array addObject:@"期望二年内结婚"];
        [array addObject:@"期望三年内结婚"];
        [array addObject:@"期望四年内结婚"];
        [array addObject:@"期望五年内结婚"];
        [array addObject:@"时机合适就结婚"];
        [array addObject:@"对的人马上结婚"];
        unitStr = @"";
    }
    else  if(selType == DataPickerEditTypeMarratStatus)
    {
        [array addObject:@"未婚"];
        [array addObject:@"已婚"];
        [array addObject:@"离异"];
        [array addObject:@"丧偶"];
        [array addObject:@"保密"];
        unitStr = @"";
    }
    else if (selType == DataPickerEditTypeSex)
    {
        [array addObject:@"男"];
        [array addObject:@"女"];
        unitStr=@"";
    }
    return array;
}



-(void)setSelIndex:(NSInteger)selIndex {
    _selIndex = selIndex;
    [dataPicker selectRow: _selIndex inComponent: 0 animated: YES];
  
    
    if(selType == DataPickerEditTypeHomePlace || selType == DataPickerEditTypeWorkPlace)
    {
        if(_selIndex<0)
        {
            _selIndex=0;
        }
        AreaDataModel *model = [[HYAreaDataInstance shareInstance].proviceArray objectAtIndex:self.selIndex];
        self.monthArray = [[HYAreaDataInstance shareInstance] getDistritData:[model.iD intValue]];
        
        [dataPicker reloadComponent:1];
        if(self.selMonthIndex > self.monthArray.count-1)
        {
            self.selMonthIndex =self.monthArray.count-1;
            [dataPicker selectRow: self.monthArray.count-1 inComponent: 1 animated: YES];
        }
        
        if(self.monthArray.count==0)
        {
            return;
        }
        if(self.selDayIndex<0)
        {
            self.selMonthIndex=0;
        }
        model = [self.monthArray objectAtIndex:self.selMonthIndex];
        self.dayArray = [[HYAreaDataInstance shareInstance] getDistritData:[model.iD intValue]];
        
        [dataPicker reloadComponent:2];
//        if(self.selDayIndex > self.dayArray.count-1)
//        {
            self.selDayIndex =0;
            [dataPicker selectRow:0 inComponent: 2 animated: YES];
//        }
      
    }
    else if (selType == DataPickerEditTypeBefreindAgeFanwei|| selType == DataPickerEditTypeBefreindHeightFanwei)
    {
    
         [dataPicker selectRow: self.selIndex inComponent: 0 animated: YES];
    }
    else
    {
        if(_selMonthIndex ==-1 || self.selIndex ==-1)
        {
            return;
        }
        
        [self getDay:[[self.dataArray objectAtIndex:self.selIndex] intValue] month:[[self.monthArray objectAtIndex:self.selMonthIndex] intValue]];
         self.yearStr =[self.dataArray objectAtIndex:selIndex];
    }
}

-(void)setSelMonthIndex:(NSInteger)selMonthIndex {
    _selMonthIndex = selMonthIndex;
    if (selType == DataPickerEditBirthDay) {
        [dataPicker selectRow: _selMonthIndex inComponent: 1 animated: YES];
        if(_selMonthIndex ==-1 || self.selIndex ==-1)
        {
            return;
        }
        self.monthStr =[self.monthArray objectAtIndex:selMonthIndex];
                   
        [self getDay:[[self.dataArray objectAtIndex:self.selIndex] intValue] month:[[self.monthArray objectAtIndex:selMonthIndex] intValue]];
    }
    else if (selType == DataPickerEditTypeBefreindAgeFanwei|| selType == DataPickerEditTypeBefreindHeightFanwei)
    {
        
       
        [dataPicker selectRow: selMonthIndex inComponent: 1 animated: YES];
    }
    else if(selType == DataPickerEditTypeWorkPlace || selType ==DataPickerEditTypeHomePlace)
    {
        [dataPicker selectRow: _selMonthIndex inComponent: 1 animated: YES];
        if(_selMonthIndex ==-1)
        {
            _selMonthIndex =0;
           
        }
         _selDayIndex =0;
        
        AreaDataModel *model = [self.monthArray objectAtIndex:self.selMonthIndex];
        self.dayArray = [[HYAreaDataInstance shareInstance] getDistritData:[model.iD intValue]];
        [dataPicker reloadComponent:2];
        if(self.selDayIndex > self.dayArray.count-1)
        {
            self.selDayIndex =0;
            [dataPicker selectRow: 0 inComponent: 2 animated: YES];
        }
        else
        {
            [dataPicker selectRow:self.selDayIndex inComponent: 2 animated: YES];
        }
        
        
    }
}
-(void)setSelDayIndex:(NSInteger)selDayIndex
{
    _selDayIndex = selDayIndex;
    if (selType == DataPickerEditBirthDay) {
        [dataPicker selectRow: _selDayIndex inComponent: 2 animated: YES];
        self.dayStr =[self.dayArray objectAtIndex:selDayIndex];
    }
    else if (selType ==DataPickerEditTypeHomePlace || selType ==DataPickerEditTypeWorkPlace)
    {
    
        [dataPicker selectRow: _selDayIndex inComponent: 2 animated: YES];
       
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if(selType == DataPickerEditTypeWorkPlace || selType == DataPickerEditTypeHomePlace)
    {
        return 3;
    }
    else if (selType == DataPickerEditBirthDay) {
        return 3;
    }
    else if (selType ==DataPickerEditTypeBefreindHeightFanwei || selType ==DataPickerEditTypeBefreindAgeFanwei)
    {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataArray.count;
    }
    else if (component ==1)
    {
        return self.monthArray.count;
    }
    else {
        return self.dayArray.count;
    }
}


#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    
    
    if(selType == DataPickerEditTypeWorkPlace || selType == DataPickerEditTypeHomePlace)
    {
        if (component == 0) {
            AreaDataModel *m = (AreaDataModel*)self.dataArray[row];
            return [NSString stringWithFormat: @"%@%@", m.name, unitStr];
        }
        else if(component ==1)
        {
            AreaDataModel *m = (AreaDataModel*)self.monthArray[row];
            return [NSString stringWithFormat: @"%@%@", m.name, unitStr];
        }
        else {
            AreaDataModel *m = (AreaDataModel*)self.dayArray[row];
            return [NSString stringWithFormat: @"%@%@", m.name, unitStr];
        }
    }
    
    else if (selType ==DataPickerEditBirthDay) {
        
        if (component == 0) {
            return [NSString stringWithFormat: @"%@%@", self.dataArray[row], unitStr];
        }
        else if(component ==1)
        {
            return [NSString stringWithFormat: @"%@月", self.monthArray[row]];
        }
        else {
            return [NSString stringWithFormat: @"%@日", self.dayArray[row]];
        }
    }
    else if (selType ==DataPickerEditTypeBefreindAgeFanwei || selType ==DataPickerEditTypeBefreindHeightFanwei)
    {
        if (component == 0)
        {
            return [NSString stringWithFormat: @"%@%@", self.dataArray[row], unitStr];
        }
        else if(component ==1)
        {
            return [NSString stringWithFormat: @"%@%@", self.monthArray[row],unitStr];
        }
    }
    else
    {
    
    }
    return [NSString stringWithFormat: @"%@%@", self.dataArray[row], unitStr];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(selType == DataPickerEditTypeHomePlace || selType ==DataPickerEditTypeWorkPlace)
    {
        if(component==0)
        {
            if(row <= self.dataArray.count-1)
            {
                AreaDataModel *m = (AreaDataModel*)self.dataArray[row];
                self.provinceModel = m;
                self.yearStr = [NSString stringWithFormat: @"%@%@", m.name, unitStr];
                self.selIndex = row;
                self.selIndex = row;
                [pickerView selectRow:row inComponent:0 animated:YES];
            }
        }
        else if (component == 1) {
            
            if(row <=self.monthArray.count-1)
            {
                AreaDataModel *m = (AreaDataModel*)self.monthArray[row];
                self.cityModel = m;
                self.monthStr = [NSString stringWithFormat: @"%@", ((AreaDataModel *)self.monthArray[row]).name];
                self.selMonthIndex = row;
                [pickerView selectRow:row inComponent:1 animated:YES];
            }
        }else {
            
            if(row <=self.dayArray.count-1)
            {
                AreaDataModel *m = (AreaDataModel*)self.dayArray[row];
                self.distictModel = m;
                self.dayStr = [NSString stringWithFormat: @"%@", m.name];
                self.selDayIndex = row;
                [pickerView selectRow:row inComponent:2 animated:YES];
            }
        }

    
    }
    else if (selType == DataPickerEditBirthDay) {
        
        if (component == 0) {
            self.yearStr = [NSString stringWithFormat: @"%@%@", self.dataArray[row], unitStr];
            self.selIndex = row;
        }
        else if(component ==1)
        {
            self.monthStr = [NSString stringWithFormat: @"%@月", self.monthArray[row]];
            self.selMonthIndex = row;
        }
        else {
            self.dayStr = [NSString stringWithFormat: @"%@日", self.dayArray[row]];
            self.selDayIndex = row;
        }
        if(component==0)
        {
            if(row <= self.dataArray.count-1)
            {
                self.selIndex = row;
                 [pickerView selectRow:row inComponent:0 animated:YES];
            }
        }
        else if (component == 1) {
            
            if(row <=self.monthArray.count-1)
            {
                 self.selMonthIndex = row;
                 [pickerView selectRow:row inComponent:1 animated:YES];
            }
        }else {
            
            if(row <=self.dayArray.count-1)
            {
                self.selDayIndex = row;
                [pickerView selectRow:row inComponent:2 animated:YES];
            }
        }
        
    }
    else if (selType ==DataPickerEditTypeBefreindHeightFanwei || selType ==DataPickerEditTypeBefreindAgeFanwei)
    {
        if(component ==0)
        {
            self.selIndex = row;
            [pickerView selectRow:row inComponent:0 animated:YES];
        }
        else
        {
            self.selMonthIndex = row;
            [pickerView selectRow:row inComponent:1 animated:YES];
        }
    }
    
    else {
        self.selIndex = row;
    }
    
}


- (void)show {
    UIViewController *topVC = [self appRootViewController];
    
    //    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kViewWidth) * 0.5, SCREEN_HEIGHT, kViewWidth, kViewHeight);
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [topVC.view addSubview:self];
    
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)saveAction: (id)sender {
    
     NSString *errorStr = @"";
    if(selType == DataPickerEditBirthDay  )
    {
        if(self.yearStr==nil)
        {
            errorStr = @"还没选择出生年分噢";
            [WDProgressHUD showTips:errorStr];
            return;
        }
        
        if(self.monthStr ==nil)
        {
            errorStr=@"还没有选择月份噢";
            [WDProgressHUD showTips:errorStr];
            return;
        }
         if(self.dayStr ==nil)
        {
            errorStr=@"还没有选择日期噢";
            [WDProgressHUD showTips:errorStr];
            return;
        }
        
        [self dismiss];
        if (self.saveBlock) {
            self.saveBlock();
        }
        
    }
    else if (selType == DataPickerEditTypeSex)
    {
        if(self.selIndex ==-1)
        {
            
            errorStr=@"请正确选择您的性别";
            [WDProgressHUD showTips:errorStr];
            return;
        }
         [self dismiss];
        if (self.saveBlock) {
            self.saveBlock();
        }
    }
    
    else if(selType == DataPickerEditTypeBefreindAgeFanwei)
    {
        if(self.selIndex> self.selMonthIndex)
        {
        
            errorStr=@"请正确选择交友年龄范围";
            [WDProgressHUD showTips:errorStr];
            return;
        }
        
        [self dismiss];
        if (self.saveBlock) {
            self.saveBlock();
        }
    }
    else if(selType == DataPickerEditTypeBefreindHeightFanwei)
    {
    
        if(self.selIndex> self.selMonthIndex)
        {
            
            errorStr=@"请正确选择交友身高范围";
            [WDProgressHUD showTips:errorStr];
            return;
        }
        [self dismiss];
        if (self.saveBlock) {
            self.saveBlock();
        }
    }
    else
    {
    
        if (self.selIndex == -1)
        {
            
            if(selType == DataPickerEditTypeHeight) {
                errorStr = @"还没有选择身高噢";
            }
            else if (selType ==DataPickerEditTypeSchoolLevel)
            {
                errorStr = @"还没有选择学历噢";
            }
            else if (selType ==DataPickerEditTypeSalary)
            {
                errorStr =@"还没有选择收入噢";
            }
            else if (selType == DataPickerEditTypeConstellation)
            {
                errorStr =@"还没有选择星座噢";
            }
            else if(selType == DataPickerEditTypeMarrayTime)
            {
                errorStr = @"还没有选择期望结婚的时间噢";
            }
            else if(selType == DataPickerEditTypeMarratStatus)
            {
                errorStr =@"还没有选择目前婚姻状况噢";
            }
            [WDProgressHUD showTips:errorStr];
            return;
        }
       
        [self dismiss];
        if (self.saveBlock) {
            self.saveBlock();
        }
    }

   

}

- (void)cancelAction: (id)sender {
    [self dismiss];
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame: topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    //    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    //    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kViewWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kViewHeight) * 0.5, kViewWidth, kViewHeight);
    
    CGRect afterFrame  = CGRectMake(0, SCREEN_HEIGHT - kViewHeight, SCREEN_WIDTH, kViewHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //        self.transform = CGAffineTransformMakeRotation(0);
        self.editSelView.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    
    CGRect afterFrame  = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kViewHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.editSelView.frame = afterFrame;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)dismiss
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}



-(void)getDay:(int)year month:(int)month
{
    BOOL runnian =NO;
    if(year%4==0 && year%100!=0)
    {
        runnian=YES;
    }
    else if(year %400 ==0)
    {
        runnian =YES;
    }
    else
    {
        runnian =NO;
    }
    
     NSMutableArray *ttem =[NSMutableArray new];
    if(month ==1 || month==3 || month==5 || month==7 || month==8 || month==10 ||month==12 )
    {
       
        for (int i=1; i<32;i++ ) {
            [ttem addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else if (month==4 || month==6 ||month ==9||month ==11)
    {
        for (int i=1; i<31;i++ ) {
            [ttem addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    else
    {
        if(runnian)
        {
            for (int i=1; i<30;i++ ) {
                [ttem addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        else
        {
            for (int i=1; i<29;i++ ) {
                [ttem addObject:[NSString stringWithFormat:@"%d",i]];
            }
        
        }
    }
    
    self.dayArray =[ttem copy];
    
     [dataPicker reloadComponent:2];
     if(self.selDayIndex > self.dayArray.count-1)
     {
         self.selDayIndex =self.dayArray.count-1;
         [dataPicker selectRow: self.dayArray.count-1 inComponent: 2 animated: YES];
     }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
