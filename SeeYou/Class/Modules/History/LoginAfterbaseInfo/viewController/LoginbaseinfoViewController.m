//
//  LoginbaseinfoViewController.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/5.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "LoginbaseinfoViewController.h"
#import "HYBaseInfoVeiwModel.h"
#import "LofinBaseinfoCell.h"
#import "DataPickerView.h"
#import "HYBaseInfoVeiwModel.h"
#import "HYAreaDataInstance.h"
#import "DataPickerView.h"
#import "LoginbaseinfoViewModel.h"

@interface LoginbaseinfoViewController ()
@property(nonatomic ,strong) LoginbaseinfoViewModel * viewModel;
@property(nonatomic ,strong)DataPickerView *editView;


@property(nonatomic ,strong) LofinBaseinfoView * nickNameView;
@property(nonatomic ,strong) LofinBaseinfoView * sexView;
@property(nonatomic ,strong) LofinBaseinfoView * birthdayView;
@property(nonatomic ,strong) LofinBaseinfoView * workView;
@property(nonatomic ,strong) LofinBaseinfoView * salaryView;
@property(nonatomic ,strong) NSString * areaCode;

@property(nonatomic ,strong) UIButton * buttoncommit;

@end

@implementation LoginbaseinfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.canBack =YES;
    self.navigationItem.title=@"基本资料填写";
    [self setUpview];
    [self subviewsLayout];
    self.viewModel =[LoginbaseinfoViewModel new];
    [self bindModel];
    
    UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doaction)];
    [self.view addGestureRecognizer:ges];
    // Do any additional setup after loading the view.
}

- (void)doaction
{
    
    [self.nickNameView.contextflied resignFirstResponder];
    
}
- (void)popBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)bindModel
{
    [[self.viewModel.doRaccommand.executionSignals switchToLatest ] subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        
         [YSMediator pushToViewController:@"IdentityAuthenticationViewController" withParams:@{} animated:YES callBack:nil];
    }];
    
    [self.viewModel.doRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
        [WDProgressHUD hiddenHUD];
    }];
}

-(void)setUpview
{

   @ weakify(self);
    self.nickNameView= [LofinBaseinfoView new];
    self.nickNameView.iconImage.image =[UIImage imageNamed:@"nickname"];
    self.nickNameView.viewTitle=@"昵称";
    self.nickNameView.contextflied.placeholder=@"请输入（最多8个汉字）";
    if([HYUserContext shareContext].userModel.name.length>0)
    {
        self.nickNameView.viewContent =[HYUserContext shareContext].userModel.name;
    }
    self.nickNameView.showArrow=NO;
    self.nickNameView.maxlength=16;
    self.nickNameView.contextflied.enabled=YES;
    [self.view addSubview:self.nickNameView];
    
    
    self.sexView = [LofinBaseinfoView new];
    self.sexView.iconImage.image =[UIImage imageNamed:@"man"];
    self.sexView.viewTitle=@"性别";
    self.sexView.contextflied.placeholder=@"请选择";
    if([HYUserContext shareContext].userModel.sex.length>0 )
    {
           self.sexView.viewContent =[HYUserContext shareContext].userModel.sex;
    }
    else
        self.sexView.viewContent=[HYUserContext shareContext].defalutsex==1?@"男":@"女";
    self.sexView.showArrow=YES;
    [self.view addSubview:self.sexView];
    
    self.sexView.openViewblock=^()
    {
        @strongify(self);
        [self doaction];
        [self editerWithStyle:DataPickerEditTypeSex];
    };
    
    
    self.birthdayView = [LofinBaseinfoView new];
    self.birthdayView.iconImage.image =[UIImage imageNamed:@"birthday"];
    self.birthdayView.viewTitle=@"出生日期";
    self.birthdayView.contextflied.placeholder=@"请选择";
    if([HYUserContext shareContext].userModel.birthday.length>0)
    {
        self.birthdayView.viewContent =[NSString stringWithFormat:@"%@-%@-%@",[HYUserContext shareContext].userModel.birthyear,[HYUserContext shareContext].userModel.birthmonth,[HYUserContext shareContext].userModel.birthday ];
    }
    self.birthdayView.showArrow=YES;
    [self.view addSubview:self.birthdayView];
    
    self.birthdayView.openViewblock=^()
    {
       
        @strongify(self);
        [self doaction];
        [self editerWithStyle:DataPickerEditBirthDay];
    };
    
    
    self.workView = [LofinBaseinfoView new];
    self.workView.iconImage.image =[UIImage imageNamed:@"homeplace"];
    self.workView.viewTitle=@"工作生活在";
    self.workView.contextflied.placeholder=@"请选择";
    if([HYUserContext shareContext].userModel.provincestr .length>0)
    {
        self.workView.viewContent =[NSString stringWithFormat:@"%@-%@",[HYUserContext shareContext].userModel.provincestr , [HYUserContext shareContext].userModel.citystr ] ;
        self.areaCode = [NSString stringWithFormat:@"%@", [HYUserContext shareContext].userModel.city ];
    }
    self.workView.showArrow=YES;
    [self.view addSubview:self.workView];
    
    self.workView.openViewblock=^()
    {
        @strongify(self);
        [self doaction];
        [self editerWithStyle:DataPickerEditTypeHomePlace];
       
    };
    
    
    self.salaryView = [LofinBaseinfoView new];
    self.salaryView.iconImage.image =[UIImage imageNamed:@"salary"];
    self.salaryView.viewTitle=@"月收入";
    self.salaryView.contextflied.placeholder=@"请选择";
    if([HYUserContext shareContext].userModel.reciveSalary .length>0)
    {
        self.salaryView.viewContent =[HYUserContext shareContext].userModel.reciveSalary ;
    }
    self.salaryView.showArrow=YES;
    [self.view addSubview:self.salaryView];
    
    self.salaryView.openViewblock=^()
    {
        @strongify(self);
        [self doaction];
         [self editerWithStyle:DataPickerEditTypeSalary];
    };
    
    
    self.buttoncommit =[UIButton buttonWithTitle:@"下一步" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor bgff8bb1Color] inView:self.view action:^(UIButton *btn) {
        //提交图片 跳转到 CommitVerfifyViewController 页面
        @strongify(self);
        [self commit];
    }];

    
    
}

- (void) subviewsLayout
{

    @weakify(self);
    [self.nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(15);
        make.height.equalTo(@50);
    }];
    
    
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.nickNameView.mas_bottom).offset(0);
        make.height.equalTo(@50);
    }];
    
    [self.birthdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.sexView.mas_bottom).offset(0);
        make.height.equalTo(@50);
    }];
    
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.birthdayView.mas_bottom).offset(0);
        make.height.equalTo(@50);
    }];
    
    [self.salaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.workView.mas_bottom).offset(0);
        make.height.equalTo(@50);
    }];
 
    
    [self.buttoncommit mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
    
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.top.equalTo(self.salaryView.mas_bottom).offset(100);
            make.height.equalTo(@44);
    }];
    
}



- (void) editerWithStyle:(DataPickerEditType ) type
{
    
    
//    [HYUserContext shareContext].defalutsex 
    self.editView = [[DataPickerView alloc] initWithSelType: type];
    [self.editView loadData];//刷新数据源。必需在[editView show]; 之前调用
    [self.editView show];
    
    
    
    if(type ==DataPickerEditTypeSex)
    {
        NSString *string = [HYUserContext shareContext].defalutsex==1?@"男":@"女";
            
        if([self.editView.dataArray indexOfObject:string]==NSNotFound)
        {
            self.editView.selIndex=0;
        }
        else
        {
            self.editView.selIndex = [self.editView.dataArray indexOfObject:string ];
        }
      
    }
    else if (type ==DataPickerEditTypeSalary)
    {
        self.editView.selIndex=0;
    }
    else if (type ==DataPickerEditBirthDay)
    {
        NSString *string = @"1988";
        
        if([self.editView.dataArray indexOfObject:string]==NSNotFound)
        {
            self.editView.selIndex=0;
            self.editView.selMonthIndex=0;
            self.editView.selDayIndex=0;
        }
        else
        {
            self.editView.selIndex = [self.editView.dataArray indexOfObject:string ];
            self.editView.selMonthIndex=0;
            self.editView.selDayIndex=0;
        }
        
    }
    
    
    //消失的block
    self.editView.dismissBlock = ^() {
        //[self reLoadTableViewData];
    };
    
    @weakify(self);
    self.editView.saveBlock=^()
    {
        @strongify(self);
        
        switch (type) {
            case DataPickerEditTypeSex:
            {
                NSString * string =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                self.sexView.viewContent =string;
                
            }
                break;
            case DataPickerEditBirthDay:
            {
                NSString *year =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                NSString *mounth =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString * day = [self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                NSString *String =[NSString stringWithFormat:@"%@-%@-%@",year,mounth,day];
                self.birthdayView.viewContent = String;
                
            }
                break;

            case DataPickerEditTypeHomePlace:
            {
           
                if(self.editView.selDayIndex<0)
                {
                    self.editView.selDayIndex =0;
                }
                
            AreaDataModel * model  =[self.editView.dayArray objectAtIndex:self.editView.selDayIndex];
                self.areaCode = [NSString stringWithFormat:@"%@" ,model.iD ];
                AreaDataModel * modelp  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                AreaDataModel * modelC  =[self.editView.monthArray objectAtIndex:self.editView.selMonthIndex];
                NSString *string =[NSString stringWithFormat:@"%@-%@",modelp.name,modelC.name];
                self.workView.viewContent= string;
            }
                break;
            case DataPickerEditTypeSalary:
            {
//                vm.dk=@"salary";
                NSString *string  =[self.editView.dataArray objectAtIndex:self.editView.selIndex];
                self.salaryView.viewContent = string;
//                vm.showValue= vm.dv;
//                [vm.doCommond execute:@"1"];
                
            }
                break;

            default:
                break;
        }
        
    };
    
}

-(void) commit
{

    NSString * string =[self.nickNameView.contextflied.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.nickNameView.viewContent =string;
    
    if(self.nickNameView.viewContent.length==0)
    {
        [WDProgressHUD showTips:@"请输入用户名"];
        return;
    }
    if(self.sexView.viewContent.length==0)
    {
        [WDProgressHUD showTips:@"请选择性别"];
        return;
    }
    if(self.birthdayView.viewContent.length==0)
    {
        [WDProgressHUD showTips:@"请选择出生日期"];
        return;
    }
    
    if(self.workView.viewContent.length==0)
    {
        [WDProgressHUD showTips:@"请选择工作生活地"];
        return;
    }
    
    if(self.salaryView.viewContent.length==0)
    {
        [WDProgressHUD showTips:@"请选择收入"];
        return;
    }
    
    NSDictionary *dic =@{
                         @"name":self.nickNameView.viewContent,
                         @"sex":self.sexView.viewContent,
                         @"birthday":self.birthdayView.viewContent,
                         @"workarea":self.areaCode,
                         @"salary":self.salaryView.viewContent,
                         
                         };
    [WDProgressHUD showInView:nil];
    [self.viewModel.doRaccommand execute:dic];
    
    
    
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
