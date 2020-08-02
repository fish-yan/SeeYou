//
//  HYEditorPrefessionViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/5.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYEditorPrefessionViewController.h"
#import "HYBaseInfoVeiwModel.h"

typedef void(^OKBlock)(NSString * value);

@interface HYEditorPrefessionViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong) UITextField * prefessiontextfiled;
@property(nonatomic ,strong) NSString * navatitle;
@property(nonatomic ,assign) HYEditorType   source;
@property(nonatomic ,strong) HYBaseInfoVeiwModel *viewModel;
@property(nonatomic ,strong) NSString * defaaultValue;
@property(nonatomic ,copy) OKBlock okblock;

@end

@implementation HYEditorPrefessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canBack =YES;
    self.navigationItem.title=self.navatitle ;//@"编辑职业";
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    self.navigationItem.rightBarButtonItem =nil;
    [self setUpView];
    
    self.viewModel = [HYBaseInfoVeiwModel new];
   
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfiledChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

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

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setUpView
{
    UIView *v =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    @weakify(self);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.height.equalTo(@50);
    }];
    
    self.prefessiontextfiled =[UITextField  textFieldWithText:@"" textColor:[UIColor tc31Color] fontSize:15 andDelegate:self inView:v];
    self.prefessiontextfiled.text =self.defaaultValue;
    self.prefessiontextfiled.placeholder=self.source == HYGOTOUserNameEditorType ?@"输入名字": @"请输入职业";
    [self.prefessiontextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v.mas_left).offset(15);
        make.top.equalTo(v.mas_top).offset(10);
        make.bottom.equalTo(v.mas_bottom).offset(-10);
        make.right.equalTo(v.mas_right).offset(-10);
        
    }];
    self.prefessiontextfiled.font =Font_PINGFANG_SC(15);
    self.prefessiontextfiled.clearButtonMode =UITextFieldViewModeWhileEditing;
}

- (UIBarButtonItem *) barButtonItem
{

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font =Font_PINGFANG_SC(16);
    [button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return anotherButton;
}


-(void) commit
{
    
    self.prefessiontextfiled.text = [self.prefessiontextfiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(self.prefessiontextfiled.text.length >20)
    {
        [WDProgressHUD showTips:self.source ==HYGOTOUserNameEditorType?@"请正确输入您的姓名":@"请正确输入您的职业"];
    }
    if(self.source ==HYGOTOUserNameEditorType)
    {
        self.viewModel.dk=@"name";
        self.viewModel.dv = self.prefessiontextfiled.text;
    }
    else
    {
        self.viewModel.dk=@"jobinfo";
        self.viewModel.dv = self.prefessiontextfiled.text;
    }
    
    [WDProgressHUD showInView:nil];
    [self.viewModel.doCommond execute:@"1"];
}


- (void) textfiledChanged:(NSNotification *)center
{

    if(self.prefessiontextfiled.text.length>0)
    {
        self.navigationItem.rightBarButtonItem =[self barButtonItem];
    }
    else
    {
        self.navigationItem.rightBarButtonItem =nil;
    }
    
}


- (void)bindModel
{
    @weakify(self);
    
    [[self.viewModel.doCommond.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *  _Nullable x) {
        
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.msg];
        
         if(self.source ==HYGOTOUserNameEditorType)
        {
         [HYUserContext shareContext].userModel.name = self.viewModel.dv;
        }
        else
        {
            [HYUserContext shareContext].userModel.personal = self.viewModel.dv;
        }
        
        
        if(self.okblock)
        {
            self.okblock(self.viewModel.dv);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [[self.viewModel.doCommond errors] subscribeNext:^(NSError * _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
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
