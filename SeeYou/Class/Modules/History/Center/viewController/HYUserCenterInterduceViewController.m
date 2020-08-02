//
//  HYUserCenterInterduceViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserCenterInterduceViewController.h"
#import "HYBaseInfoVeiwModel.h"
@interface HYUserCenterInterduceViewController ()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) UILabel * labelnumber;
@property (nonatomic ,strong) HYBaseInfoVeiwModel * viewModel;
@end


@implementation HYUserCenterInterduceViewController


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
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    self.navigationItem.title = @"自我介绍";
    [self setupSubviews];
    self.viewModel =[HYBaseInfoVeiwModel new];
    [self bindViewModel];
    
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextViewTextDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel {
    @weakify(self);
    
    [[self.viewModel.doCommond.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.msg];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [self.viewModel.doCommond.errors subscribeNext:^(NSError * _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
}

- (void)setupSubviews {
    @weakify(self);
    UIView *backView = [UIView new];
    backView.backgroundColor        = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200.);
    }];
    
    self.textView = [UITextView textViewWithText:@""
                                       textColor:[UIColor tc31Color]
                                        fontSize:16.
                                     placeHolder:@"请输入您的自我介绍"
                                placeHolderColor:[UIColor tcbcbcbcColor]
                                        delegate:self
                                          inView:backView];
    self.textView.text = [HYUserContext shareContext].userModel.intro;
    self.textView.backgroundColor =[UIColor clearColor];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.equalTo(backView.mas_left).offset(15.);
        make.right.equalTo(backView.mas_right).offset(-15);
        make.top.equalTo(backView.mas_top).offset(15);
        make.height.equalTo(@155.);
    }];
    
    
    NSString * string =[NSString stringWithFormat:@"%lu/50",(unsigned long)self.textView.text.length];
    self.labelnumber = [UILabel labelWithText:string textColor:[UIColor tcbcbcbcColor] fontSize:15 inView:backView tapAction:nil];
    self.labelnumber.textAlignment  = NSTextAlignmentRight;
    [self.labelnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-15);
        make.top.equalTo(backView.mas_bottom).offset(-30);
        make.height.equalTo(@15);
    }];
}


- (void)change:(NSNotification *)info
{

    if(self.textView.text.length>0)
    {
        self.labelnumber.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)self.textView.text.length];
        
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font =Font_PINGFANG_SC(16);
        [button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem =anotherButton;
    }
    else
    {
        self.navigationItem.rightBarButtonItem =nil;
    }
}


- (void)commit
{

    self.textView.text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(self.textView.text.length ==0)
    {
        [WDProgressHUD showTips:@"请输入自我介绍"];
        return;
    }
    self.viewModel.dk=@"intro";
    self.viewModel.dv = self.textView.text;
    
    [WDProgressHUD showInView:self.view];
    [self.viewModel.doCommond execute:@"1"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
