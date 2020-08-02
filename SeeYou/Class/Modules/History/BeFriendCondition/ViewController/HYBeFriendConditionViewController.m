//
//  HYBeFriendConditionViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBeFriendConditionViewController.h"
#import "HYBeFriendViewModel.h"
#import "HYBaseInfocell.h"
#import "HYAreaDataInstance.h"
#import "HYBaseInfoVeiwModel.h"
#define HYBaseInfocell_ID @"HYBaseInfocell"
#import "DataPickerView.h"
@interface HYBeFriendConditionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView * mTableView;
@property(nonatomic ,strong) HYBeFriendViewModel * viewModel;
@property(nonatomic ,strong) DataPickerView * editView;
@end

@implementation HYBeFriendConditionViewController


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canBack = YES;
    
    self.navigationItem.title=@"交友条件";
    [self setUpview];
    [self subviewsLayout];
    self.viewModel =[HYBeFriendViewModel new];

   
    // Do any additional setup after loading the view.
}


//-(void) bindmodel
//{
//    @weakify(self);
//    [[self.editorViewModel.doCommond.executionSignals switchToLatest] subscribeNext:^(WDResponseModel*  _Nullable x) {
//        
//        [WDProgressHUD hiddenHUD];
//        [WDProgressHUD showTips:x.msg];
//    }];
//    [[self.editorViewModel.doCommond errors] subscribeNext:^(NSError * _Nullable x) {
//        
//        [WDProgressHUD hiddenHUD];
//        [WDProgressHUD showTips:x.localizedDescription];
//    }];
//}

- (void)setUpview
{
    self.mTableView =[UITableView tableViewOfStyle:UITableViewStylePlain inView:self.view withDatasource:self delegate:self];
    self.mTableView.showsVerticalScrollIndicator=NO;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.backgroundColor =[UIColor clearColor];
    [self.mTableView registerClass:[HYBaseInfocell class] forCellReuseIdentifier:HYBaseInfocell_ID];
    
    
    
}


- (void) subviewsLayout
{
    
    @weakify(self);
    [self.mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
}



#pragma mark --TableviewDelegate--
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBaseInfocell *cell = [tableView dequeueReusableCellWithIdentifier:HYBaseInfocell_ID];
    [cell  bindWithViewModel:[self.viewModel.listArray objectAtIndex:indexPath.row]];
    return cell;
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBaseInfoVeiwModel *vm  = [self.viewModel.listArray objectAtIndex:indexPath.row];
    
    switch (vm.type) {
        case HYGOTOWorkPlaceEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeWorkPlace withVM:vm ];
        }
            break;
        case HYGOTOHomePlaceEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeHomePlace withVM:vm ];
        }
            break;
        case HYGOTOBirthEditorType://年龄
        {
            [self editerWithStyle:DataPickerEditTypeBefreindAgeFanwei withVM:vm ];
        }
            break;
        case HYGOTOHeightEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeBefreindHeightFanwei withVM:vm ];
        }
            break;
        case HYGOTOSchoolLevelEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeSchoolLevel withVM:vm ];
        }
            break;
            
        case HYGOTOSalaryEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeSalary withVM:vm ];
        }
            break;
        default:
            break;
    }
    
}


- (void) editerWithStyle:(DataPickerEditType ) type  withVM:(HYBaseInfoVeiwModel*)vm
{
    
    self.editView = [[DataPickerView alloc] initWithSelType: type];
    [self.editView  loadData];//刷新数据源。必需在[editView show]; 之前调用
    [self.editView  show];
    //消失的block
    self.editView .dismissBlock = ^() {
        //[self reLoadTableViewData];
    };
    
    switch (type) {
        case DataPickerEditTypeWorkPlace:
        {
            NSNumber * provice =  [HYUserContext shareContext].userModel.wantprovince ;
            NSNumber * city = [HYUserContext shareContext].userModel.wantcity;
            NSNumber * district =[HYUserContext shareContext].userModel.wantdistrict;
            self.editView.selIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dataArray key:provice];
            self.editView.selMonthIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.monthArray key:city];
            self.editView.selDayIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dayArray key:district];
        
        }
            break;
        case DataPickerEditTypeHomePlace:
        {
            NSNumber * provice =  [HYUserContext shareContext].userModel.wanthomeprovince ;
            NSNumber * city = [HYUserContext shareContext].userModel.wanthomecity;
            NSNumber * district =[HYUserContext shareContext].userModel.wanthomedistrict;
            self.editView.selIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dataArray key:provice];
            self.editView.selMonthIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.monthArray key:city];
            self.editView.selDayIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dayArray key:district];
        }
            break;
        case DataPickerEditTypeBefreindAgeFanwei:
        {
            
            if([self.editView .dataArray indexOfObject:[HYUserContext shareContext].userModel.wantagestart]==NSNotFound ||[self.editView .monthArray indexOfObject:[HYUserContext shareContext].userModel.wantageend]==NSNotFound )
            {
                self.editView.selIndex =0;
                self.editView.selMonthIndex=0;
            }
            else
            {
            self.editView .selIndex =[self.editView .dataArray indexOfObject:[HYUserContext shareContext].userModel.wantagestart];
            self.editView .selMonthIndex =[self.editView .monthArray indexOfObject:[HYUserContext shareContext].userModel.wantageend];
            }
        }
            break;
        case DataPickerEditTypeBefreindHeightFanwei:
        {
            if([self.editView .dataArray indexOfObject:[HYUserContext shareContext].userModel.wantheightstart]==NSNotFound ||[self.editView .monthArray indexOfObject:[HYUserContext shareContext].userModel.wantheightend]==NSNotFound )
            {
                self.editView.selIndex =0;
                self.editView.selMonthIndex=0;
            }
            else
            {
                self.editView .selIndex =[self.editView .dataArray indexOfObject:[HYUserContext shareContext].userModel.wantheightstart];
                self.editView .selMonthIndex =[self.editView .monthArray indexOfObject:[HYUserContext shareContext].userModel.wantheightend];
            }
        }
            break;
        case DataPickerEditTypeSchoolLevel:
        {
            
            NSString * string =[HYUserContext shareContext].userModel.wantdegree;
            if(string.length==0)
                string=@"小学";
            if([self.editView.dataArray indexOfObject:string]==NSNotFound)
            {
                self.editView.selIndex=0;
                
            }
            else
                self.editView.selIndex = [self.editView.dataArray indexOfObject:string];
        }
            break;
        case DataPickerEditTypeSalary:
        {
            NSString * string =[HYUserContext shareContext].userModel.wantsalary;
            if(string.length==0)
                string=@"2k以下";
            if([self.editView.dataArray indexOfObject:string]==NSNotFound)
            {
                self.editView.selIndex=0;
            }
            else
                self.editView.selIndex = [self.editView.dataArray indexOfObject:string];
        }
            break;

        default:
            break;
    }
    
    @weakify(self);
    self.editView.saveBlock=^()
    {
        @strongify(self);
        switch (type) {
            case DataPickerEditTypeWorkPlace:
            {
                vm.dk=@"wantworkarea";
                AreaDataModel * model  =[self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                vm.dv = [NSString stringWithFormat:@"%@",model.iD];
                AreaDataModel * modelp  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                AreaDataModel * modelC  =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString *string =[NSString stringWithFormat:@"%@-%@",modelp.name,modelC.name];
                vm.showValue = string;
                [vm.doCommond execute:@"1"];
            }
                break;
            case DataPickerEditTypeHomePlace:
            {
                vm.dk=@"wanthomearea";
                AreaDataModel * model  =[self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                vm.dv = [NSString stringWithFormat:@"%@",model.iD];
                AreaDataModel * modelp  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                AreaDataModel * modelC  =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString *string =[NSString stringWithFormat:@"%@-%@",modelp.name,modelC.name];
                vm.showValue = string;
                
                [vm.doCommond execute:@"1"];
            }
                break;
            case DataPickerEditTypeBefreindAgeFanwei:
            {
                vm.dk=@"wantage";
                
                
                
                
                NSString *lowage =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                NSString *heightage =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                vm.dv =[NSString stringWithFormat:@"%@-%@",lowage,heightage];
                vm.showValue =[NSString stringWithFormat:@"%@岁",vm.dv];
//                vm.showValue = vm.dv;
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeBefreindHeightFanwei:
            {
                
                vm.dk=@"wantheight";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                NSString *lowheight =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                NSString *maxheight =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                vm.dv =[NSString stringWithFormat:@"%@-%@",lowheight,maxheight];
                vm.showValue =[NSString stringWithFormat:@"%@cm",vm.dv];
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeSchoolLevel:
            {
                vm.dk=@"wantdegree";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue = vm.dv;
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeSalary:
            {
                vm.dk=@"wantsalary";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue = vm.dv;
                [vm.doCommond execute:@"1"];
                
            }
                break;
            default:
                break;
        }
        
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
