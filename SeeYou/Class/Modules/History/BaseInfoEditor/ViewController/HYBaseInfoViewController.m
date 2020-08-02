//
//  HYBaseInfoViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseInfoViewController.h"
#import "HYBaseInfoVeiwModel.h"
#import "HYBaseInfocell.h"
#define HYBaseInfocell_ID @"HYBaseInfocell"
#import "DataPickerView.h"
#import "HYBaseInfoVeiwModel.h"
#import "HYAreaDataInstance.h"
#import "DataPickerView.h"
@interface HYBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView * mTableView;
@property(nonatomic ,strong) HYBaseInfoVeiwModelForViewController * viewModel;

//@property(nonatomic ,strong) HYBaseInfoVeiwModel * editorViewModel;
@property(nonatomic ,strong)DataPickerView *editView;
@end

@implementation HYBaseInfoViewController


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
    self.canBack =YES;
    self.navigationItem.title=@"基本资料";
    [self setUpview];
    [self subviewsLayout];
    self.viewModel =[HYBaseInfoVeiwModelForViewController new];
    // Do any additional setup after loading the view.
}


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
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
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
        case HYGOTOUserNameEditorType:
        {
            
//            if([[HYUserContext  shareContext].userModel.identityverifystatus boolValue])
//            {
//            
//                [WDProgressHUD showTips:@"你已经进行过身份认证不可以修改名字"]
//                return;
//            }
//            
            
            id okBlock=^(NSString *v)
            {
                vm.value =v;
            };
            
        
            
             [YSMediator pushToViewController:@"HYEditorPrefessionViewController" withParams:@{
                                                                                                      @"defaaultValue":([HYUserContext shareContext].userModel.name.length>0? [HYUserContext shareContext].userModel.name:@""),
                                                                                                      @"navatitle":@"编辑姓名",
                                                                                                      @"source": [NSNumber numberWithInteger:HYGOTOUserNameEditorType],
                                                                                                      @"okblock":okBlock} animated:YES callBack:nil];
        }
            break;
        case HYGOTOWorkPlaceEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeWorkPlace withVM:vm];
        }
            break;
        case HYGOTOHomePlaceEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeHomePlace withVM:vm];
        }
            break;
        case HYGOTOBirthEditorType:
        {
             [self editerWithStyle:DataPickerEditBirthDay withVM:vm];
        }
            break;
        case HYGOTOHeightEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeHeight withVM:vm];
        }
            break;
        case HYGOTOSchoolLevelEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeSchoolLevel withVM:vm];
        }
            break;
            
        case HYGOTOProfessialEditorType:
        {
            
            id okBlock=^(NSString *v)
            {
                vm.value =v;
            };
            [YSMediator pushToViewController:@"HYEditorPrefessionViewController" withParams:@{
                                                                                                     @"okblock":okBlock,
                                                                                                      @"defaaultValue":([HYUserContext shareContext].userModel.personal.length>0? [HYUserContext shareContext].userModel.personal:@""),
                                                                                                     @"navatitle":@"编辑职业",@"source": [NSNumber numberWithInteger:HYGOTOProfessialEditorType]} animated:YES callBack:nil];
        }
            break;
        case HYGOTOSalaryEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeSalary withVM:vm];
        }
            break;
        case HYGOTOConstellationEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeConstellation withVM:vm];
        
        }
            break;
        case HYGOTOWantMarrayTimeEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeMarrayTime withVM:vm];
            
        }
            break;
        case HYGOTOMarrayStatusEditorType:
        {
            [self editerWithStyle:DataPickerEditTypeMarratStatus withVM:vm];
        }
            break;
        default:
            break;
    }
    
}

- (void) editerWithStyle:(DataPickerEditType ) type withVM:(HYBaseInfoVeiwModel*)vm
{

    self.editView = [[DataPickerView alloc] initWithSelType: type];
    [self.editView loadData];//刷新数据源。必需在[editView show]; 之前调用
    [self.editView show];
    //消失的block
    self.editView.dismissBlock = ^() {
        //[self reLoadTableViewData];
    };
    
    switch (type) {
        case DataPickerEditTypeWorkPlace:
        {
            NSNumber * provice =  [HYUserContext shareContext].userModel.province ;
            NSNumber * city = [HYUserContext shareContext].userModel.city;
            NSNumber * district =[HYUserContext shareContext].userModel.district;
            self.editView.selIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dataArray key:provice];
            self.editView.selMonthIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.monthArray key:city];
            self.editView.selDayIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dayArray key:district];
            
            
        }
            break;
        case DataPickerEditTypeHomePlace:
        {
            NSNumber * provice =  [HYUserContext shareContext].userModel.homeprovince ;
            NSNumber * city = [HYUserContext shareContext].userModel.homecity;
            NSNumber * district =[HYUserContext shareContext].userModel.homedistrict;
            self.editView.selIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dataArray key:provice];
            self.editView.selMonthIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.monthArray key:city];
            self.editView.selDayIndex=[[HYAreaDataInstance shareInstance] findAreaData:self.editView.dayArray key:district];
        }
            break;
        case DataPickerEditBirthDay:
        {
            
            NSString * year = [HYUserContext shareContext].userModel.birthyear.length==0?@"":[HYUserContext shareContext].userModel.birthyear;
            NSString * month = [HYUserContext shareContext].userModel.birthmonth.length==0?@"":[HYUserContext shareContext].userModel.birthmonth;
            NSString * day =[HYUserContext shareContext].userModel.birthday.length==0?@"":[HYUserContext shareContext].userModel.birthday;
        
            if([self.editView.dataArray indexOfObject:year]==NSNotFound)
            {
                self.editView.selIndex=0;
            }
            else
            {
                self.editView.selIndex =[self.editView.dataArray indexOfObject:year];
            }
            
            if([self.editView.monthArray indexOfObject:month] ==NSNotFound)
            {
                self.editView.selMonthIndex =0;
            }
            else
            {
                 self.editView.selMonthIndex =[self.editView.monthArray indexOfObject:month];
            }
            
            
            if([self.editView.dayArray indexOfObject:day] ==NSNotFound)
            {
                self.editView.selDayIndex =0;
            }
            else
            {
                self.editView.selDayIndex =[self.editView.dayArray indexOfObject:day];
            }
        }
            break;
        case DataPickerEditTypeHeight:
        {
            
            NSString * string =[HYUserContext shareContext].userModel.height;
            if(string.length==0)
            {
                if([[HYUserContext shareContext].userModel.sex isEqualToString:@"男"])
                    string=@"170";
                else
                    string=@"160";
            }
            
            
            
             if([self.editView.dataArray indexOfObject:string]==NSNotFound)
             {
                 self.editView.selIndex=0;
             }
            else
                self.editView.selIndex = [self.editView.dataArray indexOfObject:string ];
        }
            break;
        case DataPickerEditTypeSchoolLevel:
        {
            NSString * string =[HYUserContext shareContext].userModel.schoollevel;
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
            NSString * string =[HYUserContext shareContext].userModel.reciveSalary;
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
        case DataPickerEditTypeConstellation:
        {
            NSString * string =[HYUserContext shareContext].userModel.constellation;
            if(string.length==0)
                string=@"白羊座";
            if([self.editView.dataArray indexOfObject:string]==NSNotFound)
            {
                self.editView.selIndex=0;
            }
            else
                self.editView.selIndex = [self.editView.dataArray indexOfObject:string];
        }
            break;
        case DataPickerEditTypeMarrayTime:
        {
            NSString * string =[HYUserContext shareContext].userModel.wantToMarrayTime;
            if(string.length==0)
                string=@"期望一年内结婚";
            if([self.editView.dataArray indexOfObject:string]==NSNotFound)
            {
                self.editView.selIndex=0;
            }
            else
                self.editView.selIndex = [self.editView.dataArray indexOfObject:string];
        }
            break;
        case DataPickerEditTypeMarratStatus:
        {
            NSString * string =[HYUserContext shareContext].userModel.marry;
            if(string.length==0)
                string=@"保密";
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
                
                vm.dk=@"workarea";
                AreaDataModel * model  =[self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                vm.dv = [NSString stringWithFormat:@"%@",model.iD];
                AreaDataModel * modelp  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                AreaDataModel * modelC  =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString *string =[NSString stringWithFormat:@"%@-%@",modelp.name,modelC.name];
                
                
                vm.showValue= string;
                
                [vm.doCommond execute:@"1"];
                
                
            }
                break;
            case DataPickerEditTypeHomePlace:
            {
                vm.dk=@"homearea";
                AreaDataModel * model  =[self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                vm.dv = [NSString stringWithFormat:@"%@",model.iD];
                
                AreaDataModel * modelp  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                AreaDataModel * modelC  =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString *string =[NSString stringWithFormat:@"%@-%@",modelp.name,modelC.name];
                
                
                vm.showValue= string;
                [vm.doCommond execute:@"1"];
            }
                break;
            case DataPickerEditBirthDay:
            {
                vm.dk=@"birthday";
                
                NSString *year =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                NSString *mounth =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString * day = [self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                vm.dv =[NSString stringWithFormat:@"%@-%@-%@",year,mounth,day];
                vm.showValue= vm.dv;
                [vm.doCommond execute:@"1"];
                
                
                
            }
                break;
            case DataPickerEditTypeHeight:
            {
                vm.dk=@"height";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= [NSString stringWithFormat:@"%@cm",vm.dv];
                [vm.doCommond execute:@"1"];
            }
                break;
            case DataPickerEditTypeSchoolLevel:
            {
                vm.dk=@"degree";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= [NSString stringWithFormat:@"%@",vm.dv];
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeSalary:
            {
                vm.dk=@"salary";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= vm.dv;
                [vm.doCommond execute:@"1"];
               
            }
                break;
            case DataPickerEditTypeConstellation:
            {
                vm.dk=@"constellation";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= [NSString stringWithFormat:@"%@",vm.dv];
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeMarrayTime:
            {
                 vm.dk=@"wantmarry";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= [NSString stringWithFormat:@"%@",vm.dv];
                [vm.doCommond execute:@"1"];
                
            }
                break;
            case DataPickerEditTypeMarratStatus:
            {
                
                vm.dk=@"marry";
                vm.dv =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                vm.showValue= [NSString stringWithFormat:@"%@",vm.dv];
                [vm.doCommond execute:@"1"];
            }
                break;
            default:
                break;
        }
        
    };
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 数据查找




@end
