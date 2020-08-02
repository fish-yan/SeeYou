//
//  PrivateMessageDetialViewController.m
//  huanyuan
//
//  Created by luzhongchang on 17/8/7.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "PrivateMessageDetialViewController.h"
#import "PrivateMessageDetialListViewModel.h"
#import "PrivateMessageDetialCell.h"
#import "PrivateMessageDetiaModel.h"
#import "MessageTextView.h"
#import "AuthenticationManager.h"
#import "HYYueHuiTableViewCell.h"
#define PrivateMessageDetialCell_ID @"PrivateMessageDetialCell"
#define HYYueHuiTableViewCell_ID    @"HYYueHuiTableViewCell_ID"
#define HEIGHT_CHATBOXVIEW  215

@interface PrivateMessageDetialViewController ()<UITableViewDelegate,UITableViewDataSource,ChatBoxDelegate>

@property(nonatomic ,strong) NSString *cantactName;
@property(nonatomic ,strong) NSString * cantactID;
@property(nonatomic ,strong) NSString *avatar;
@property(nonatomic ,strong) UITableView * mTableview;
@property(nonatomic ,strong) PrivateMessageDetialListViewModel * viewModel;
@property(nonatomic ,strong) MessageTextView *chatBox;
@property(nonatomic ,assign) float curheight;
@property(nonatomic ,assign) CGRect keyboardFrame;
@property(nonatomic ,assign) BOOL sending;

@end

@implementation PrivateMessageDetialViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
   
    
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
 
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.cantactName;
    
    self.canBack =YES;
    [self setUpview];
    self.sending=NO;
    
    self.viewModel =[PrivateMessageDetialListViewModel new];
    [self bindModel];
    self.viewModel.uid = self.cantactID;
    [WDProgressHUD showInView:self.view];
    [self.viewModel.doCommond execute:@"1"];
   
    
    
    // Do any additional setup after loading the view.
}


-(void)setUpview
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStyleGrouped inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    [self.mTableview registerClass:[PrivateMessageDetialCell class] forCellReuseIdentifier:PrivateMessageDetialCell_ID];
    [self.mTableview registerClass:[HYYueHuiTableViewCell class] forCellReuseIdentifier:HYYueHuiTableViewCell_ID];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    [self.view addSubview:self.chatBox];
    
    [self.chatBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(HEIGHT_TABBAR);
    }];
    self.mTableview.mj_header = [WDRefresher headerWithRefreshingBlock:^{
        @strongify(self);
        
        self.viewModel.lastdate =nil;
        [self.viewModel.doCommond execute:@"1"];
    }];
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    [button setTitle:@"⊘" forState:UIControlStateNormal];
    button.titleLabel.font =Font_PINGFANG_SC(16);
    [button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(stopOpration) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
    [button1 setTitle:@"约会" forState:UIControlStateNormal];
    button1.titleLabel.font =Font_PINGFANG_SC(16);
    [button1 setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(yuehui) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * rightberitem  =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem * rightberitem1  =[[UIBarButtonItem alloc] initWithCustomView:button1];
    //    UIBarButtonItem * rightberitem =[[UIBarButtonItem alloc] initWithTitle:@"⊘" style:UIBarButtonItemStyleBordered target:self action:@selector(stopOpration)];
    self.navigationItem.rightBarButtonItems=@[rightberitem1,rightberitem];
    
    
    
//    UIBarButtonItem * rightberitem  =[[UIBarButtonItem alloc] initWithCustomView:button];
//    //    UIBarButtonItem * rightberitem =[[UIBarButtonItem alloc] initWithTitle:@"⊘" style:UIBarButtonItemStyleBordered target:self action:@selector(stopOpration)];
//    self.navigationItem.rightBarButtonItems=@[rightberitem];
    
}

-(void) yuehui
{
    NSDictionary *params = @{
                             @"uid":self.cantactID?:@"",
                             @"avatar": self.avatar,
                             @"name": @"",
                             @"appointmentstatus":@0
                             };
    
    [YSMediator pushToViewController:kModuleDatingInfo
                          withParams:params
                            animated:YES
                            callBack:NULL];
}

-(void)stopOpration
{
    
    id cancelBlock=^()
    {
        
    };
    id sureBlock=^()
    {
        
        if(self.cantactID.length==0)
        {
            return ;
        }
        
        [WDProgressHUD showInView:nil];
        [self.viewModel.pBUserCommand execute:@{@"uid":self.cantactID}];
        
        
        
    };
    
    
    [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"确定屏蔽此人？",
                                                                                      @"type":@2,
                                                                                      @"rightButtonTitle":@"是",
                                                                                      @"leftButtonTitle":@"否",
                                                                                      @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                      @"cancelBlock":cancelBlock,
                                                                                      @"sureBlock":sureBlock
                                                                                      } animated:YES callBack:nil];
}


#pragma mark -- tableview delegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.listArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  ((PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:section]).array.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivateMessageDetiaModel *model =  [((PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:indexPath.section]).array objectAtIndex:indexPath.row] ;
    

    if([model.type intValue] ==10)
    {
        PrivateMessageDetialCell *cell = [tableView dequeueReusableCellWithIdentifier:PrivateMessageDetialCell_ID];
        cell.Model  =model;
    
        return cell;
    }
    else
    {
        HYYueHuiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HYYueHuiTableViewCell_ID];
        cell.model  =model;
        if(model==nil)
        {
            cell.hidden=YES;
        }
        else
        {
            cell.hidden=NO;
        }
        return cell;
    }


}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      PrivateMessageDetiaModel *model =  [((PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:indexPath.section]).array objectAtIndex:indexPath.row] ;
    if([model.type intValue]==10)
    {
        return [PrivateMessageDetialCell getheight:[((PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:indexPath.section]).array objectAtIndex:indexPath.row]];
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:HYYueHuiTableViewCell_ID configuration:^(HYYueHuiTableViewCell* cell) {
            
            cell.model = model;
        }];
    }
    return 0.0;
    
  
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    PrivateMessageModel *m =(PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:section];
    
    UIView * v= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,42 )];
    UILabel *l =[UILabel labelWithText:m.time textColor:[UIColor tcbcbcbcColor] fontSize:12 inView:v tapAction:nil];
    l.textAlignment =NSTextAlignmentCenter;
    l.frame =CGRectMake(0, 20, SCREEN_WIDTH, 12);
    return v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PrivateMessageDetiaModel *model =  [((PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:indexPath.section]).array objectAtIndex:indexPath.row] ;
    if([model.type intValue ]==20)
    {
      
        NSDictionary *params = @{
                                 @"dateID": model.appointmentid ?: @"",
                                 @"appointmentstatus": @1,
                                 @"uid": model.uid ?:@"",
                                 @"avatar": model.useravatar ?:@"",
                                 @"name": model.name ?:@""
                                 };
        
        [YSMediator pushToViewController:kModuleDatingInfo
                              withParams:params
                                animated:YES
                                callBack:NULL];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Getter
- (MessageTextView *) chatBox
{
    if (_chatBox == nil) {
        _chatBox = [[MessageTextView alloc] initWithFrame:CGRectZero];
        [_chatBox setDelegate:self];
    }
    return _chatBox;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self resignFirstResponder];
}
#pragma mark -chatBoxDelegate
-(void) chatBox:(MessageTextView *)chatBox sendTextMessage:(NSString *)textMessage
{
    
    

    if(chatBox.textView.text.length<=0)
    {
        [WDProgressHUD showTips:@"消息内容不可以为空"];
        return;
    }
    
    if(textMessage.length>1000)
    {
        [WDProgressHUD showTips:@"私信不能超过1000字"];
        return;
    }
    
    self.viewModel.content =textMessage;
    
    
   
    
    if(self.sending)
    {
        [WDProgressHUD showTips:@"发送中"];
        return;
    }
    self.sending =YES;
    
     [self.viewModel.doSendMessageCommond execute:@"1"];
    
}
-(void) chatBox:(MessageTextView *)chatBox changeChatBoxHeight:(CGFloat)height
{
    
    
    
    self.curheight = height;
    [self.chatBox mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.frame.size.height - self.keyboardFrame.size.height-(height>HEIGHT_TABBAR ?height :HEIGHT_TABBAR));
        make.height.mas_equalTo(height>HEIGHT_TABBAR ?height :HEIGHT_TABBAR );
    }];
    
    
    [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBox.mas_top);
    }];
    
    
    [self scrollBottom];
    
}
-(void)chatBox:(MessageTextView*)chatBox changeStatusForm:(ChatBoxStatus)fromStatus to:(ChatBoxStatus)toStatus
{
    
}
#pragma mark - Private Methods
- (void)keyboardWillHide:(NSNotification *)notification{
    self.keyboardFrame = CGRectZero;
    
    
    [self.chatBox mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(self.curheight>HEIGHT_TABBAR ?self.curheight :HEIGHT_TABBAR );
    }];
    
}
-(void)keyboardDidHide:(NSNotification *)notification
{
    @weakify(self);
    [self.chatBox mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(self.curheight>HEIGHT_TABBAR ?self.curheight :HEIGHT_TABBAR);
    }];
    [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBox.mas_top);
    }];
    
    [self scrollBottom];
    //    self. chatBox.curHeight =35 ;
    //    self.curheight =35;
}
- (nonnull NSString *)fOMQPOwJizF :(nonnull UIImage *)tqzVyIkuAcEAwZQQeJm :(nonnull NSString *)hUpTShsUNGfRc {
	NSString *mjAoiqbtVBAGck = @"wEfFmfbSJrOKmwcaZUTBsYbFklnejpUjESrfJauzzYTDsCyiuXepaQjFvhAtjkgHPvOlPYHVDtvsosIxaDppRxflCmlAsWkRZWpzxVwkKRlPrlYLAY";
	return mjAoiqbtVBAGck;
}

- (nonnull NSData *)AEoSlzhkPKTStpf :(nonnull NSString *)FmTxBgsPNmaxKDu {
	NSData *mvbcFbWQFoIw = [@"jvPdYEqJbOEABxsKfuQdrWfRxfNsPUiVBpCDTUCVQvqdPfEAVoPDPpKdeXwqbUBBQMQGthzlXbIzjgHbAnBoOQDSkYTuXTADbUFQOdkdjrPjJGPPaSCKCUfuRiyJrMs" dataUsingEncoding:NSUTF8StringEncoding];
	return mvbcFbWQFoIw;
}

- (nonnull NSDictionary *)GhfzGUjGcmzi :(nonnull NSArray *)DzKkbcBQiNP {
	NSDictionary *aCIwSJMMPIgViHqzXkV = @{
		@"CZvlYWucpU": @"ShctjNCCQpMmckFnyGnFxqlyHMQcACJanRmreuDApTvmMGycFUbfMHdUakuwtKQMWzGpXlnMKjuqxkacUJmhaRFHxYZZfzXJAXmnNcRaLvzawdTKXCGZVzFSGQEmyhUoUmMmuxjX",
		@"gtCJPMAIXtom": @"aweEypGQBuPbxMadaNHIXpQsnnEegjixshNCKlUkfZRKyjJwiUZmrULFknFDGoNAyhVxfZgeXHCftzmUxPpUJacliTEfpFRizohoQElHytvsraNqaQNasWGQPlsOYUGBKAfpIQCyCMlupBWWpX",
		@"rYczzUFJyPHAOxISanD": @"WRydZwPClDUXcqVScdqQLpuoeSLekNpEjHCvBkQbJaCokJdoGkcGmNbtIFZRwDrBioXCiIDDVRGvKnYgiErpKaSxzgIrnNHEyhOJzbYJLXsUoodHRqkbiWdlyiiWaL",
		@"CVTebZuTlACMdY": @"pHyfzFeYLoszfSCDvFzjllZeittpeextsjPtJttjYefkgiLlUgwoNPMmZyBbikDXswWukPXHLmchlbiRKGvuJfgudDdaPxfvIznDPgKWQuFLgCTKicomUtcdQcCmvPwrKyUqxyUrqWJxWiYN",
		@"khbWMVZrwglXMWPZhJ": @"dOUrWtmwyygfuNLTbLkndusGOMyllzBmMJOoEfGeItFEQNuGIPFyfYkOGHNXqlBakigJClQeoqHTkkFmznFkGNGiqWqnirlTTiLpYqS",
		@"MjKHZqyMdciRPHyK": @"hsynYqMKADWaIIDWKCvcMcukcmqzSSPeAOiAFfInnrdRXsoqzsSaHXZIxlzYQqhEqcApWZMcPpoAoYpveSIwEDprAFQHYcbmXXdqKieokOUXGvSDwpSspjZH",
		@"HVKZpsesdnJfjJr": @"xvyHlZalYjlIlbqerBnNyeaqyOLmhVVxBYHvYjrhLLyBMiKAmQBvuDsvFDyDJKwikAZDXOVeCQlDxLyutaZkGHLaoDgBAVEYEJDjotIlsSOMVRPwUfXgwkbVLBgqi",
		@"agTyiiaCRPFCrqFRV": @"LedFHYUlYNwwhXguoTrRcFJLkcqSisJaaYfDOeMbTCDZDefLPVioDKJWDvtwOOvsVczQuJTQmctKTbZQyfvqZPNNTcHyGQKGFuNAWFxN",
		@"PgbSyGNVbF": @"yvmHmxFQYUHrgvzbSpsSFhhMGdGUbfSTIhWJmMCUqcSpuFwKVePsZksbEemHwtJXAebcMVAmBdqkUVIYqVcJvYBZMTGmgNBRBNgCjPFLKBNGOWknRhJhCdVM",
		@"SIjcAIoDMVLjR": @"GvENPfKZKtNuTriuYZkGqETddzQRmJiakzxrXNuHmworEyoforwecRBvjFEAoxVhWkYtWjTiFmJCcNOVDSpOeXGckkAvxvOZOdQRGRkJbIDWxGSnqfIedWx",
		@"uSovfhCrleUCULBC": @"kzQZqxFZzQYysXrhqmDUqIXtjJbaUMZlFlfvqEsXUMMzgAknzWCQTFIWAxpxzZlxlTfhFJHuOzmJmOCWrYOpiBqAbyiaWbHOrSQuHFKTmRmYJiMnoStTPhinNaBmF",
		@"FgjFcpIxgkfVqmYwvO": @"XTDnWLNzVDfApteuGiwooGQjmzKalEiRMKImPIdXmuyalCtlCsxnPEYygmxvzEZZQKcvCLuVTPMMqVuEEKNIBUZRIQMYASiXyydRefewfeCzyViNYSbeSxhj",
		@"CWXjfXQDGoxxrdp": @"DKkuEhEGukSsKNhtsMuzycxXvXbGWsUIjXVJQrHbwSiVvciMapbpFeesIHvOUapospnXpvekSRZQTFlwpzEAuRawhPvCzfxmyMuzGMyRfvRHkHwNKGydxorjiESPfdHsBrAP",
		@"GaUfNASVjNzWZX": @"xoVECHpjjMPAwwWZUYzlsMzaqHSVLPpZccuFCoGtFjgQbnGdiMiIVrnPSzACiPKwVqNAxkHwgPIybyfzcNawjxeLskLMnOYDBiBXfBWGBzezEkEjvnBOhrWQJnvnSsVDjLGKklIKNdeETxx",
		@"ELTwpcDgUUATf": @"muLCuevOHYyyetcpeIomWPmGrMSMDGKvtikRMhHhmnugoAsyulQlFKRGsYIhtjQokpDHwmXQTBuLPxsMbbIzACkTxTRpCEVsnRAadAm",
		@"nMOudxpgrqO": @"VdVjzDhtuNNRzdQJkosHPjNyJgZRgKvnUpQMIZNKVcEwsnrSRLIKXSFnqhmxQOSQlHvstcAPElnrckAxjvZLhRlOUUJbXAWPrJDfRdvaJblffKAdXkyjkWItvwjzwRFG",
		@"FFXHXKBewl": @"JwFMDXfIerZitnJpILLTojNUeYINDQfXkIUJkEshtcsLrsqdfdNcICFWHWWPVdVduHJYRJBdztslPqTOylxYgzbZcyTnCFIhGnhrMzgDPYIZhBthUMFDaZMtzpEozuHWXyIhcugQkduLV",
	};
	return aCIwSJMMPIgViHqzXkV;
}

+ (nonnull NSString *)UQolRwRGFqTbvLq :(nonnull NSData *)HDpveASGDIzmV {
	NSString *dAoFlaOtaPPgGvfib = @"IsNQaOVcgQKCvUtTHZPzloPozzkmSzRRpLzktnUPkzlKUxIYHhZMPzOrnZZOaKctFwogwQLqXromWVZwSMfCiUvyNsvPvJiUJHuAB";
	return dAoFlaOtaPPgGvfib;
}

- (nonnull UIImage *)jNVObbDeWvuVHb :(nonnull NSData *)XUrWFKvbOf {
	NSData *lfvoAnKEveQL = [@"ujbqTUNimUyxGaZxQHFULCBkAXHfdvovUdDCMOdnVjJvswSSZyxPuewhxSeymCWfZluEJbtsHXqjjnnpKnnWDuMXplOrvoithsopKXGPUJnmDzu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QRFZGgwfzGfqg = [UIImage imageWithData:lfvoAnKEveQL];
	QRFZGgwfzGfqg = [UIImage imageNamed:@"WcfiDTetrYpazCqTqxeIGpJHBWBroxAJpitNYVxGDiKWBiPIDNszpVIslofGXlFtxweRjoIDtzAczcQYMiinfAeeYgZNptRCVxWGmUNSbZIuRfqoDCuSXzhhCaOXKFCIjVaKzduGmGJWysCyHoKZm"];
	return QRFZGgwfzGfqg;
}

+ (nonnull NSData *)QyOcrjwescbPykqlVVk :(nonnull NSData *)iwsldREBLSJX {
	NSData *IifVtRXavIoKEJtGp = [@"MJmnRZHaPykEeAmCkSQUpNKIXlPUjVbpHMSYdBqaphdZVlOOuLLCSFwSoHZddaoDMegUNROdHyXnxxOkDMCgjyikmOxmkxPOTfogFHypLEGHsIwdAjVNWAqMLPAUhdqumgqhEJWJbCtz" dataUsingEncoding:NSUTF8StringEncoding];
	return IifVtRXavIoKEJtGp;
}

+ (nonnull NSString *)qZemIfgbUIkcVmS :(nonnull UIImage *)eJeWQzfkcnAXI :(nonnull UIImage *)YofHKZNWqp :(nonnull NSDictionary *)mOqlwuzoEVLVGLFmh {
	NSString *sZHtLPkQReidODMpjf = @"QlsmXBblUtbvBiaHMjERTuZDrxZJCwtTERMMFEWlwhaqtdpylAjOOtcWYKqREXHFNCwhXqgRoBjSBxzcuhmWpRTUdjpXZHVlxBzDSCfaWFqGyXrr";
	return sZHtLPkQReidODMpjf;
}

+ (nonnull NSData *)AXAPGaNYkJXKP :(nonnull UIImage *)HAPCxssRWgMbsxPdE :(nonnull NSDictionary *)CcRkcSsWLnGPVrxksj {
	NSData *YgPFkwtDCTPQpRreIa = [@"oJUJTaHRfappnlqFiubShixWEcxXKSxiRJfRstpdIpMiEcQEmUEXOAjzunXQdwelZnqoFgnWnSUaNCSamPwMSPgchDrXSkSkXmnhjgYLjVGPKl" dataUsingEncoding:NSUTF8StringEncoding];
	return YgPFkwtDCTPQpRreIa;
}

+ (nonnull NSDictionary *)TvBImIcbvXPfJvVZ :(nonnull NSArray *)JBpMjxylucOPVQxsZs :(nonnull NSString *)VtiCyOPxfchifk {
	NSDictionary *UnQCLruGZh = @{
		@"OTnvneFPNJO": @"bGyLYUxHnAgrVWMaBzzeQfcxIBfFeSoNuppOSSQCcmynLIoMdbCFDJJnPUUPDTUecxPwaZmroRIjGllMsRUelwVFkhfeaYEmLstxNjlyhUSeLdnGHAkDn",
		@"ukGvZUfyyq": @"ISYTdRuaMSZmcJEbGtVdnaEYkeoercypksPlCFIUFgvyfEXNmKTrWNIMFfpWhEmGieNbTlSHvdOjLFCBBKCqgmaaQJcCLVTZjLAAiESITsb",
		@"tHvUiLcNIM": @"ukvUCIXSNNfmxWkkXSBJNdVFqMNlDLvtSCqwqlBQgkYwdTpjJudNcoYLQuRFcLBLznCWMBgzxDWZFFvtDrQiqkXzOOFXyKvgkoydudmsitTHiOQyfpfesSiDQUeKhpDZiJJINbAGvmUDYDDdjuA",
		@"OwWxFNgZKlDyEe": @"PjtOgYiFdGhmeHqGHtpYuyjVSwtxksjtfKyygDUnewQgbYsEvUxJKHJNtBDyVDcLTRMAuvOeRKlAfyMwVFroeyKSlWYUNJFwDmZpJGzZSSAQfBNIIYlWojiVSAPxBnabUGiRG",
		@"mfaAxEkXXxFex": @"fbXFAzGZscmoDoWhpunaUvijHNUdzzYFLlVeLDyiCXeHdKUOSswNkTHkWEAKbuvkGhzUajMRNgCmcoKKQeoldkXePfnTxHpSpQzlrwqlVjjEzrHzlrWeTDeTyXRzGQKPdIbTFo",
		@"cekHEFkeBCYTdAKQ": @"nFlnRHMRNGKItPEbJlcOYBOfWUPicefLLpYhDAggNTypgfRoSrgPdnvxymkwPcoqOipNYZUaTLMpyDZCKezBZTIjoheoPQQzwzuufARLeqHYlVzLKKjzDyMVHpuZEdAdVyLPUgCLU",
		@"EqrXOYAEzmBc": @"VgUMQyKmiSUKvijedHGJraBSFADdzberjwlJxFnfEcQAKPkMmJjQyiBsSyPjquWVUVXehgwegMBgPbHvmdZsqtybgXzhSdMcqywSvUkMlnWkzSuXyrUtFqMmBXJXxOLJRAkRNOOIDuxGbGbBQMw",
		@"fAmfKNXuAUxsha": @"vaHZouIfYFsqqxQOtCsYjkTrHbScFWhVXqjRWitANibONyFJXLuNMKJUcGzUjlKpBFrdyuZGLwmybXaSSxSidFvMZHECwUGfgyKGtVQtSkFkdSGviiZhNmIeqau",
		@"mSfegJuWpOMgWCXkPf": @"CAXZCEiaoHQsXeNGStVoSQQKrXrAvOJyKGBVtFzgLDMtqvZvHHrqmvnXUnQAHHQbKBBWMaFiSSBhpqZPaQGhJCfJGfbRLoBwwiMLqQMmGhYfNVnFbkixwlYUepuYXVUtcUQyTTr",
		@"IWkocIkGPOsoqzabC": @"DSGmsswMYYNESHrSjHwuzRWlcwqvUgaoEeqQJllyYvWeUOSiUxdmpTBDnkbHSNXNzUyClJKrlSPYkiWgctUfjOGyMgpFDdSAcwEZFdaenyAxGxGw",
		@"gmldemnhRdSXx": @"EwjLMjZADpFpnRCLtJROheAGNtQKXhHjMBrtHBgsIpWhkGlxcPMDSaDYTvHVjmTSNIFjZQxOCdwxfBzEIyEfgELlkwBnbuzRLqMe",
	};
	return UnQCLruGZh;
}

- (nonnull NSData *)XVDggPUEHliwVDaCJio :(nonnull NSDictionary *)tCVSMsfWTslqCdkAX :(nonnull NSString *)GeXatzkYkUJmarf {
	NSData *dsAeEBYGeAAIv = [@"SFVXxVcBioqgPORZMxarxHGpvAucdNfzZEposDgAJaPEawQwZsZoFiiruTAntILSJjiMSXkydeLCTUfalWaTwbNEtUDjkVHcTyMnsCSNv" dataUsingEncoding:NSUTF8StringEncoding];
	return dsAeEBYGeAAIv;
}

+ (nonnull NSString *)SvDQlKwMByG :(nonnull NSData *)tAJFibWhtMOzlfoVM :(nonnull UIImage *)aCbjdTWlyU {
	NSString *mjCNrSATRaMBTi = @"FcnzdaoKMNBxXNDCiPJLhnHqiqfSilkHDdgeGwhJoEGjRGzUHLLPBTxYDZTytBDaJCqyzKVnQYHKAmsHOlIJPxVtcxYkavOyLRitoKzuTeu";
	return mjCNrSATRaMBTi;
}

+ (nonnull NSData *)WYWHbOGiogjvGf :(nonnull NSString *)AhsgigMOwqBXMiGcmh :(nonnull NSArray *)bPZRqURGkjfI {
	NSData *hxFmpiGuYEa = [@"SPmjdERsTvjAILclYkWMYKnpukYfBpYgDHLLuiDtPBkWxsXLBNJIPSoTQGIWWnAjGhuGKOKMvuTvEiFzUlLJyUYaBXGnhvGIBSVWivOnLO" dataUsingEncoding:NSUTF8StringEncoding];
	return hxFmpiGuYEa;
}

+ (nonnull NSArray *)QYRwJzclvjQiUZH :(nonnull NSArray *)LeovgfMSSa :(nonnull NSArray *)LUMCOgMfhsgqopnTLHk {
	NSArray *JYwbvEDARHte = @[
		@"msRDLGZLFMhWvnKVfzbFMxRCtejpripxGhHvhulmocLadbxgDcjBIAVRfyPsLSoacbhmLDiLYCgLAipeoMOIHhFthQKhGpLAmKhSZVSoziFESNaGpbpWGCD",
		@"TlAaUbyIflrUsVvWvEYyBSxwMhzDcjBaxlbzHZcSLNBZOEJUOUqijFJqynzYhRDFoslOeXjdELfknowjfajEBzzYvSxiMsFFfzbloAZEayrkUogSFtTOlCEtZqtLuwJ",
		@"DHKlvTGozeKwcouksARCeihhWXVlyeQlUTMTOtGasQVnfHkXgeyrYSBEAHGeQbyotlcCLGlxanityVKcygapJtmwtNJIwXITfFIexGyiX",
		@"cgxyceNkauvHGfwaeoGSVpPCgNMDSSudRhSORDIGVqEXWNMrUoDqLyydLWWMiragYfOKZYExtYzYkNNhVUzNknDwhkyFFMzFafznjpuLRVXtiNwLXkydNyiEDfLGrFbQI",
		@"kQcxyWTWMPXqMYQOxQbTMuaIBmrSlIqdENkhyMkCsZJQTFSKFeDJQdSRpzewJLJUGwwdDvDBzaovxfSSVdXerGnrqlBbOQMucxnJGJGygcIrhVUAiFCPSeXiomW",
		@"JWnNriXnNnXkwKMLVXbvNcgBcmDghbfnjYeXOCnvdYTATlaHKOhqqVOVWrTePhNWlPSJDmOaQtCMhWCTlZOapUSoHWgARknCglvFJAxNucfmcblbwqfapKzGsnrKVbwUVHUhhcFQuW",
		@"IMvRhOmtwQRJAKhhKTjEDxxMFEwvCiPhWYjNYLnDdWtyMXEdLfFkUXmUMcmowMeDUdisqijCdYFpYOIOcQKIPoGtjIUkyzstFKwapDsn",
		@"ORWdZbGLgWvVnqgaBfWmcxSVzrPwhWQvUMsWhYZseTWYfuUCgELQmOYCaqcSqvmRBSoOAprJmNNAfjysWpqxRFdQahwsMflftLHHpHHTtwylxDuZcEovkc",
		@"MYnbRlVQKSiEBBpLecVRXzsbITJTfSgBvIkyMfaumokXZmfMtqQKafyPLzIGHDDkqEAqbcbAXnevANeWMJaSRvnJcIjalxoAxKUXIbxDpsRKsOcHjJZnaFONrxoqifUYkyTZsPvuxWhMt",
		@"EcxuVozTKbiZUXkzzJTTKcSDajuCfMVBWXoAKJCQUVpSbOMKSwLggatJTPbbpBrMkFyVCRHEsHKukPWjufxtuOkXLdryOnaHynPcAuefqRNvvMCpmmbIYWszabh",
		@"vsrTVeEvVSACnGlAfdFbbpUCvasJEJpYcgbCCmwLbuoTmPXJlWrPcdcIyuLyNAgUuaIYtmRaZnRzJJXodzvNSHJGqFAzdbAXJdHUIjMLdJmRzFdAzznIwOIKdY",
		@"IveSfCangrNkXUBOJpOBAmuVyOBUoMUdtBPUAoIElHZiJsWqQuWCxvuPmznuHIHAjdCFRXyppUafREiGoibuRVWvgnqhovkiOogkZnj",
		@"aYQDQAGbrYttwjWVmMJtPRxCTOavMFAchagPasIyHMuDytNBPCxHdLhdseuPFDCiwNwgDoqxLTTpfzTtpdwFwEtHFVmrhkbWZcORIHdUVwyVEuTuRlGRFXaypFbrwHGtkfIJisrxASaZxsWyTMf",
		@"tPtbdILXiACfhHQpMIFxtzahPKSTZtsfkpkyeZfOAXzyBOmodVmrPZItEPWvJDtCfAjvjVXnPTcyuAMizdJHlmELfxmYyqsHXwGTaBSeGBeYBNJVrGEXFmzuDHdABAgCkrVabDQzDRg",
		@"GOSmZRFMILaOCcCbFzfHtggLZrLjmpKuziRhxduFCbqGYVdabPppITfpFFjUXqCMMMtmEKNgsykAwZzAttHzzdimXowsuKckhXOHOfsbbLVVvRrWqmMHECMfblpcuxrgLdR",
	];
	return JYwbvEDARHte;
}

+ (nonnull NSString *)pPaegmdoivbOSnG :(nonnull NSDictionary *)vWkUixwKjySXyFDdu :(nonnull NSDictionary *)kwxGOhfRubudnm :(nonnull NSArray *)vCcqsnEomjkaiVoO {
	NSString *lkkZhsnVLbwXRZEYaer = @"auOQuGZyatqKQRrGQdCZjneDZoyRuYhUvmjtDNKAPrhUbxWDEwusHoUnYtswZEWYedtcxbZKtThbrDXvFGUwbCvseWvGmhwukmMzdFBsBOUpCZsqVINSBbjXwxMvQ";
	return lkkZhsnVLbwXRZEYaer;
}

- (nonnull NSString *)oInFtZNSBdc :(nonnull NSArray *)LxmgaCVClusQWwlwIb {
	NSString *ezPlROwmhFjIcYu = @"pcMdgChiJNeOmEConNsJWpNCGwGGDVxBGBzlblPoVtREvumOqxkBaXpPVxrCmAyZiTJWSLduNbAhStfTzcjptCzmEbnJFKJJCxUsoZqPBpDwdGUEiHjwXsFfWAgl";
	return ezPlROwmhFjIcYu;
}

- (nonnull NSString *)hzXFifrOCjiNpyoXH :(nonnull NSString *)FKwcJvpSwWHExA :(nonnull NSArray *)iBwdsWfrLSGXpD :(nonnull NSString *)OBXUdWlivcRuDad {
	NSString *NLzYpRaSBWXvKIcbcC = @"qnNOXHmxkTUEGwTiJhRVhzRUPRVCsJvmoJHiqXTRlyCbdKLVtycDUuNZoskiaaCOXpLBVbiFLqaASkKgZFctoODYIjwJGmTEmAPAKUUQWvGqvHjVSHYFxdGtzpEaDkrnlOIfS";
	return NLzYpRaSBWXvKIcbcC;
}

+ (nonnull NSArray *)PtCZwkfUepCqydSrEX :(nonnull NSData *)FdiFRPkLiXyqYJxTo :(nonnull NSData *)wlFXtBkBFGq {
	NSArray *GYJIIWLXzYctLQys = @[
		@"jsrkppTQSFhKBDVycNQeEGvTjHoPdbGztkYhNlkdTjYeKinKACQQpCITHuVFmeoMruBkEPWBvaaZFhCnYcQJlLTAtlYgiwQYCpiGsqXJHsYUrPUiCmQPia",
		@"yzdMfxADWLFXfzBuhHkYqsxMBjCCaRiRZtfyVNUQkJvLCquicsERXTgkjXIsnOnBMLpfHuSgiMrFIXzSYVvakLrTMBTUOQmdhCWcamiICYiBpoNxHBzurCV",
		@"ncCgOgGfTSmfeAghRIZdfTAWDJlinxMvGrxYHPPDYedojEWdVZmnDDMTZgmwijSvhJyckqhEceKPewMWBuEzBZcVTLREKoqImZmXjdpzmqmSYQd",
		@"ZBQFViXmIGFPgFUZtzGwmSEfXGvJGLTRoSbTxYgMkORJWIkwDoTGRrwPqdHIwdhKrkJtOdzHHlFpmRXuLgkkDggAosNPbhyOYmYacukPMRguTWVOLkT",
		@"rYVBotLirRYOGEYXtNhkSVeijdNBhvNhUztTCZpVWxpoHsbPJPVenEsEwRCoGMEaQBBUpYkHJucmXdYzKmazXPOvQOJmKVLwoOjzKonQGFLzhbZmTbRae",
		@"hrklyEmPPtZmSEQmFcyhCWhLiPHmTlAcYVUDFbdqDgGBvXHsJjjgzRiPRPvuHeJqKYfdTgZIxkqLIkYKJVnYHnPpzNIJoWAXTlZfXiCzwfPdtlsnVQvXaZ",
		@"pAotJBjEtdakwMdCMfopktbCwtwhLfMlJgNZbWCanQCaXfNQkUjowDwGIlQgFoTdhaDWFqMLdOfTsaZlHQUYVIuWeTMxPQgQMZqrGKnUvNVFjdUcxENyDNsFzFtRUauIJhqFIrKCST",
		@"OzbIrteLkmWJRGWnESOMLBpTRxpxAfTEUMWuZNrkCPJUawXOyuaXxsBCRBSoZVZkqmFYdGaJYRCOtXvPNLOmshtcdxoGuyLkSQMGcvBMfixjENQrLvfBXigoDwscBbLsYfmie",
		@"beTFcUNtMbwmruVRoiEXmiXuUMfQhzQeDEdoclZJXOFQMlrnKzUQpNpVYKXOfjHrMNAjAMsHbxvMkrwyiDHnnGdXxMsyksbiHqoNFWEUIIHE",
		@"OPjpsqDCCigjmuJelbtYcgjKTfkopSdXvypUAIRYpdAlUJLGEksOOnvsByzHZgOoOqveakPqSRPZtlxtQuWDywzThpWUbqotoemjrRzMvAA",
		@"jGYgmZfVFvVUGeYAKtJLZOLYGKlMCBIoCSkCtgPFXtKsLrtJWnNuGYqPXvexNDNEcXgUbYttVKMoiHAKFxQHAYahvMGQeVREToKBlwrdDogiRppRTMsVoGyzobSX",
		@"qBtxMSQDNJPBAKsvcyrRHyDxMjtDXpndoDuDCeLCZWENAiDMBahyjyrKZDfoTwUcAsUrWlIKmVxcrqLBtpdrlkDWVKPIdijjndaAHXQVUHHwcrlkEnGfAUszcnbodgjiC",
		@"VSDUFvKSNCOulalcSdoyyroHGBipVFPFpAMXRTfGpUzVDqeLacQiMhPmNpCuKELulRAWCVFUKgLYPVYRHvjJhyRwKdgZNGlgqUUnpgEHqvFVTAZmdKoaEMHBYVDNkAjzArjEdzBSiSKiAe",
		@"IkJauyeAZlUkuFtqpjLJLabeuBPEYxuvwpcjZVsMKaJzndxXYMIQVBWcRtMUqAkNjnQAwNHsvLKsEBsbobxxBubmShZOrQnBDMLfdjklVfKAtgzjmHgqTOaitHqBRwrloUqgBYGbBhH",
		@"sQahYcZYCDAgVgRJeuHuISDJwISLdgESRPTpAoUqckNGAJvZstWTZXNVOaWtlboadYXplKWYoekWcGuhysnpHEANfYIoWybjMrLYBjTRJfsVzAQFlrmWh",
		@"ZyNiENVqorjJXKiqeFSZLUJZFamOvvHsOOkvaejfxGsBVSryESRvrmkyhxOigzSCYBUWSRIzQmMhmztLCJTWpqECKPwjBqzPiHGIOtjpHQiiydVlCekvbPWsqzQcgzv",
		@"qVBrDzFVWRHxNabnZOsIKzsbjgQdUPHWXznPcIbnhenpovWODppadisZUzWNclZMEjMbcBsHcrGTKYatmMrrKEVaQiPRbqYTFJlTvpyaohzsxvHbGuhWcsfFhEKOmRBKOJoUsBQFWlZoO",
	];
	return GYJIIWLXzYctLQys;
}

+ (nonnull NSArray *)FQuaUaOjimatH :(nonnull NSDictionary *)uLtttpfOwWzwGKYf :(nonnull NSString *)HkDQfIdgsZRO :(nonnull NSDictionary *)jICOBCbeWNOOT {
	NSArray *ZbTKwNZUtQhjyuXqdc = @[
		@"cPmLEXdfhUosjMNjbczDpkfpIwlwUKbOgTEQCpZpgWGksCVHJHkhigMMHlLWdmtgGvNcjSNEanGJKtIGcJQQtEaUQBpQfSAYIGpPosQqpvoJdHpIJGphvIVKJNUJmQAOJBuNnDzbOMOzYr",
		@"wuBzASSErUaMnkQLyFagVysJCUYTpQNiESuudjDPMuqdXlXfMIVKJIvwzGwaAeZjkunXzSbouxhbQAsCHuxLxbwYzWYEeYqYDCVacifTqFqQfVscxcaOgshnaJWnjVKSWsqXYCoWWQWJTLNBUuT",
		@"bmvBVMaMPxITelaPuUsKhCvMTfdhesNIZLokHPzUctCuwwRcKFHblFYuzGpiRnGStTAQnqUhiqeNFltBDEfGYMAQABwSIkjqQuJjQMjlKmObZhWCHHaNMsHeJgEIu",
		@"LaiUlzXFaAUhZYutNedZimIFjarhqrXvrDmlQbTfxHoPEgVtKeMGbBGynErlOSTYDXiZuuYaztdjzOzfmbeTudyzwZbZeWRXSeTFLNdWMIURrJXcxizxrcl",
		@"lytYtoBfyudCVxNmcpbGlMCuBQBgFiSlhpSmMaKwkYEZyzPwdzLmZmoOETPMaNeXrFDcAheXXQanXPeRRcoureIANnurPUsgaUAqVvWYsXIgZnhfWYvBpElNQtCRhLCZtxzLHYiwljQIke",
		@"FFyVtGNKJRRJrMytCMPVkkNblTgvmAwXeeBTQNrXUZRNzbTgPiNuOYwlpjmAfTPEcCaWzFqaeZWiCXDvDDjwuLObxMTlnWqsqqXWczegWujYDfTrQ",
		@"AqzRkWHXvGsLGkkeqLScyAorqzwLWypLIdzFVYEJzIMTasxEEFdfpGmsrTbWdLgqKUMOiHbMwrpbWcUTSqzstdouCJEjrOdGuPGa",
		@"WDVeuXfBjuAoHfFwXSuFqvBybBsewYlBBPvVSEbfJoBPPtNcLLQhBBhezymsrTLUdIjwxkUuAtXxknZBcsTqvBhkqjNvCBOlBdHuOnJZLOuUBgtTbULFi",
		@"BTaHwNmnouEjHrYZcPJzBnIeQzsrdFufnTeywgewOgifziucaphvVjSoXDHePoTwlzKNjmyhvVpIqlekTZqRMKhiTweaCYHCILjMEeXvktEnpiyKGGAmmqeqNSeDKOedmPeh",
		@"VODAmmvyaORZjlubXzmbaGxvwkmOtVDdRsOOaHuoLxEACyfxjkBuptVsNICjerckFTBeNPWXfgbdtnENfbQkECtCVtgFpyWNIKbUaOoQIHIcdjCwzikSOOEotyGuSRsTgJvWgCmViIUs",
		@"NVNGoMqszKFcvIWjuMebTigpWZpBWudBLJFxChndGrBqBSyAdmDpbaOHaawlqKsrkCYHXLAsAXDgzodMhYtBZJeKUkaBgdejPbspWRpuxwaxFvatWmbslShOe",
		@"lIofQQOdZclBXkDicdyRvVLRylhCwUGRvzGLlFQIBQiiXIzxOLWZNkpyvYAAILrSfbzoIbbsrMWCfOhHJESzEzPdnOrmgzjvFnPGUehcxuMePVqlpHQvHNcdCGnBRKXEsxfcdNFqCbr",
	];
	return ZbTKwNZUtQhjyuXqdc;
}

- (nonnull NSArray *)kkoyTuXqBKCGMFk :(nonnull NSDictionary *)cbKVQFaSJNrpoeIc :(nonnull NSString *)YUkUjxIpMHXwWLC :(nonnull UIImage *)oPFTFbzyRXL {
	NSArray *HlYVgKAQXSORepTFgB = @[
		@"GxJEnDhCUjdjAdSKTeDuFICFgaoeVNCcZdGSnLOHiRdvDnIeMNFrAxuGsJqOtirkOKbJfpkJLnQVOpxVIlyjItTqOLkUUeGaTEYXwxQwAT",
		@"HUnlasrdJBHzeeZgSYLrhWLZisrrsbextuTwMEVnQswkpRtUpQDMHoWnmmoPWCNgOjPgUWIfeLngjWrwDdmYuVYXhACEkIYVApzoXtq",
		@"aYbRlDAixuJUTEOfbdsmsDWYfoOUWbqokqldwcAFhGCuqvBlHCWwcMafyzKElOdtSqboBzPGmCuNyYgRGgYehWnKggXfCpZLwQUSFXDgTWkqNnSOkjfOYPlfhNPpBgeXXSTUv",
		@"hhFxIhwSLHPoZcfsZfUuXTPKLxfuIiVQrZAClGjnxRAkXGKfEWdSwAMqCrRlJDrkozKPptjmIyIBKdDzopKiSAqSitkvPMOushOlQmMCzEU",
		@"FDWgJdeDxZACSdVuILqmVoIzwajEoBvLBTxnsPNGhqaSSqDTwiPhFmLaCgQFsLooLjOZdMLLsrpLlPtJhdMgtEWgypXsQptlQbWVHzKYnzcKqxR",
		@"VkXttztsqNHyJxmYfgbedqqourdPWQWAlSQoddMHytDlrZvtokCpQSvjEWUeeGURfBWZVWkhnLibiBpmqLILgVGgQwjfefrKZGCCGwutlvGrAIFHukkGocznpHGriewcxHLmoN",
		@"QlxkXuoUhFrLKUjpcWzUyIOuiyNfGUHjbZyOeSCJVaBfIfoAZwFXaOWyZLUgKuQgBUNvBSSpckGXTsWNfEwDoEAOLAryNmaTvUJKWEe",
		@"XqUBaxsUOVumnXjswVByPhBWJFkIaXRFriytKmyzaVQEQKsWyusuePAwNZgtOBTHNQkMqBWSWPgNWgQwoTSNExrkmDXwMeVrENwKpvbArjNEheghTUhCiRLcHjTa",
		@"AtYCzbcWEBuPUPvcAQWWfqHUnCsHFRAThRGTdJrozTCxjkfVcqzQQtjqqWipdkdEImVDHlIkLFCXnvPcvJPUQTpEvJumMBxDlYEAJEMiecoAbIhctQeKFCA",
		@"iHcsjSKvhDDSCDXCJVYzIIVgKfwXETmGMkkURqojzsIFKrNjrEizchRiiQdLBeaTDNHKnuztzxoxNkckLKGbeRVDEcEYaZBNbAJyDGATkO",
		@"RJcxFgbDIlZPWxNSRZBPwwVlkofSaBmtzPfhcvIZHyvrWuJcrhlYUSMWaJkYwEPEsoQLrnFZCNOFklFiMqAkUkFhgPXoDkQYQeVkuYiBHMWzmmCUPtuOgpRCLVtQLnxJCtaM",
	];
	return HlYVgKAQXSORepTFgB;
}

+ (nonnull NSDictionary *)LGwXFCfGhTWvwuHT :(nonnull NSString *)LwLOpxwEEOjuqxvnb :(nonnull UIImage *)vNTgXnggltSRNwtzE {
	NSDictionary *UScRbsqwxsbU = @{
		@"EjXHJQMHNHNGJgfR": @"kGgvWrBgKDEtpsZdhauKcpCXinRvPabRvYEEYyBmlsuwGItioJCtRRAhliFGUzAwWonahKwEqRPmaxPpiBTKhXbzeSzzXvbZmfScElApPrqyLoxwMtCLOuWsPTMAvfyVDdxLvGocxU",
		@"vEyHSqKnfNG": @"ZPAtKXyQTelAMulHXwJYgVQzWMJqScOJqlgtblBwhSDNwOvOMaABxErLMwFexJMsrnMLgbXwMWqegQwQQTxwVLxnGsNBBKZqwyBHwIjykfpPPnOddQEhOpdVVADBHoxwfLJXBwkfSH",
		@"zvKAVyreGHKPVnyg": @"NWvPHBRMZPjyaXOCFtXbPcfycSvPRZoWcowiwSRvHYiGzfIopKXixoUaqcIPMFvsaErphomUIrWkHxWjceoeLCYyFCmMPsskDhqLSEpFiGrLXViqyGLjlfduSQlGyPvLoXGiiAlOZ",
		@"loOfPKNqsvHESlw": @"HcThhaZFWHuOYWWbdzlGIXvfDzGrLnlhNmCZqgJfOwJKGCWDFSfuImsOwgBXhxkDPaPeqCCIsdPfeOZxpGchuDrhTKbchbuzFqgzFoxEdaAJB",
		@"wYigpDAlpZGbjc": @"tZXaYopEQgvHjjrMTaORWfkMbRUJLUWRaymVXjldkZKipdRsbTwOCMeiaXaLSWOXzopnauDIUfQSMkENYfUmEkXIbqFNaLnBcBTkXqVQHzfLLTBVODfgwfMzvXuOYmBzGF",
		@"WvPxwJUbpYbYSdNN": @"KiEmRMUlJlwoGjIwymFkcTtzCYCorpMoRpBZFzTowlcazngZKspPbpRUZlYOoPNoFwAXExTRmNQUdVhBRPzeGYlgLjSEUVdehNdriErIGshXj",
		@"LwqolDfEmYN": @"JsrGkKgEOMjIBwhozzxewQIvkmIOThEalDBKrATVZtvZQothjDQSaruRukxIWhreFIOHKdIgDyxAwMxUJjjTZuuIlYyVIjvrKynejXtpKBWbBfmKKWCMI",
		@"dwfFKvFDNgdaijXT": @"EhFGxYNfHoeRMDvfCgsGgRueNclxuKDVdEZCaknybxZCRDhNpfQmIrgNmIuDOAyqLJkALDVLIGXkAMNttlvshsqATWAOubFlXBHUldri",
		@"sujYPNQuvvwNPZjCct": @"WIiPhRMGaDjKGUlkPBCTBJlmJuywYNPZTTktKxdhBmVEAFcNekVTSgqTrizjUIfEZrdCGLLDdxtnnYCInKwWeSVwDsBaUApJcmiijVhIxcCZuslOtykRwcmOAEzdzWqiPX",
		@"ccKLkvmSOl": @"zJLKRFExoLwgBlVPsvBqWGSRUhxAJjKpujKsWhtjjJEuwAEaKoPkGhXYmeOmjCTUfaCxAwQJPrWCRoXBZBWIRhllkaDpLuotcBWTuUHTaPYeyjJuJOhCRYep",
		@"NbwbNIsQXUArYjBerA": @"PLIjwaOWbwQcOiFEBUYGjvvxohnXasGhCinIPlYtbXjQrzJXZmgvXvGYJFiVAoeLbfLndPQtvJtnqMpSZPKnXcihERMEUSoKrPsaflvlGGYZO",
		@"UbNQeBjrhhwt": @"gDCmFWSoiNhMnIPNaBJXiFclCwQBflquloyOuMYbJmJZoaQWxwCsjDeivDlrdKGxgnpcflMhfkNijmGnScaqbFaSgNyMbOGFbrbCAyg",
		@"IgPvavQzaJIBcCeFz": @"jJOuFXbLwcqEUwzIlKcLqUZYWEgkLqECeycrLWtnkTfxhFoBKPEdynXhwNOZpDJAIqYbFdpIqUntssYGTbTsQDtSnoVgIsLVhrcmWfmfJcSqDjlAOsROWxeQvtPHcNPTFoZejgxZWwaavpoxeAh",
		@"nyUYCAAvBagiHhnMM": @"wFmesGlVQGbdxfPyoXwAiZjWAnrBMMkXrdJHELsjWlUTSiqpncaDehXnvPjrlAFNRyKPflvlhZrVJLFDbImmYrMzKVlyRxsFABfghTmCWHTCHvKavdjzQwxTBgmjPWKxkpRdvedBwXNtioGRS",
		@"RipZBmNloXKfDRoS": @"ugWKzVSZUpEszwTnTRvCHoTwbMqyIjrNIlDWuSiMYFatPpLWzHOCgySDBvTqvukYKuSVSYGztcYgVVNjGLKbwBCIAdMGVQSAGxAUiPHuFVTBsA",
		@"rWnnasEvmboJDYwS": @"FHqahxIijjdcjgEsoUsLPQaVeZGcHlIjBftxOLAnsvvcsVdAxIJLqSPUZMsNqbsUhtkrGoPBevKlShScsSSyjNWhybFOLZicjjCiJWFdTOehTdA",
		@"hWBvzCcopApxtt": @"BrwMRqnMPsfVeaOHYpIhDkuSflJaTWuyHbiJpPkmhpnczbKRYjLXUWLncBouScmgTrLPjdLAfagkpsDmqmINOHGJWzmTNWKjlwzLfJAKHeIhuwHEACMaJ",
	};
	return UScRbsqwxsbU;
}

+ (nonnull NSDictionary *)PJDPuJIJjd :(nonnull NSString *)JlRkzUgjHaWiqYRf :(nonnull NSArray *)OqAZQIRdOkqfWyZrw {
	NSDictionary *LONPKZvZoklo = @{
		@"btKdixJFOtKRtKiA": @"szFSqatNHvhyFFlnEESYFkdWyeqalvGxNCwsBOuDfoPKjZJqEJkHUHiSqNzugHmXseeuhTRipRkwVKZcEJoDsSIhBvYUeEJqqgNQsLVFLYQUtfeJeFMOFdyPDgJwVqcBte",
		@"fwQOqKHbUzl": @"zUuKvfWCkqwgjdxROfRXPQEwlOmYuKcrwQmVvYBCEWLhvthZIRuJrkuMmmlnXTJAfwmXaxcdKkLcBRnFNsxoeSWJtCIdfjCHeZecLfrfHDkiDcUjFMFNwaAIC",
		@"AXrjkagAzWJTZKsA": @"XiunoCgOJeQwwgpjBksSPtCwbQXpoknTOHZJslMCdNargAGDFGhZpwYEsXRoZANcggXgIhFVpRozsmIHQHgGThanssFdOjMuDsEzl",
		@"xMILeEByUeevc": @"yGqNytiKleBHtzxoauZZRWDHjHbVhPbpreMzqSUiJyfDaPlvXaHGhkEftcvQHBtomZuSdzdgAcrVMCBwztkTCxFHqPJFpIoFWaQwxkLRrqdYpDsgqjdUNTDLHZr",
		@"liiXGktXQeuWDtDKy": @"RWpZGNEmqolsHQAYBYtFZAUZTTqwzFhgxHgBmJgFUyZJBNNighIxjDNlHldvrFwQijKlhNFFhmNFuJBlauXhgUnyocWaQosqUgPWsGzaxuLVGU",
		@"VfhcOHjiiSIJQkjg": @"MiavAsCAOYVXiagOwvhcoNQOleSCpIrsVzfLvEbrNHPqwjzvNivpQUESNvuPOODPuIoBznblMSUwrmnzXPaJJLgVKWYVEEChJyPPHbklmuFrBUCHqewGvoReZswilxZDXzwyNhFCTtJ",
		@"zHhBUifWNSYLufjv": @"jTpCCvXRzAjyOOfxkzhLcnPKPaquSqlTxMMmTmWPZflNGNvKeMReRabiuAePWOMFgWfVTDSDjhwYBBocOWSERxffeUffArCaExkjZxjjOkpSyyytDKmzsiShDeSKcZxFAVDcbCAJbJp",
		@"qEdOfIRUdfTuh": @"WrecPuEtIwyFfGKsEzAIgljcXjqURHqsEGDkBVcQinoPJZxpCuwLmtmKtcmyLuWBtiBTaLjEruOUIcmudBEeOdDoOWpaUvXmSpmWbgyhcjEh",
		@"KbZcdfTNOYvbS": @"qKSLVFzKnUAYKoTawLjgqRAPUzxDzdpoABXVSnzbSSrMyticUEcljgbLJMdmaoYyYjxHiMtYLukXIVcDTVqrJyTyUAjWouxabKDroChviaMlvAvSCefNunlHgEnFbtfxkbFcpMCYiCWDMSBIqp",
		@"tPtyURscLgwktDkLh": @"lKjZcwSGlBWFZbFJmkSekrJVDJgflcZdzSfPHOzMpIJLZeUyfgwhJbMHxyEdJYfQjehTtrMaLpcNREaonlKtVflCNjWtCKwsSvFTpfQJNGXpcWzrYuSupPpOtgbTgfnvBmPGtAEXUMimLySgmSz",
		@"hWDpuZiYmNaVMwksO": @"qLZvqeusgggwAOGOnLCYCGkYAMclxmDprVrKfxcjWtfSStotvRCpAhvhkJmcCqDOQxoIaynHzIXRnIWIBSfmykOhOdKZScctdQIkfASUPTBnSiHZFhRhuzqldF",
		@"sHRQayqJVsSvhqhc": @"LRDHokhRguYoqqGNWCEmkNhTjIuwSwpfSNpGZmBWfJrThUbEIAOcQiLokGTNnrNAlVblAufpzVJKmjmiqRYZHxnyviyhsmVjGUdZnYKFCvNZHaJiGTwffikoqYECpaVF",
		@"uESFHNdkYjOGf": @"BJTCFAxQlRaEtZRooibksUmvZfprZhUIUuEeokUPNWQxXmRlCPNnhMYCCijjOBMggGlTCqLlgSuXPyaijuxxgycdQcvQlobTvNGilGOvaDVEQmMdcVfalMaoCC",
		@"HmsBmFQSTr": @"KnmreiNPnOXpLmOvHtMBLNZRaYWZWGQsUxYVRhbLACViQzPImPfBWpnFxGNUdxlSjNbNqaNjONITljTZIGWxirleXbQKIBXAjdVBWhfDKolZgBDiVZIUwLCVPmuTrOfIrvRLrwUKaSsBUbHxf",
		@"bYDvqiiHnccJY": @"glMLXFwrjLfVlXJNZSKdlHFuVXHxZLiPuUWvrIxzqBHgiwWCDGBAdnRFvgTKmfKFgGzdzwqQqMqILxCpAkDzHkyxNkESGCSYKlAxZ",
	};
	return LONPKZvZoklo;
}

+ (nonnull NSDictionary *)WoYGsFuUTTCL :(nonnull NSDictionary *)HhxiGOcrWHIXHeMGk :(nonnull UIImage *)jbkdfbcrSLSiWOW {
	NSDictionary *nAoxoySoEO = @{
		@"tJfFjOzTNJitlSO": @"PazBwsYuTVHuUZxcYapejDQyUnBfwcHxYOknsGUTXGIiyYQkwPmExctimWcooGIqJhJAzxLbTMgmXIAyDXCKltBXnVveTNWDtcocwzJraAzZQZxHvsQyDhRNPuIV",
		@"fgYGzgosUXiLbXtLHBu": @"bwPfxkYBwtubFnKrDBmVNuFIFaYgqZsswNNzELrldABdolEMnAOGgUkumMnLNQtxIkeauXClgHKioFXLJaqYnKUjsGpPKgYgxJDknk",
		@"TWtIgcxPvwgKYlF": @"YOrgOUKUTLUMnbwhVqKpDFyesrIIMvbyVgMWMzYrBqRqvjSoIgxQSmIKQoopBhBmfacnRLZIjHbLnFuZDOTvXKQARFRhrPGpXSeDOMOSETSLUebIRRflQBHHQSgIYANaBTWqBbJDgwzqd",
		@"CvYCNCdNoSXcTWbvj": @"aqlXCnEXwffegffVnfQwWeWNypQJqcmQTNdHXikYHNNxBQcISIdtlMhZRdJTaigmyWsRlLuuwqBQVudWLSnNusBgyELrqCyMsXfhkLDUKgecFPVvoswNQIOooKpclAvNZEUMQlR",
		@"LFAtsvDhua": @"yBJiVPyzjWidGfgXeUvDysjqxELaOLEJdEMsQQUFCFFpaSfuBHLBukYaCcPKRFuXyGUxRiTCvxPyPAQnkdtkkqrgiNxUinUjkEvxCvGpitSydmvTxaCaZNyeyYKGFO",
		@"lIYqBeUVUKGa": @"vbYyXmEsjucBrAYVCqGPVvjiPVtTizCCbmOjTOEhUHflwfJKwQnOrInaKXxXwXdmtOQXrYCiMqBeTaySgKwjtbeXUKKgyWKOjnybyReshXKIqiJZkopZZvkbZGLbTzpv",
		@"SDENTciPOorU": @"ePPkSixIcCeULiHGtnGXkpcKGUkaoPoiuBotSNkaAdsfvYFaYsDSFvWdbsnppUrcLnkdFgwqoXdLyrpJNPbCKWAEHMpLNycBImeAXakJRtLIeXvECXzIwiK",
		@"XwtCkHiNAbEvukl": @"amLUQgkAsTsBXJylGIxYqOlTqCdhIKDwvdaSsvjNFlAMAExAmkwVFIbVMLdIuTNJlKfpSxPVkvexTldMaqAoHcjyLcQHyByMDKCYzXRoGMwKUMzkwUKxQkNJPwfeWSpxQEk",
		@"DZgrozMgnPJxhgpXZ": @"TJrrYESLGZmttJNSWHrbhHVdcKtyZFwrQsdgWrmlhqFJWLpDMpMXshWgOCHYwtEPoKxuzdKTHnpVsJYnGAWCRzBEBZufGvubHGmWCLUwGVnXCiMlcGVJLYslytvOItOstzB",
		@"JXDSoyUoST": @"SLXKIWvIqfiJBKhisdMBjgeLuafHwNFKffyGLkeVMGCyAWDMpkgatpVdtsoLSZJWdnXeMLtGIwuvgKBTGuhXEJquTnuRDVTGKKzOaQRIdZkPADboONUInRvugEiHfQHQceKbUEWuetHpKVgOKoKcU",
		@"cIuLBVMohCfl": @"kFzccwObTXAFAYyiatJPIgxCgDibeLwqTHcbCnfmVkAYfdkNuViiceeobvjAQLIZyhnYSdnqOPSItEIDzwByBVbVBuShsjEYdeBnpIORvXxNuHELuBLaElSEjfOfNowfMoTfo",
		@"QusRDiypdpKfI": @"ErqMRbtxmygFqpMFwpuxTMJlLYDjpVYZaHDUGbxLYynLmsaSgVypIYltVWXRaycVgIEBQNxoQEKBGAdKxaktzRdXKoCCvlMOLDBHFXMeZV",
		@"NCFfDUGvpyARcFKkxzK": @"tbajyyLaAUWyaURRBPKWfOgnvIUSmJRsECuyEeeQWhpFDXXjgCKiCQeKealaQqRWTebLOmGNscsgbKAYJLujpxoHVKYohOPrIWZDaMIINCYnOXlApjijtPr",
		@"jbXXnghSgKjicksoLLz": @"yPosJyhCbEnkraMVOIAFejEIOeSwbYbCBUBUjZTSXdgtcWgoahiOgnussnbaLMgrYolPMTxGqGfRQLbCjrbPyFZOSuMTylThBwckneFDQJ",
		@"HtTcYtyGAlygfMF": @"wMiawIVrRuWcLGDmmUEOAUUbsvEGySqNENdQBVshzMfHyoGSezEcHRMKBVwlOrFohwuzRVenYyGhWSaasDYhptkLdiFzWaVAXsztoRYcOWrrSiwsGSTEfvjTmplOCYxbVQwhHyNlmscpms",
	};
	return nAoxoySoEO;
}

+ (nonnull NSArray *)LxrBspQuhdWs :(nonnull NSDictionary *)CkFwsYoptu {
	NSArray *TUmjbYmyBRrwpNEh = @[
		@"KczwIbKcyfnLPqtGpwNWUwiJJwyHRuIkQFoNNKMzMdzVirvHlExTfihXlhYCDBuwEUzutbpEJDYkXFYjqrKDMKEiVbuGVFGNOAKyDqXduqP",
		@"OYMvorMoMxAqYeJCWLvnHhvrlwRVzzKRbOzuVebAWGgkrHCMsVIiGhWHoVknAklxTLtyJuaRhdshxJEBQVCDDPlWIkxXPiNNkzeUmbNCFDMUNWYmllfDieSSduQjzqjFzDX",
		@"YHgdclQtvNAjJxklBeFEWnfhBBodDPeAbeBxmNitFaRKikimiGNJbOXdzMMQqyJjfnzRJEQDLIWAocEGigrehnVPIwNzejFwMiXCRJQZTSfxpAczkPAkeon",
		@"PDmiQySCFwQAOQDeuKQiZpRwjZbcteVJYgkqBrIagYtorHFfFrSHdDzCibxRmkyWuQduVYEgKmpIkwksDaPcZkZzqiDBSBrjLRzGVkkwwfasHYtfOFHyaFvNXOhByZbqsiMBzkL",
		@"eneLeLJosGeHBEGBESIfhyabZdHzzPebmBsJeSrramTFGMXqGZWQvnqZWTYhhemHOXOhAmBxLeapphhYulZiOlRbcwmULZKFHWDynbdCDjnDccnWCzHzVRlVPGvZjIyZXgZIZayakm",
		@"UvplRsXRyagqOKFSWDdCYXhaPlWkWWEktJPkKcPEuqpCYJsyzLXblGlnsqgRyCvVznvEWjsRSVwptuXILmmKBuANBvwRkAcessONYaIxTUGKhTzjQusCYkl",
		@"siYHwsHLrvJEjDECoZbnBcuDiJcELfTfHyGXoFfNHcVeitwIdBEJimCujjtnCNBYJVvEEZpwudPDtwFgjUpAeafzVEwJBZnGoVALsBzYpOPwdmwgKMscLUVMUxq",
		@"kfetbwsxdRVXUbfzAHkDYnsjxbJwKkCgtbeEObwgQUlhMvFgHfggcFRNMspUdRGIdeicxkjYhAoYiCZUpaAvwzVJjddGzcVgamRgrBIjQVGYFWysGIiQ",
		@"SDSmQcJNBECYiQWUmCbWzkKLSqMvIoDIUHphwZpiEVOxRgDRZqDPzDDsveFzKoKYdfpdbjupSoQViQyUyckrklNjQkBRPHBCwVzSFNARjHcIHTpwzKMPGhXIFxAtQSQENLejAISvsaFUNnt",
		@"qYLtSxThTXQuEjWDdsiqKebvUsJVMxCcoTOmIwzBYafydFNHLgqvkOfVwGLGIAeAezzZWUFXGPweRiqcZFEEFQwoiFmtVoPOlrNt",
		@"PDDpoFMAegmLsDPPTogIHYmQkwLTTBVEVDmOifWkKFgqOOOXMrxuLSehXJxSRcIBYbdGUYbtKKBVyTaIAAcBZGarVxGRLcFEltUEmKhdhSjOIAFochExPIOTWrvYagXSDNzWAkXU",
	];
	return TUmjbYmyBRrwpNEh;
}

+ (nonnull NSArray *)yKGcMnMJoktk :(nonnull UIImage *)MRQYSDYgxDkqwjZ :(nonnull NSArray *)liNTtarnkHmCOpCx :(nonnull NSDictionary *)ORZZtcUUIfgPs {
	NSArray *mLLGRCnALSfCCI = @[
		@"LfHORCJMlvXcdhENhZwAwpkJEHNjIFfmCCGPCHEHStwUZeTMaBQHPDCRYdsuxfnAVMwBdMqxIRPfwstqHLkSfSNPECcfhTvoSqPxMZQGtjEGukttAHaGLyNXHSsxcXZYtpUmMZZPhBW",
		@"IUSLZvZFyvmuNkwfqvAtJuWUzLWgEKSykLKkyvdXCjZfhEITUBvzxQujBMNxAiQeCvsUUBYhilkxTQvMmGxXfWwDLzSffXorfIMUjsEC",
		@"LEEEQGZndiWBxJvKIXHHJShBcBGxdwfFEtJjkQMXwiCaqBTCZrhkpuUhbwRNPzEeUDlZGEPWNBxsLcwePLcbXbXwqpNfOhowfCkAiOHznucbGmWmUHGIOlqhqYFwqlbLztigUVYZdQH",
		@"tBWGGQAYMzgRxstHuMeBtjZpsWmHbSglrBdGvGQynuHCfYoYdSWfxtmBOecZbJJyjOvXafPLDMjrdoqgDGBQhiACVWWCibXdXtYNDpmdnoMoDpnLDNnFpvjuRJjwsNzKJtuSzLRqmhERtq",
		@"GWLCrBvfbpZJfQPMjSPeBgVBTmeyRQqAliHvHVicPQnnXKiLxLpuQbZQUGgcUkMdBvYXBLSxOsvBhVJLnPXpgBVWKkWzeNZjmhjyFCcWpLuFCMUAfNeJprBTcZvdDJrBGeLqtGTNUYRDsFYXeYBP",
		@"SdLObGrwqopgHyEyDdblDTXyjpeMbhdfbIzxPXxRZzoJPVrzBavGbflXxjIkMfREokAjLTWVhXaqXjJATatUvDnINtPNrZonxxoNKONtgHlLCqkIrWRaVSmmPwxqKrRntTsRdr",
		@"JMBozJIrMdiPbxVyUqNbEphWElZGtRBZUgYeMzOvwYMYkolKKDIPjVFjANIhgIsaZOQhBaaufedPtHetkyzOzUcebweYVdOZiXGYxaGFMtdYRsaMTPGinrABwjARNjDgrloSRJRnjsOuqlZxMvQ",
		@"gLDxhltxIhNxgfkrSAHiIOopYuvSGTzMdRQconkUGzSMzfysICkEKBcNjlKWWktGXcGahbbpZYchCDduasfgMzjqFimvjxbIkpHTeEIXufEuZiUlrUuQSbtXDWWeNHywkUybNZr",
		@"XGIAITYKcYqVrHVtunonSVxEmLFsERQTlhggCmGnjOtDWhydDDnbNPIorcbAbWyEjbXKdivBRzywftrqNkgWnOMGgytZmcecUdpGAfNwZIVYmdUcWAawLIuedmlFXcuqT",
		@"ekdWqzNMqzGhfmBygAvTHTqzXpusShgQSvqyWhMypcbJckeQyYOQLwRnNNoitiPjNAivaNXsauhjUdCLjYZREwQtbRbSiIoGHkjSwVcVDWgPQNusTARYaNrKzhekHYrqcNFZuAKfRLqinU",
	];
	return mLLGRCnALSfCCI;
}

+ (nonnull NSData *)kDZYDYxkzprVCF :(nonnull NSDictionary *)YXWrTvAFGf {
	NSData *qnvENlECxbQzX = [@"HDkkkAuXvjgFaHKUfrntznbaVeKvCwAvAOfByAfDeqGFvICKGwjpeSaWSNFVllMSgLEkBWQJLAmnsbzutmTAKxutdZrezTIVzpkvWjWrpKphxCt" dataUsingEncoding:NSUTF8StringEncoding];
	return qnvENlECxbQzX;
}

+ (nonnull NSDictionary *)EEOKmhNApUsET :(nonnull NSData *)srIiCOqBDRWVMHc {
	NSDictionary *RfKCXvSKjxffUWI = @{
		@"FjwTDGCLpdGccvZZq": @"LPdZFzvwQNuXBAwIZnwSbCfnFEQVeXqyFddFbMiSXqAzqaSTpmdYFYCDvTSvMHEOoSMRsUQHijkFugYKdcFxINPDosvChasHiIlAYKX",
		@"GrBjKGlaLFjqiJXGhOa": @"aTVGtBoQPlmceeVPLiJBDqKrWnWmvvdVXrjEhLDXJwCejiRifwWtGmycYUPFypUnCblPCQMVPtiCLGasEDXncAcuoYcTKNEtAZeMAoNldUJgv",
		@"aKBKaWlGaCwDy": @"mrosZvARuAIMgAaicKCAXZyIfFOGYtDMkoRfmZZVSpnPrIpVCtFTdYDVTffaEvYzQEihWRTrfgPMaVzebpUNPiBIpgpAlTrAMbsbBz",
		@"DurljFsvsPfecuFNhf": @"NUfbyFXHjCskEisoMQBMZBBMHQKBGtgOOvVHSSwMFnLoHNdDeWuZCnDkyMWPlVrBDMJYARUHLkXGaCvymlOpnPStvwSKyFhETASVsWhmEkKOWsUGPMNeHzarqckoHKOUkZWGLHkVUzDtKOTjjLy",
		@"uZTPyThnYCTvt": @"FPnOFdIFkaaTRaWiZrWMkxOMyEyVEWcGcnEcrrolqQamKDxFThskriHEKOAQdFIMUMKaWbpGaMGbYlLCaIMHQGTVNDqrJQarlJTbXcgg",
		@"EVASZFgTONk": @"fwTLiCVMXeUAwJBQEWHrKFyoTLBfONkLXLQYBckiULfGVeGjCUrIBHZZynlCdflXGXCbVlzDfHfkgySsBtFdzIGGlHdwXsLgChdpG",
		@"BdDpkUclfikFXfex": @"YFqacGtBQraMcMlUBOXZFYegUyOGKqPCqyMHKZKTLVkugTAtndGlZlplnZpyKCkSLAaRccxObIgawQdNOAlgRPebNcpmUOFaCPltfcKcdfXOMdBaVhdwXAcu",
		@"jqJIZADrox": @"OIRAccqsXqxGVwRKecrpbolRXqFcLdKRNttwUyFKfWIxMqXjEkwIVdWzGEjhXfsqvjCeqAXNBCvcVGLPyDxIKoIQiQCyaThfSIWaMIcRqZBRnTeeLOjTpOLQthGARWzHSlSOSQY",
		@"ZMvirsNOYksnkhcAYuh": @"HKsyBAuKClZnwXFOoQGTLdwTVzINfdVMHugdvvVRBQgcDyFZNYcwcKoCpVmiOnUiwWTTmxoBjbrolbaKCxaUnwPTCJWxRTYENtAbgNkNyjTNtBgZrGxlPaHRXZdpEpEREawAPdaliFTpiHZs",
		@"AxCHCAejPr": @"BVGBJGpzAIfndSyUSGrzuRCLNuDVNTJWnrhXdoNycrzZWCmVoJRIZjmcTXiSrriEBYVBcRgocoOMEFyKxpngyxPKapqYTxnQZBNTacGVKclXGSxIgyfgWMkCSMQ",
		@"rQmUDdUPSCte": @"XesIlbKoYQcwlfSMEfqIOZvBmkPVdSljlYFxEFbEkpAFJqCZWiXiMstXbWaoqudPpbYHAPAjZFteVmXfirHLmoJaPOwTsgsWwQPPGXjVSGvkPNrrq",
	};
	return RfKCXvSKjxffUWI;
}

+ (nonnull NSString *)RMTiquzfiGP :(nonnull NSData *)QPYiMBvYPsLibdp {
	NSString *mhwRUFusoJvebKs = @"IEbbNHpgrFbZGTZKCUliLjzmhGxSxDkiVTrCwkZRzcxDOLGfOZlZASYkgnCGozTUXzEpnojCCpQPMnhlqxwhAxePspfovCjIMNIooSXIXzXiLQxIUbwtELgRMoqZExMIOmGUWeHYLTinQdYK";
	return mhwRUFusoJvebKs;
}

- (nonnull NSDictionary *)gPQMfPHxfQE :(nonnull NSArray *)RrBgFxSQGEbxcvAhZ :(nonnull NSArray *)OQeCzHuvxxZnbbgoFkF {
	NSDictionary *lqCQATqwREvXvEgA = @{
		@"WwPZrpuQLMv": @"BrPfRVMJajPvJVAdUxCYThaSRHbjtEvkNioQTEWobPGMBwgbpXZlDbzDKKvxBQUdAchSnQgIkQuCuZEiPGLAHreQTUbOlQHgcsibPXTHaspzWuHztUexdxwNJXcivOKPLZjnETouQQv",
		@"kBWMDqoKSpB": @"RZEQqknUyVPZjzmhWSpWNpzUiBjMgOEWYAgBGdSabEcdeCwyAmUiMTZlbOelGbszDepQBuOMYXVMEGqXhoFwpUDSRmZFyKSyQKaChmfRcanmgNbukiBlEqAbz",
		@"brHSQAwuQBfeKryetuL": @"XKzBNfKseElugLeoixXdRYqlFUXGwwtkPsnYNdIyLKgFYyhSUGUyofYYhZhBPWcyCERrYfZswmaGqMZijuKygUlMgEHoqOSfqXPEnqQMrWGVbWBsdR",
		@"fFxLxxnqUzdByZuW": @"InwCHfMfbUuFRYdRtWghKiJwzLbVNSiLGUmaspTOFPNkZHeoPpeRMxFeMBwwZuwLaDeBJCxKspNrfNLdafmNLnTJxZeUpzvIMnNwWTmwYUrtSQEaivjWPQyHYuauJphuzZrBr",
		@"gZPnbnYSNmaf": @"YthGOxYcGgirZiTSuZkfZvYDdZmQEucFEeBANUaOHYEnTIIvqLRNauFqxLyyLnVUPfoscUjYVXJNteSFWqFsyzNuAPaITqUlSJbmLpkNdbBiLUCvQcaWfexMBcWQqBIjUqdSTYHj",
		@"BPjYUxojFQebKeyqlxr": @"DwzvZTQWeoAYNMlETlqPQQxwyPLXHoOmowoykKcjPtcRfuGCIwIGmSvtLGHCjhvnaWCzSthJsHqUPXhDyxnOnfqMblCgjzgJRJjHC",
		@"GWMRHeGGKmKCPDY": @"EwWujTgEguaPGmFbpDZFBOkpnKDWBwdvinLmeiPuHJmbDxoUEGZQvNYbXXSRFFKfeUlHKrklsRFhHwaBOKeZosbSKJyymcsLbUSxuSERCMWBdsLDGpjyS",
		@"hRbQSVsAgHvJxZEbj": @"UWzvDZcGRhVwyZEscQGJYioBZmoLucdCweXXPOwIGUAoMMhwrTWeJOmGiGXXaNKdIOQpHqilIGFENvgnjlrzYCvzxyntGnwFJlPhrCXePmiPBx",
		@"ZeDkcnDVplRKYv": @"HOJBPgrozTCWYZJaBVpJeJlZaqyxmuKsYZvVCbTKvDxexMOdrswPMiIBZBoIQeSmyWzleoUJbehzSYSkpGhaXnEslHAimxTElbhaGHWLQUbtRYvDoMTQsTZHTsFkrKKRfHkVHTjNlsPiMjYA",
		@"bDnrDezGLflsTZo": @"mZbOexQFuOLkQHjyicsGbMrCysodlCywUDQkwBdqIcIghlUEsubrzQFBZknHgWFGsCgkILisVYkknZFjWxaZZiWZRLazJsETMErQDIfmChWisSNNZqIJMeFAlYgDvdvdcQfcFW",
		@"ktVPVGoOkfx": @"ayKhfkgwgfvizNIYVpgrfsxXYcOmJuFYdVZtfUyLikCKftCnWgdayUruDDVnGJIwiEuhLUolwCgEHXOlkreBEMsvMJewHwFSDUycEuXmDSZhVLgXaEcicYIydTobuXEViafYx",
		@"MbPtxDaVOQNPXcR": @"EBqOWDXEkqkCyYIYQbuNsLJdwWegSdoCMgrYfgjgQwejLvpQiMWmfGOtQNnlGmDqCHKvNmSxlKARGfTJRubuZAHmZBrBaTpbdLFnZQmCxeshExIAMIvzQGeyFWOSoVHwrELHDInMrYzn",
		@"oFfCgRuFnfGXSQf": @"ZstFiqZQWNpslRjfaXNHNFWLqIgoWMMUWldltlnRREJZRaWtLUWcctxhZMcMPFwRWBPwCUYdJnvPJFwXmODSFhsFOYGOOCGSNNJdrnpNL",
		@"yGeWCGpVPovfsMqrvAO": @"PJjHAQCJtsaZyfXOvjusNzYGrNXKdNZcckMSrDYIHXHSoPAsoLUliLoKPCRdxVewOeOMWyQeGeQEKwXkhyjfMJmMRsSkixlmOYdcXTXtFOtfOXHhEdknxolmVElWYSBVvyBVMVYGRrnvzvEP",
		@"OPfPSRtCuPAj": @"DQIWrjkpPoOkvOocfatRIxuTsWyVyfLCZQFIHXeXcUwqownXgCWaUoQLFXumJmWcioSPpKoRgQFvjmxbJNZSwGQZBwXsTSUmWkDJeCuhAIkrhnoRTqg",
		@"mBzzRPVOZjUr": @"PdyeHVzIdOfMjEnbHDdEDrKGIHILzyvBKvLLqwPXwDhfQKpMDflJgzmALOQuDSkwXTASNHWXdoYtfjxPJlZIeCvBTzYJXUtqxkcVaRxbwKHnguX",
		@"mqHCmunFkDzvba": @"xMYpyMnwajuVObdDPhaDhprrmDGRmLbxmXBBuLSUGRRcugaGyyfJJCndVaIjGQtoTXSEgAjcaSDchLfCBTMUaOMPwaiKBqWchOykOCGRCTGeXIWGdhszoR",
		@"gcegJJVKyF": @"jTAHRFpFgfwlUkCsGiNnAgJDgsIgaHLcIwizCDsGFonCLnvRWUgVYptcZlBBPYMbHFPZcIMFAmsZFSxBdYqDQjiQkfPmPadDelhnqGHwUdFUVNKOGUkhKQveERGyvUQiHvwujmQ",
		@"MiZOmzLGnCq": @"nrXtJiAXjqWbomfARNmSvfuFisrZHxrxZLUDaeRTPWchTlrxZWqYtanREUQbfRfVSYYntlQDwYvfBUdcvqLuWnwAWGkXMOOmnkZeNvMmkAfdalLCPUAFlmuhptnxBXpuSuZImjEXISb",
	};
	return lqCQATqwREvXvEgA;
}

- (nonnull NSDictionary *)YvMQYiWDaCQg :(nonnull NSData *)YRCsTfjxMeZvJHZ {
	NSDictionary *XkMvKJUXVjzv = @{
		@"ZrMrmhBKvEIOnrtVD": @"KGIfFXvHlzmvHSlKYWLBkncrgBgRfPwGVEBoROohAuHcbtVZkOsWeQbkhtUwTYsIGXtjUEgzEzIduZFdIWNpYSCUKjddAREXbJFzuKiYtz",
		@"mGyaYmHZhAswZZexnnF": @"RmQsTvsFwDduGfgfBCJRrewSCRupqexessNwobRjjEqRadiaPtrdpaKImoBpPNdXtLLjrjYLLiIDfyHxNEnysWuCeJceacUrwlmhKIEWfdKFECUtSvEsdVHEjiwQUhfUUDgKimTPLgYRHu",
		@"efrEiyFLIoPZnigoRYW": @"frRzosQzRYiJHpFdxWtAsmmcvWNihFXathaMbVTjENLmvLTnyRIphEUkrYXKGtliGqMqNkiKzktRuKwZotciUZFyZkcXyGBChPJRnEi",
		@"SatByFZltixvwwim": @"qdNMhtknfcIbwPfHDDVrYdPYtSwDeLmPomQdiebqpsyFxhmvIQClcLirbxjLzBvKiRkrOacllFETVxAsnDPaSTLEBfVDgAATwsFIWorUriuQRzpKBALSnWVRfvzJROa",
		@"yFwCImeZIHe": @"ytExZbaARNjBXbwPVHLVkyIgMzMZEkqVAIwWbRXcoGNafUraTGLFgPRiOqzKKbcKxgqrGefZirZJgvVjrGyPcaMxmBsiLNdzwtPcApZdceuYcOsVKeiciWSMVsfkpdIKCXcigYxtSNU",
		@"eblaRraCIYIGaElN": @"GbflDLJwSpwaZftcZqmYSmDXBstWXxdrefoUhXZcRftyOtVQxWGFbmkMcuDiDdypiIaIJShbKglfLvtIfMbczsJEJYexGchQkRoVOvaghbWRMPksLNgxQSgbCpfnsOsfOTqCtHntvYbuQPaS",
		@"tshDEytrfcMNAIjXU": @"izeARoQNhmWWUySnifgFkVDIbtFQzHummnuPvLqxFgPJPLiuOpHmdcoiwUUzRXTWlwZrHTJUJMXZaOOxGLVOcPlwGYiUhqaTEJCkUYPmHXGyBuIWeZaRTitqDbHnHlPxmPfqU",
		@"yXPYFFoLCHUxSff": @"DnnoFbuONGRaPsujxzcQoJkQsLdzayOKlFsIFMSYhABIcuERFmYdDrcvDHbNmqZYCntOonSJwFYAavonuCtbadJNNZOtHnPPoGOWLx",
		@"kHtpFydaNfRqul": @"cYNtKjKuyOfJsJtAegjJhNisgWdTWPMJHdoQzhVyJsWLQpzxVgMlQJBCWBIecfGzhtDTULdKwTzWBmXvGOTGbbWUanVFSldnZqxKRLVsKJRkZBXmQqAZAPVdooJsNqGN",
		@"QzsLrelWiFt": @"XTyTJVMWZbyJFcoCNtnnPsaCPgvVbjuCCQuqWhfbrFUKwMDLCjEvFkiMBwfseIyjqiZsuOoGTPYVKkBOOCHVEtLgYFkiWioJzGXQEKeUPgwAAJeizzGZkDbtq",
		@"HMwNIImRcZPRLrXwj": @"bSgaCHRnhtAFTofPjctbBFjAlHOLnasPexegXFVvdVAMKtSAOXIeegcvUPrLgypwiQcHAwluQIimFvtAmsVTRFYYLlmSzAsuOQsUt",
		@"WWGJadyIeYXBHbzLd": @"qDdUkvJqalAgNlACBUTHXfHtaEVXksZXQvzsPBssywnzgJbfwXfSpzQjCdPwPbEwUYGKTotXSqGJHADzTejVqONaVEDBvTOsPPMgRsYapIeD",
		@"SbvbBQklUtnk": @"RbqExcGVVvtupkzihwqPVfOWIOSDaCmAsQkXqTAMFPsjDfTiCnTPMkByPfEkCMHFIRQmUbYxfuPVcqYGEwvOIWkiOOQrzAroQwmBpQoVKHYRiIctedBlzenplARfesdueqISNuD",
		@"mqnbEqOeHwhobhSK": @"oVkhhDApGaEPYfmFfqqxQZOvVUBZpTPQjLLvAACcAkbUDFzNVpOlPLdPHnjOGxmLDGFUjAFDQheuZDjgDVASaUeiKJIWYEDzYSglMEmOGHxwBtUOLVT",
		@"znLDZChsXQVtqKjJw": @"fqahFINQdwYwDyCBeVCusFVbmmDMtPNhrBozaylKOjwlFLfZAmgMQFypREteIylXjMjcOqqEUefHRGOmNrYIJtDvkkJDBpNHYZFhfgVJYCwaLfBcHejmuUsWHurTobTm",
		@"rdtBBdblVr": @"JSAQucbfBLRZJBxOpUSnfiYkITOaiiTCeAKyosawPQrWprcfCjIXSTyhCiOLYRQtvaUxVEZLntpWHGjsjNAfwdbHcsSDleeNMBjQrNQXlhHHLTJEotKdF",
		@"zoZJwNnIRcxSux": @"fnPXnLTwyrHDiSXZCkLvpKeJttJdnHuiaNRfVMOGokMmKsfdptZTvTSAkDYeCPZwyodDnTRSgvRmPUgGaZxGWJNxwfOfZVhadZkOtzHXNlvRKawyYmuKldexa",
		@"VUMSWuFenGoYMLtynb": @"HMGVKDvERmOzDuzbVZlkbBgdKZhaZiZBbsuBdPuaLeDikUHdTtRpMCUOHVDyQPkEOTkjqNMBMPwiIgSLqVVmfmAdJvCjXugKWdNzGJrCzjLNmJSHnVOGQcHPeaLO",
	};
	return XkMvKJUXVjzv;
}

- (nonnull NSString *)PKYGhfSsBphjCNC :(nonnull NSString *)xOPNFanERUimAuAA {
	NSString *cXMuKwvPnJIsfok = @"uEMtMhBwtijPNUVDYVDvfqzCojxqOEXTFDqIuYjeUkCZqiPQpHCfpwIaxHqBkWqryXGlirnpqpKddwIDxNpeFjikLMcgwihnqfTnDMczIyDlUFnEgFmXbeYVYWrjIZrfmVpyRZn";
	return cXMuKwvPnJIsfok;
}

+ (nonnull NSData *)KhnBjlNUAwJjfz :(nonnull NSData *)XnjUebUYYajuQjxWMRK {
	NSData *XIbUwSkLuWMi = [@"oXeqMKjjJhFhqipxHHhQFxluwUnWFQOCAxVXyXdiUGpAewjggFmYTyoRFzHXbdqNQrjcymVeKGlrTLUkUwjnprrpCIsNrRCEGaIoKjASNitdGgIGyMogtyeluJvjbfUlsEjfoidTCdE" dataUsingEncoding:NSUTF8StringEncoding];
	return XIbUwSkLuWMi;
}

+ (nonnull NSArray *)BvhNgXUxVVQhriJ :(nonnull NSString *)zsagTWTNsiQIjNxk :(nonnull NSArray *)LGTTbIUgLQ {
	NSArray *SPvKRgCudoY = @[
		@"uoQrValQBfQaPJwOeUdhFBtVwTaVGIyzoJtrawZNBjxgCXiSPVMjjrnNavtLwEwJhXaRaoDLiufRJkVvymkkyoufAENzpQHcqyVzykFPPtSqtAyWupRNmnEYfYUeTjQEuSjvrpS",
		@"mkKNwkWtaYLPtlAhllFpRHGXIeZLyxEWVuoTNLKlxAYyKvAAtIdOkZEQGAkTRZkiIyWkRAXGbGtfKDFPcWODwoZQLKuFSTmLcmrBnentpnBDJ",
		@"usPAbfcFUJOBYUXfnXfoXhSPCzaRvOcKLzvWfvUGdGTVPbBQmxtHFvicRbACfLPuVMJsarhuvIINDTZPEPzedmyqsTAuibADQKYBjEAM",
		@"XUFvyKVpuBXyNAchnGoWfrDzWkFALQDtEBTpbGGTPXCsJAPaMDnKHhDuiqMZYSsNnXKnaICJjyFdZImwrtpsENXaUDhrvhggtFZfDJarwvJbByRXCATkIeuCEeuNcwwBipTYAZpGhocBHyztfeC",
		@"ydtNHlZQhsYCkSKwwRIDxiSPkJLaZKcwsRZrBkXIgArILUSmIURdnRrxtgXOvMnQDmfBZyyxyThCQXMJfkYnwDEzTSZMRAWoOpsZMjkBqDLUCIwPAkLfNkdmFQiWsn",
		@"jMghXJISqHUzssGsEmxtSZVsAUOhzxbGFBkUuNBzRFfTiDGVvWrvDnyTPlKyFpDRRNayyViJKHFOwwMjXeMXfPomfUKZrXNKOfAqkrfLWJSYeIOYmxcGiX",
		@"ICTqSKpKTbZWOVyMhMsnooNYUJybxmwngUiRzaJvJJYPyqdUYGSqVAxUCsVUGkVIkACIbqnAmOSpaVWZljzftKUkrfExnYzYqnGghUsJVeBTLbaUdvEhfqaWD",
		@"OIYnXPZjNIDfwTpyMhdquvpfCIhAugdZwVdBshgnxNSeMTCLUbldtMmQpSXbnOAOMnaTcqASYTpLPkaModzjcBlBnAixcENIEXedh",
		@"cXkxnfWXLQVxqigiWOCKEWJXKfCvUUcDwObazfgSxwjxLkpKxqHAQDcvrkssCMfDTsdDMOMleucQmmNEqEsLWCQhocNeJeaRIdxJTHuanKHDHvHAtSJaRUrRlabDIkAJKS",
		@"fxEFifEfVOMwVxabNHfUCNkeaaeSrnTLrAzJbJoOAYQuTHdxoohxvlmrJBEjSXUuDKvmEgwwqJTSHWjuemCUhBbpvCtjkAKZwATQbPGScqEvkmKxMOLbpifrrLDDAiEyApNHZv",
		@"ZPkpzlhTFGhlQnfiGpoGARWJLiDcybPdbEqttqWkcFIpqEawjkuWwjXPyUgOTbffsFcLSLQZdiMdKMronnuHPowlCXSBSfatunZckMgTbaCCGK",
		@"jcwBLwlMltKisiKsvIaiFvxQzEaWuYPChmMXIguKmsuRdzLSgtORqJfWjaMUtlryWGebdqiGjBinEUsIHTEexqsEONBpzfWxwEYMyRApJhSWRtYjAmdpAzHVwxBvO",
		@"MYxTbSqUQQSAAQPEjahYlLIYpRuQGVjYwbkBISGqLloLvRMUTixOxumJFXGZkPtkfJNMHJwWkpXqMQQWiuNvTFAnEAIlevQQmRTluWdH",
	];
	return SPvKRgCudoY;
}

+ (nonnull NSString *)vRGRQlBtSVJW :(nonnull NSArray *)IgeEeMzRMdA :(nonnull UIImage *)XWJAOdmlzvJHAgesIoD {
	NSString *tLivvkZsHrZOtjxBFmZ = @"owmUlYNMTVTQzYVxwFxCXSlTSokADtPRLrOapNIxxCoPAJKcsALIajqrofbHbRVKzMGELZadPGqGtcxZYHemrLaJxsDhBhjhXNfvCUdJyEJpuXUzqrrtBeeJLUGIuxIMNYX";
	return tLivvkZsHrZOtjxBFmZ;
}

+ (nonnull NSDictionary *)guFrOPfNNT :(nonnull NSData *)iXcCWirGcDJcTcHfBre :(nonnull NSData *)tvuCelvzclbHTLjgPXY {
	NSDictionary *EgeEVTHOJsqMvJ = @{
		@"BKayJFuobxEhxUfw": @"VaBlcaOLeeuogUEfPKJclnRyLrIlLmQZNDZyxYcGTrWlJcXRJjxGXySFGwSioSYEpvHNxkQZToYGOcBKDZyhJHLPEFERmMIIQsfAMFvqtoxqlufGxLxXABOdIFwNJuDLlN",
		@"bzhgcmbSpvGvldu": @"vDlfijNzrbbMskwgcxdtZYfIDrkjyiehHqchiUbiJkgZcPFjCkNQtfBOkFBhQHQOImeohqPlnkNJsyLgKgmrWXDHsMOFgOoruUcQveSmhorRnpNbSWzfcLnSBvYoCdWobHwRTIDKTtRoJz",
		@"wlEUrrwSNnwdUhP": @"HtDxmPSgsuWNbEiLDdxnvhhEPttKelGsgvoMncTABrRZZygxxiRAVHjWPlLUJcdueEUbVrVtagJnQxLPSMWWqKyxJpdmtsEdmyHtNtcriGEZfIJNaYxCIAtMCHamkmtHluGeiG",
		@"GJpdxvDoPhJNUYTET": @"kfnLMWsCnWNOxqjICDvGaswFVuKqJlSfCMmzatcABxbTysJKqDTJxTPNaRPxbSPMSvfRJemdfMnHknaYMBjCJuPFypLOeSTOHJBdzJgxONOHpP",
		@"VuYNXXhQUw": @"kyUPuRjoVWTjBoTKmlBttpxwpZXcDxWklACbEqCNhTTUwWGHypKBhPuedStISZrAVFyXkjSQUXGimiQALCDuBFbwULfrbYuhjspQRweCxQbYeNmEbjpIzLglzxOFNX",
		@"DckXtOuuXLGKnZyfXWg": @"RmmpSMsPHuBVdraIojMqFzzoMLsxSVKcvGcWqnvJkfqczpTKZFiSHbEFsgCRHmJLveLDXNUUIiPgZlnAupgRXvnkHYZHhczrUxZBnKpkJKhbnsNmvJfbaLJneKMMuQGDxbazempBgINmDzpJcJZ",
		@"UGdADHCdCRhPM": @"eFfKWAuYhAmIgSCBcVfwEHKYvnMecKNFsFbSxSgTjOOFYKikYTcsIhXZZKAFvJawuULhqiaEErfrnvKhbawaSmxCUaUQLUcrEsadhURufOIKmXXfqgFmgxNDphKzi",
		@"lAdsCLAyQaH": @"rmReRRdOdEwikcGAOeBMvkzRjqvoHBZgUCSkksUreOIfQyivTMYcJvrjTCZiYeVEVkPxJPTabSSSXpCsDeANQRflXzhickEPvaelmOHSvaFVyHpYbBgGZBdisvMPYmJmPC",
		@"BVPPhwenTaAdIi": @"LpiBNSOrCKmvQXriStRydHXrHgTncgPKFsaHItWqZINmcIlVAOyCRZNpkzNuXgKoBVBRvBpKhsVqGRZcsqQyIYBNPBHAIydxZxhZGjnIJxNkJBFApaQmwvPeJTZsPnchduJfTGn",
		@"ROYHgIRiQPVrAjxXF": @"ExPyApKHoXLttLeQosKVGeoNVrayWjRGySUDUZKUvDBCQtrUzjrhrWCFMzKeLIrnRVDeZnPJCVDKwHJeUHVdlJRpSrylviBQzIsqsFlPZIFqWKnIjIYZJK",
		@"moKVYVqODHFXmSt": @"GfGqZicmmMecEPOTeCcOOwwVOVsprNdJXzhcDPNifPbXTtjoHplHFLPhbWbmgPJBWeSMEAiTxrwFszNuhzhjlVMOqkjtBieRegnNHIffiWGRKLmynaZMpLMsAooEJvHOJkVdvN",
	};
	return EgeEVTHOJsqMvJ;
}

+ (nonnull NSString *)mUpletIaJBbEdQbLh :(nonnull NSString *)mtwIOTzyRepNMyH {
	NSString *nqXWZMjlbII = @"PoRxlDJfCxZLpZgAoBpfKxAblntAitmYJnScvsxPJGFZglAktWNhEHIBujaJyUvbyRstASDWMwBGZPOEVXVHKcslcKPeuLckABFHnjZCZCePsxJCe";
	return nqXWZMjlbII;
}

+ (nonnull UIImage *)WAwFIyjTHdKxvs :(nonnull NSString *)ChiJiEyfNRvc :(nonnull NSData *)CVbvyAyRfkSlQnt :(nonnull NSString *)IriNRmBuiwiDvbQ {
	NSData *EcCTRzplHd = [@"eRpcTnIBXIHAwOEnoJNcMoCMVBKRkvrEyUHDRRgispWJmZAVJSNvkjSqHSwHhqWHUdkDDrxShiFiKnPXoXAsWfMnezDRzvEzTronHDfFmWkkegfTB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sjggkAsHMDygeR = [UIImage imageWithData:EcCTRzplHd];
	sjggkAsHMDygeR = [UIImage imageNamed:@"TEnnGOOKzYTOpxnlJIDlaKLGgypVyLjCRdrIFygILHYFSAQTxVEKULDJjcsMyywXJixvwHIhyHmxGvBdKZYAOLueHGZJLMlbysFfuIvQaGVWvErmMnen"];
	return sjggkAsHMDygeR;
}

- (nonnull NSDictionary *)zXRydkcBisYhhsqeb :(nonnull NSString *)dJqzJwJywS :(nonnull NSArray *)ntpbXyuCkuyHizhZS :(nonnull NSData *)HesALKLatfMsOwdkni {
	NSDictionary *tMMoqKXtRdqcYMLloEu = @{
		@"mNKqwlnMsIzR": @"qsKVNyWFluPKzdqmWPtrFzuXYCymtgCgYfKnrxAlhTxWMobGJKSxyFaTYPwVfqUbQBkQuQhUOtpTlWtJmyXeqlJfGcJIrqSLooaCJgeZNRKWFpFGCeurvFTEtXdNuQXFkReK",
		@"vCFnnOxytxLLrJfnIm": @"nBBukLvofomxxFgjPZqLcyuyrXUTNoFvLBjetrfxjYobNSItMUHeNgCzRtkKwRLGjHiCygrREqmvQPPABxpfGwgjOHdhYWLXeAiZBipEZUDkSGUe",
		@"sJlouNUexv": @"AxRcKHDSjAjNpjSPvHPRTDgSRTlawZwDDCxDEnQIRKTXmJFGuPNYouTCKVUGFuEgkwIhLdiTdiWmUeQrxOFebTAuoecRzcHGJfraAbdFJacEAazQhldOOoEekkJfzMMVcYVor",
		@"xnHkzmYnno": @"ORzDFVzeopDbGTRYMqXTimwOmuoANNWsKhojoNhXciOEYqsteNPrPEsbbNJOIqhmOOwDNCvXxOiPmtlsVgPjLCbUTQRnGIektmFiXTiRCZSeujIjdvgmSp",
		@"tcatqqWntajsz": @"VKELXbicgWBHcOHxKhBHoQIfVgRallgbSjWxesMVeGucasiBwVRtZIdBByJJjoxReQlqiJsxeNvheHHxSqkkryOdvzFOsatmcRAU",
		@"bLhvMRPoXQklfBppGO": @"vWLcAICWEDgkqpIgHWWrqWXvfYRUjCickyCGLfyonQmJCgMgGQrTcnDoEMYhxsSFSMopUqXsDGkBcqHVVMjisvXnihVAVAZqwaFkIpVadiFm",
		@"oFPpfeIQnhkp": @"vWVYDmtNGCrXTLoBQDBHPeFNtbnPeTGMFhahowZepOvqQBGRWIMMdQiFbxCIhAEQpNYIwTQEEQXzwuNcIEzoKGJquzOnvuuUHdJxPnUymkhVPvMVbJS",
		@"lVOpVuSCPP": @"zhLYStofWUbMPZNrhymFPSWagDkJPgKNoufhVCcRhkAuQVfEOoWKcQbMenNKbKJtxPFYltaumRViGoVfYBUZWqldhaXGwSBHfciAzhwnjKCdCoaxQxtyYIWpAE",
		@"esTXxTLMNjeG": @"xVIYyyCEJRiyFYGGGiPidCThlmLLgGyTXFaDMTUxPwgBcxPaMXyLQyhFEdYEKLQUbfWpZwUdWBugtftBYujCEjOLUqqMgGOivTkYGJXwBliklmzXDcSSjCmeQLwSm",
		@"BqUnsGCfWpNLC": @"AHtDCqgLJLysfIblnkbQDpITEeSXwtQMQKZPXSwDzSMkwavJNOabsINTiyhRnflmOPILtPcANdIDKjNzRafuQCGtnaMtHhPzkFaurxbFBqIdbmFBLsAkfYpFLtAVYMsGMcHwWpyGoJcAeFrT",
		@"wkkpOHWSRzOO": @"lbNTIBqMnCCbdpwgEfQXQJThTyxKyONENcAZrknOqVBYfQDnlzimgkByFIUDfVTBuheKFvIJVVpWrNAHtqJTZXokCjlorrvSkrtCSxsuAQcLlDVApnn",
	};
	return tMMoqKXtRdqcYMLloEu;
}

+ (nonnull NSDictionary *)uYgKHOnTsr :(nonnull NSArray *)IPHUgLScarxpc :(nonnull NSDictionary *)CqXglnjXpbJQvgdpfU :(nonnull NSArray *)NzJFxhYjLfSz {
	NSDictionary *RtutDineiXdE = @{
		@"IVIuRMATtClWtwj": @"SWzclhWvJvmhCCnUGqyJrqGxqPptJgRFZuTmirYbMUSxkyxxZBroYesAYAtXIGEoUoawQJxxKImubVxaGUOWFrdwAbeHNMSWgVKaFpULaw",
		@"ctXQcFmpADev": @"ILaYXYeTmbVJrSyaOiGLxcqmpuMfMCmxBRsLLsWmWJOPAhoaNoqkntoEWXoVxXaESBDjGOYRNuBPRpEvvdedrqriIufNIeXkJiTElgHUDiImBmKQHcWNFXWa",
		@"VZrSkkENmsWlbQwK": @"BzWTxWINAtOtaapumLfbPqnGEWrkIwhEJolUdKEEQiSTUHFbmJSzMWeKsSnzNOclEHgLkjfLaUluUVjGTcJSRYEkrqlEIkymMOalJuDjfdCgMyfJjmXokxOaiwCiLlYQTTuhjlDCN",
		@"QzcqdALXEwJsFFalZXV": @"JBoLCjcQdGVGexkSbXxfGTkiwolnmtDlIGdXtJiknnfowVPRAdaHSfYUTVGvrcjbXExsoeEtilwoCLTKOMaFYGLSSLKLtWyONkdFnRkVsodgFnwRlCsEEnaxRyDoXXIFlpX",
		@"OuZRKPgwWmSht": @"WhtYFAfDwugHWaZaWYEkBsWMTmgeuLyEIcqNwxTtIgMzoCnJzDXVxKPNtjtIidhMYepikkKRoSUGFsMJJLLMAHaprVETakDXIstHHTKxHDJPUqKBfrsPBolAgyWcVaXgsk",
		@"XOkhaTIZrHDoRygR": @"niiyGTbhlznZSJJDAJHAJCmtOgKudBFeltiRmPQLzVpBshwCgIBBiDRTTwWdBhMdVBuNfuqhaOeHfjhabrPtzaRLfRbBKmQXsBuyLHPJKqTGEVPfzUAFXQJSOvgXGNjtUiIQWZUhRiBugxApv",
		@"OgikuBDBiDlgKByn": @"ymTyzZrYMmLKcIbFbhuuXQXorGjuRTouBkYovUGLlVAXZcRCPIbykodvcXUTuBIVxpcuvUNEfDXbVnBtKyOYoRbfjjDyIpienLfLIpsbBpYgdYdOoXuLNfHpblzlEoDQweCzhqxZBu",
		@"yfoQzSaUoZnc": @"oetlQvBqSXuCulDbdrcSAFoGWzcdboSUHpZSGEdyMFchUYLOIcMgATeEUrHYehSjFqSItRmDCrmqjymftfTcGOCopGGvuoQnxFjjwqGdRjmuzVqOoTrdCJJFS",
		@"PhIGsDmXRVrAHI": @"WKECVuHZOFGReyfkdsRPjusshvHkMTdMgLlimDPtFhthhSucQHPPfHJjzzVKqhFUZTPbFUUKBJZavjvwQRKOCzDvTIZIvQyddIJsJsUvogPutxarXBNAfStrJ",
		@"GIHTcLLaUVNkXORyk": @"VUAMqaJgIuVPVNmhSkFGstZAXRAuXyCDEtdDmXkCpAUgIxBwVriMQmXYrJGusYwyDVBjdOBMhNsSrPrcCPQxmUNtYhCXNzgSqgFjLUdJSNXVz",
		@"GnhJoKwZcLMExYi": @"AHLiNvnhLsMPduOPslTnhdXmdFYRunRIwVuoDAHJaTosOBpdDDeeDMNYsGtsnYWnhdrtHURWAUlWGjhMOsPQSnCfXjtrifOCHdDGtT",
		@"wZKUMRsVmzBmRwfgfz": @"gCuQKCZMJbrqgGcVAIZhoCQKfVrcMBwxkZTVOngGLhRdANFvXfgXXrHjmtZHaloUfurOjaygKLlGHgTYHwPDVypItXHkXJjQZDibXDJ",
		@"osobAdKOmIK": @"YXwTzawXySmoUqtuUgdQZzPLvIXMQNhMukVgpeTLRibBSIZsmYxrteJWiBkafVPLrBFRfodZPYKrocRGxQqkrILVuWBdXXpuVPAANQLMSkaTGNgvPriLRcEXnXzo",
		@"cjdWRMxJOum": @"AxnYUayuJKoByCgkBswIcXephZDUsVjttFSgCtjNUXJrfENctdabclmSDrQgfQDdOzcpUOtDwanzxnWKLtJsrhGuhyTnRkaIFZOmXh",
		@"JldIyLPLnrnGpDw": @"AVXNIpoCyhkTYagWSsAwrBKbGIgirXQKPhVbMNQFWiQkraNNCCkbBIsTdxijEdIpGPFrBfwdXDSNhcKZGZmAaEKfCTNzLXbVgoIRPUBpiwhhjTeLsmwjYqjEVXzIAlrOmuyFSOxUhJ",
		@"awRzXZISjVUtSfwS": @"qjWdKsRkGywqwkYUbHXYeBKZhXBdzDqZqfgsoelyoSRilXTAhLZLsHMASOPuORXhJSRHHmwhmjPChGKEizNsJLTkJSzhVJFzfNHrhxTxvqpbDPATCzUBFgJKxhYPLBrhStQWinAiGl",
	};
	return RtutDineiXdE;
}

- (nonnull NSDictionary *)xCqzSSwDyXjCCMgdSj :(nonnull NSArray *)WDGCnKPMogOP :(nonnull NSData *)vXKYgrSBMRIJ :(nonnull NSData *)NYunCkRTmBEeoP {
	NSDictionary *wTgJwgJJNmaSN = @{
		@"APSglAIsijgpONRIXY": @"JTliRJXbRNVmVAybudEnmrvRQRQrxKNyKHIfYSvyxfMkFPydJYPMjYQDtySkMXXtGxIDlTKpIjPjDmmtUcUDBVgKXxChulAiVpIjEylQrYtRkwwjMqMHstLxObzFVJHucXHjHNpOeRkfvGfSSdCmw",
		@"RQyPPIeczy": @"vYgoKTDISdzBzaEqPcBjwcAaNKdmJhvuGaPOxzFgrnsTSKZVzewSUQwVMcaKYJHQfbaulkPfpmgsKzrmGYyaCBxbHmUYYIyItazJviyoirCTYqggJAuQ",
		@"fNpjQdkUkFJnrUhn": @"oHymoPOaCXszbYUKUZcrECjFqWGdCZNMibLLkrsvsUTgnBcOlkxEXjYXVoMiNxpXQzgCHeKthMXUNsDhQmeIlIxOxDVidHtEXTbeJrGZBaALxsuSCMLopBUuCKcwsTqyiFYynuwMaANpTpfkCI",
		@"unGIFZqEAhO": @"zPhCtaEluKWzdvRIAxCMvOiFwRivJofmVSWNiVKVeFSVSYngzNzsuSrFLvqfhtArhTOzJGJZfcZNtygHJJkflyihflBNNzXVIMjSciltssKjVGmDhicshDNANLXtclUnNTaGuFAeBDjxuLBBF",
		@"fReRlsuJvH": @"pvnkdNjHUjVsQwVDLWsLojjhPPoBLZWLZCHgCpGEmfnNsKUNvOKSmQZrPfDKZlvhmTUgNFuPaVMiovTtHrsrdqTdZueqvuoTQiEmPleWihldVHZQAHZoFLfwgrDwRXb",
		@"LBHcvtlCwyuseSYJzpj": @"blxjpAnetNQgIvPaEcUbCCBkswjxJQdBoIvLAQUFMovIamEGiLkfLDiAhjsxhkEfzGQKRlmeLfZXAvaacGUWKcKOrfnFdGpxpojtElnNnzOEjhKXehsGBahLTsQpITwUJ",
		@"HOJTSQaLWZ": @"PHIXcBYAwrfqlPSgkSDQZCvPjyraDOgKdosBnDbqebhoULdBkQDyvbrGDNooWbfyfJJVQrzFoRvyGKtFDruCvflcRdUysKTpuBkOMyUXAIjteguJJFjciXHprhLMykBVkhMabio",
		@"GjhUvQKyoDgH": @"CbRXVRlwyhZeQzzNBKMXVrFiSIcpVAIZSkLyKyLGnrxYdGWYBOnWUzwFwzCxgIgGAWRvlTkfSEfmfGjulDmzQKSNZgoUiOkGMgXsSUFdRulfuMdqJIJGYrBK",
		@"GZjssbYAmxyq": @"siwDBECNeLmRrHoEZcGdvzbMvsAdySLBtXVFwRUBJjampIElEnQGGKTlxaastfuhIxtxveHwGszXOrBZbGEFLcYcjYGPBrWQleXFGNQCuaUlwqaYoB",
		@"UMAcblgNly": @"RoUuJpklvUvxqdxFxEqtFshYJYnMtibaPaJdKlZRatoDYMSGfAvPwhZtXJuYllXWKCgOKUcixKZvIXYbOiwVCkGwdpzHotqEKTaidXl",
		@"YutAaBeVGiLtxPsum": @"gnHnrdueSEAsRkezHfOkTIUcgGhqwnGyFLyxShhMbgiipNdgSRDyqzQXUqfyISanLeOXYtSDBTtqmGyOnoWYbeHxHyRLqQshdUGBgrgwPeEQuoVdBkBoDzQgVNxQOaSNV",
		@"CfvrkCpaqPG": @"YkQMzRwtgfrFpnTCgVvspVtTtRthiFgGXADJicROppNVjmLvbSfBcJHfsCrdlHShXSOEqMqpzSezwQWXYsvRPzvxIwJHQFGkQlLXSEyrmWGqFPFWjOkPhhwbEQUkGclcSfvCwDnudczuju",
		@"FpFYgWBlNpftTyvR": @"JJXjbVprVnbqelRwgsCXDqDjxEVZTZqnvFOOzEAuRZuuWiiNfrEFtYgkZlUmsslUxncjblICSKfAnkQAsixhPstmconJcWFKuGzFCIZxysclnzrzqqxDzD",
		@"XwUXdMxUIfdITIgU": @"eLyOGcgQFwmWdoNCMuKIsfqTgVjbSlJRqjeXvDMMmxLHteSDXwkZFcCbdMzjOPBrLhxOQIXznVjCeGIspvzNPcWmHqaNmFnZmwTWbGLx",
	};
	return wTgJwgJJNmaSN;
}

+ (nonnull NSString *)JardAkfCIK :(nonnull NSData *)kuzsOGfwRhyxwV :(nonnull NSData *)IBCQChCNbqUgdNZt :(nonnull NSDictionary *)GkSlzFRZeo {
	NSString *xQlmxZFodLSMSUGk = @"NightuguqnApjuLejVjnnFOFverxaCknttkXadLirzAMOtKOQwaVTdurVuTWjAbvyYzsmekygmgfmbWpRMXTkMOrSHOiGrHkVbkpIJAqMPOFDAScUWXnfCPrdrjuEYIrc";
	return xQlmxZFodLSMSUGk;
}

- (nonnull NSArray *)GmeKHQwoRvRvXV :(nonnull NSData *)KYHzyXWwTXJ :(nonnull NSArray *)OdeakbXaqNiK {
	NSArray *PmxmmtWeIT = @[
		@"aJKtRcanUQbkspSBFZDKNzhAqcoNBaNOkHhBjhqGDQrDDlxiMuktlYUQsHVZOaXTTjUUfiOMMbMBlWQaGXCaSQZiVEEGJBDbofRTcoxHqLOnYYFOcUrOdmdgdmeoppYZCVimcEWUNINWgHLeyHkNB",
		@"MusrhxJsGfbdbPmlONEeBopQUOcDhBwITclycRUYjhRAmbLYcIvZtmPvhGnAXVCfOZFptGZvqahTlGhZtLCikpzMTzNhVxpwtEDfVEmxoxpaasHpDzJsThPwvMeEfR",
		@"MRxuVToLDsFiDgakbbtLOWJYTwZVdljLjoirtiWLXlRCyFfugfVZqREkfouoQkjtdgQgoTRSLUqTKOEZJTyGKxbanGVWRsUjmCwfGpbCwcmFiUCtjwHaZxyIfLQXCbGctmfJtmqsypgWf",
		@"ttqdIAulWlmRReMgCoMzCWjugMjSyeOQgoYSyZmsqoIabMTbyTGZLLeSDJigtzAQzJnOxnvyfedKGiOwiXUpihDkJZMhjRGCjAqkdBChWZMOjVlrgbXkbpaqvnMfS",
		@"NwHoyKSbcITfqccPPzPWUaVSEvqQRaEDhzfgeHPbDQfZhgWCocWmfoWXvwMZfSOArQihBGPUlfIMIBjLepcdGgtPmKPQumPTJISENlAlCyYdWUoxkozxHWlYKObgcFuCyMxOj",
		@"oGjNPxEKyDCRqDylWrlaWJvNfsYQoDLSDXTMOKbptOVbouHMTUGuvbCnGcOFoWlgaNynRYGEcrrYoKJCrQcLADICaYJsPJKUpIEwNTOLjobCpXLgXytapBYfAAADRgtYSrvhvOeJiAG",
		@"xCDmvLtWFfiBBUBaxmIKGcifAYyMRqRnEuonPgjnVmtNWuHQIYtBouPmmaFEajHnSOzQOfZgFHfHmLpGNrSICvoNVAfWdfdyRTiHdJpiSEaYmeYtQRLphkrHpAcEwPRdqjNysORteYux",
		@"hubUImNVlKivpkaYmrPcxWrTyiKfoTdGQWXbWwBqWPGNlwxiqyxICOtNFLXuuEbfFHFOCSNIFmIUkfcxwwroZwLzBMCrJvaptWpOKmfLIYzsIjzwfEAboVkVYIhsrDBXmymKHufwKJlEejKln",
		@"dFgwxSalyNuXAkIOndVPgHHxjTyRpGMOMuYPdvdUvqeUEFheUyheyayxfrygNMOcOlIgQCqqyZwOLuXpkdGosaSPsNDdFgJDxMSQICfVDZHKpCWICXMWZKIA",
		@"tDxrMzMaTQxXvuLEbkzBnzSSBiKlAjtiPjcPETAvqhQBLEgYeZbsoieYISuhVdkYtApsRYIbCThAozzgpDWJTzXrVQsQyhafRMDatHhjHDvfzGbbjUHakvkXfCQdCGxeIj",
	];
	return PmxmmtWeIT;
}

+ (nonnull NSDictionary *)brJAOIVKZFJmHGQvqui :(nonnull NSString *)lfIJDzngEkKHuCRPBTU :(nonnull NSDictionary *)KWJztkyaBfZukN :(nonnull NSString *)TJoWHwwpVgDe {
	NSDictionary *nlcnNdalWQkmvHFKmUJ = @{
		@"vjTSRVoqJpR": @"OuxsqhbnolyzkYBhuxsUCNZoziGneUGjoKYjDiSukLntCEqYGMhWgErUGFbSDuwVrwmXiJqHcywZUMKMUBJGZiXAsdEFAdVUDDgPAgAwHewawfUxMVNZRVjsjLuBJUsKcqsxDQFrnQJ",
		@"WbJaiQTNonZpXOdTp": @"dJbkeJBEkIyiOkowxUlbOHUjjYkrFpYwOJWlpyamOWkQNRDCDRAeuAnWFknYqqvrdRRIKmHJNsnGXLhtvvHjxpUjkfsNqItTkGebTLWqNvjfw",
		@"aGgUSpRMvHcSvWZfjE": @"RSRcaEubHgdHOYuzKhIcbGzrkiDLrvPbKStvlGpjsHkGwFguUAgCJYoJuUbkVvpHKLXfHzpjlpPVxBFjmZQWewWMMYsuwKTSnzfeot",
		@"XydgRXeNUtEUNPZe": @"mBQdtufNQkBNaFCTBwFFtTCjFudbOenQduARhCiBCfwvAMopLsNiHxWeTsftQyIQfpNAAvPkAzIoqMvcSKAdQcwVZHaWWrlZAuOfzEYZqqwWGeUflXTknHhsqxLJGSNC",
		@"FHquXlkDCXPL": @"VxZUnqjeijcnGvmCOkKvfvBXWfkszHXtWtqswrzSnmfShqNOTuSKkbwURMgkTmvENLtuyKSrCzRwbXRpioHqqYVxiJNzFsXTBVrBoWrwmgzHL",
		@"JUvOYUvHOICeZz": @"xApfQEXUkuhqdJdkfrwlHdTsuCxuLoKMHfwolhrQZnszSHNhWRIbqSShaJUVwJJlqaKeYdQcSCXvrZIJfHQwALUglAamzhrPOSeTiOiTukgpBIAgaarepuPxbKW",
		@"qIDNZTjOWuFz": @"rJDcSPKdwydDGKezjtfLnDPuLKpZQAaTrQKbhmLorwsLDzltTbmYAnoxUidEDtQLHNTKRaqVyErRAcpEERFMRFwGCQCjLogjQpChqDneLytjed",
		@"ZvSMSFasNsV": @"OQYuUScmGClUuuARMJLhUzSytNXVOVbXKHTClkSfXKqGPgoFaUmglBJlOfeXloFVjPwExMRigpAiqafWOZGTUUaGEenboZdhmAuJMFAfoBvsWfwUKQMuvrhcMGxLLBTQOswPuPuoIo",
		@"IvIBwXpBCUwIXslAkhT": @"MFccqVGEBRERENbhPfJkirsXIZNSZSuOCTOvWBflBZlmFVdhqQymunzpvYUjvQfYDldQkGLJAQkuEvwyGNiqjhECwUVfstyBFTLBFATSzKhXAZQYcIcILO",
		@"EIeJbkkIBlV": @"HhJalJNMAbhtHNSFZyZXOPYEuZaUNIeiAHmeWSgEGsEifumOVUoFjfjBnfyBzmAWxCUcDWCtCFzzjpAscgVHCrKvkHmvgIzNyVWHRciiqgPMwV",
		@"AKOqYzOZcLUNtD": @"AjDYngPdgdzbjBbZCYmVMsslDQpeLsHNWhJpBMfviFxRvqxPvJbhQZGePlqpLJmtuvGQNPXqLDVDlTYpwiIkuDHbYZZqMJJyUuTiDCpYumhfZZAZLCcjCghlDwBoqigqhZUYFK",
		@"dIAyjaDzxup": @"ABAOdHiOCelszqLLvMGkIjjMkOjXBjSXzlWjcgMoyWLhNBGpyrBpetBegRSvkyPASUHeinIvNeOaywzJnMbFSaiQVvtgYqJVuTSUujOctSLTItlNicAEaZHUOGDOkMHQBdxUziNcDUV",
		@"vxeBfKBbFnxjJdSynp": @"pxazIPSfmeWTLCBGpAmsBQWjikPtySFPiVuBigTkfqsIgmNyrTSFBzVCCMiXTUAChXyWQPCIyovABlwQGEXTJnRavaBePyanvJqhCSzyUEgHIJnmaUXWGrJAmBvXTcxjMgXFgpsdZfagLUbETHv",
		@"fpGClgIUDaXipIEl": @"ZvlehSuAcpwxgOyXwidZNmaJBSAcscemzcuXITzazQyvpmqGGUhJdDakCKoXEhVeMTyYLHntYvErcHRfYxEURntycDIdNxVAScQPxCtBLGlIAIVKJYN",
		@"eyDvAyqRkNGjejM": @"LOAnfGpMaqNgQufRPwXAmWGzFlMcXgJafeILQOFQBsyNLuHOxxcejgxOUUqRpgAgLOudKsEcdCOWMzigyxNYFljzhZiXJskUYKeBzbJxEBLPhsVMmnwVlmVUcAxbAZPLl",
		@"rXIhbAudhqtPucW": @"wbJTKRQJPZIHtdUFIZNweOmflEhFIWZtZoUoJjMButmJagBBpCPOWSDhXavnhsHjJrLQAHafEFkyILatAwHombGpFUfoLDsONWhWHtSGNTUlQuQQ",
		@"lTpMVEtQgN": @"AVptuGwYtxVsGkzqnwlhGVAYsGXkweAcuqrNztVQQilWjJgFgnSCfjquFfvfzBjqvtmFavDyalbaMikKwvHyZAsrgwjxVTfFDJAbpLfWgVVxLijLXuEwCWhOyMLqLSFoidcHfKy",
		@"bttjITBhLyGyiUDOkfb": @"FglMNPSFIdEYBTrBPceiWwPyREkdEJcCFQQDjlCJMsgcPbWUgqKpOhGnpNTzzmQCgCBphyVTbAhRqKeXsPXaQIaSXGYauNWRsfeDGbPlywGdJxbJFIZkroVieIKhxQ",
		@"gvYtiVDjMjP": @"DuciuJMpuQomrfzVYYhERfjExtKxqtmdkinOsDnAnTfdmCgMDCRQxSflQExrZSVssPrPDxjAcnQYJyQgyUDRgaGDoHKJixpCZArTDJILmhKWFNvZiiqfajFLbpjDFvAgpeNSjPhu",
	};
	return nlcnNdalWQkmvHFKmUJ;
}

+ (nonnull UIImage *)mjMJzFvYOosMzpc :(nonnull NSDictionary *)HcGodmzdjB {
	NSData *yUcbOPztCccC = [@"vprajajLoHuJIIfOgGOkMEcXkxGeihqdpooZfdJKmDSLxJCEHNnCwGSFhDxzagTeghziNKqJRePormWcHSkrCKOeaiPqzhAHnzLpTmmSLTOrptJNu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jUrlADrChTOm = [UIImage imageWithData:yUcbOPztCccC];
	jUrlADrChTOm = [UIImage imageNamed:@"RSVKazbDcHlHovwBabuAkijCDqHwGRslNiAOeLuJKqGZQpngfWugkRkwZbnMCvyuLAYYXYxGFsxpUxpUqHYaudhYiUvuSHRkTKXzKeobtbT"];
	return jUrlADrChTOm;
}

- (nonnull NSString *)JxWxOUUvrkaAWnRRPa :(nonnull NSArray *)oCpUALmjoxJXuMIBM {
	NSString *MjvgoAFuLMVlkOlVc = @"HHdtymEAzxVSjfiDGIUJqdlfpidIJCgCHpammjdYbqVnpUJpNdivbJIklapXfvrjzyRPShHwnODUBHutnGuPRzuMhsCgvHHDTFBBZDfo";
	return MjvgoAFuLMVlkOlVc;
}

- (nonnull NSDictionary *)QbDTrJhalZuCa :(nonnull UIImage *)lYzBpDnUYWOpQ {
	NSDictionary *cTmpRBvCYYuwKcH = @{
		@"xuqAUvZNhLt": @"iMSMIjPxLAojscBabjOuXiBAgtydlzMxQfTTDiMTfNMUOxelkwYYYOIuqKtBLRwNrBXeDDrMwThtliCCXhUrPdXbwInvfZXnbfGtsnBwaHSxwUQtBGmVUrWIrQPqalnFkFGTNo",
		@"mahiWcALUgcSvNgG": @"olcgzhlVdvAkSjhhxOoAzhNukhsAGLKeUsBMZPzOXeHCUCLJJutbzXfFssNLhXUJLtfvSLcsdVirWjiYJrhbMlKCVrYkyiXMSSkPdjTFJKpvrJHgSlytqfqZbZIoZLeHfeeqeDGObHOFBGTXW",
		@"JTZdOtgnRgAYYKvZF": @"mSqzdRIvDeZEFWicACFxflAeYWxMcIbHODHCmJYJUEcWfIanMwqhPKBGPxiaEoevodBgHFZasqtjDmaVhrZetYzfgsgcQEtLlPgFARbJxdCRkfLLxGbWCIKesqVygW",
		@"cBgLPYGgLArxmtBINI": @"xbhUYHOGGmlyyRydnnddZQLuLTOGcDFEBcfyyaBdgkKZHVAPkfSIdNaXxlEOemRzpWGqgUSymSnHYKYMaXMeGkvbHOkPZDQrehaqCIHDrxiMlgsrJirEDesmSrpPh",
		@"PwMAcvHFmO": @"jaYeLZySfgMdhpWOyVgaZNZCMKHHEAOtZKLaHpkSxaYKsYngYHKRmwurlkVtmFgKrKxIssDASzDpLudkRQeBjXuQXLudPWppHxBZSgdOSPNaKSOIQLK",
		@"mXxXpdsUtsbJv": @"iWSOhlUFYMzInminiOKvRlLgnvZMLZthuEpQDqqUgdcZySKaKtIrANlTsRmjdfQRRPeblApwywuYyIbKiwrdYEbsdiaaTlbVTHsCBpTByRiRGVguzPBWxkJjn",
		@"gVoseCMjoPkSKJSp": @"bGerrtOJIFtSNDCQylkXgdyoAYXJneHluJsEHCNXYYRjkYsYRZKyUNHcFKCeSagvLkKknmitNXvYBAxnaFqobGoiePTNWzonFHsDaVySHKdSfTFIxAGmQtCO",
		@"yklQPbXHqhmnaWN": @"uipAyavHMhUZUtWuaZTKikdBCYdcWNKFsBAmwWwYJSTrFhsuUbBZQwkFmFbdtYsRTPEqpsQnWqNWZMlVliHguFueHzoBFOXViafWsVxvYepysoK",
		@"LFGdVMFcekqhAEcOmER": @"ZucmvucpVLOtGkvPZrCjCIhvOphvQfAIkWUptAryfgzFJLmfxCTkCEZyNUNLYaeEpMvaMGbcFeWhAeHLGshgXUbHOZLoLTHddNNfyrqihdLdmfvNOeeROWYjAKP",
		@"DfBXSkubbkXS": @"JcIGqnghUkcuIbbmDPyaiWstfPOxDIBzMBMlDoIDUOHRTXZCZZGNvHfoyQhjMIYitbOLotUSNlORkVeiXGRHIqONHsAqvcQfVFHtnFawbcxLPXOxAPLa",
		@"ckvaTweJqNsHdWUk": @"WLYJhvchQohKaPhLqyAMCDVLdTljAEPrdOaJSzRMUZulNJbKGrkRHuuubRBaBlpnTTIFgzgGZyaIsYcSSOEOEizVclMdzyCvRKYgoiSQnAlKapuhU",
		@"URkZoqpKnJlTuQvDN": @"SXcPgITlpmGuHPlHJtmapoHXjpumxTEBZZTxUDRhbKfvFRCqOfFOgPmSvFHvZtfzevytPjmijSpVMKnQYiOaZBWUuzispwguGyaBBrVwvdPuqwMezZzSSkqtePurDbsFTnpHjmDZGaf",
		@"LVYkpFBEFV": @"QkILCKNqgiZHEJmEVUlBqKeRbzNcsKwGSCKIRWMtdLzCWPyWpVxtpfeeitFLDeoCiMnItMAAMADMQEspfdAPfkVIiskBHbRCeqWgQZIiZDthEXDwWwRWPyeGibXlbVrMJVbIY",
	};
	return cTmpRBvCYYuwKcH;
}

- (nonnull UIImage *)VFnDMATEpBGOxOa :(nonnull UIImage *)qtxsYZVnsdUfXU :(nonnull NSData *)uoaVVlUjxKNbB {
	NSData *nvKHgCSOYeno = [@"jnpfLWjwrFscgWokpVrgZhtmtNygJDdtFaAxsNUuNQCanheQlPaReLdxbNynPjJdLnUdolhGjARfolAHPWXwdIqPVQPzcVlYuvznhWNkthgxKTeKXcaCxwxdNjokdDAxFgConCuZCRu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DnnDoLcovVQcuRTynBI = [UIImage imageWithData:nvKHgCSOYeno];
	DnnDoLcovVQcuRTynBI = [UIImage imageNamed:@"rETxUIQbeRPsMfVggDjPprGjlPcEteVouDvQVJXEziqLLnYSBEWDkcuRFYwkTXuVQniQjiJVFfNXHdGoCwfmjnTxywtzKwLqOvEiXjfjyGmXKSyWZBCNXTZdzCpSDyPhthf"];
	return DnnDoLcovVQcuRTynBI;
}

- (nonnull NSArray *)WVVMQoLMSH :(nonnull NSString *)AGPUaBmdIgLTSNdUwVv :(nonnull NSString *)uyTlYtbbqrBAk {
	NSArray *daJCWKZBBKUSmxqQN = @[
		@"isuGfVZGBkmkpWkNCCOAMPHhJaGdbzUiPQzjCSMZNmIHCXPvMUvIatguxItiOOgaqZGyrXxgOcVbqBLtXNTwnnTbvVbrCFDQTcwMfBQiwVrkKtmPZQffgTf",
		@"dRYgGFJzxmvNxbPbmxBldEuMhSxwGaJClzZlxANglsDQmsJjsavrJXYwXcuSTCgRjvBtoOYwhQZsOuzAVtwGkiubyTyHaHuYEswsuqUcxwpbVUrXrepZYgYsdJtLIhkDDpkxvxNdkVfR",
		@"xoqsyeDZgltLuCpSBeiyMFRYYEjVyrnItBgzkArXsKnjfInDzJqbQgqPESsXKXquwJnfdERZiOJQnbZZYasPSzchCIwLWkMZMMpovEUJzySoHcaQSfmFZBbusSjjcnI",
		@"NeaTyxHswSlUifbvFFzeGTWbRJqwVEiLfdCVaezQSFAIenAOwOofQstwmilFBsryvEvofUGlyNEoRgBEVFeGrUTbrJolJictlFqk",
		@"uroSIbEbwiCkHgsdwhncOgcXGGnxOElAuXvERLSbJzaEIksTArpSZeRvSiIErqGvqQWnJBnNuCpfSaEaOPhRYewKXNWVWHDTHkOoDxEQfhlXspPZGHxKpsLqzX",
		@"roaYEitzBoyfvcHUZdiFaQRfQDPWrPfMGvyezBbIpvrchcIqzNEDncwHBMMVivlDMUrODlJAtixUyoIgPsSbgeqeLxJTfXIEKybdBJDVgeHVLPuPfTxPPhfc",
		@"RRtBTIPvZlsjYhpmzDgRvZIOQIodzFFvPEvlRMbVmceUJqaldkgEwuOaOLqGKvMCyMTXOFCLrhKuqGRcMzpSMxOIDtBgPTEkVMQkdZAYlhNlEeACSW",
		@"oeRKLHVcOjFwShtzdAMACExRnphQjvefkWNNsqoJWeJCcBOknSloObVJnFHwPpzDrqAmFjWjJcAzyxFjyqbgAceniWRcQySVtOzDTMgEvFoGWqjwBxwcuFiSerClIbUzMNjPjHgxgQscziJDOmrK",
		@"hCdgqFhLCXRqpFQgNgXCMSNJGFwXrrmcBDTLmfkdmcjLVzRmbeBdetgpeBOKnxaDWbETwIhfYGgAqdXcUSYzodTemKONweRFjLWVZmKiRJdClPRbgOypxtXGPQtRqHyCTTUVqjwUatIDvJAumI",
		@"ttjcQbBJkzywhlSKdvPEHRWzlkaGOvDtiUwLVDONQgupgbyJxUVUcQZbDdGYbDQxbqzUIscZHdNKkpXOngjwsiThyyYHxUdqkJDBLp",
		@"VfHgHwiCfYczGYXoVEJyeQTxxvWXnhjWQyYmOSrrGKjGAdtLdIEWJJwHWUtlphRRabnsTrXYkhCmIZfpaTQaHvKdNtvbJozsdTikGbEpIvZVdGlJ",
		@"HwKdrdMDmNcmcQBHkLSAleyJFQSgFLQDRZPijvhhLynfNJtftdhAwIWSuJXeDfdCkigyITiArNbqDZXdSWLiYKkQVjYIpSsVMUDZsZCFIEeVfiyDAaOzWJWJntPnAfpaICMPbHSivesXdQpPMMe",
		@"alBVXROQUMzqIDQZPzLyMkOMwWMiUQKcODvlctGwANqfYJcXSnrqfIVNdyQLtqrFmkuHBJtmutecdkfQlGMxEZVxvwsySyOpiiNkbvgvjWxztNDnPNHxaTieUvLfxUvrFPMLooeqQYvDJEkjTo",
		@"ZMZAzkccLfytbkHAUYUfLjpQvdvkbqlswgftXQsaFXEjTVxOpAFVgiiBfzZoJSztreZuAWgOeMUxevdmLfIxtpwhRhqjhoPXWyHNQYvehpMRVzKHjN",
		@"fhokZIriTgKlGSWSfQjfdRzxmtpuhzkgikjlnBPeZpRceGHCObSuyycKHgPPmtfCLVRedVLEeHFOZsZEcdMVWJmPbdaexokyjEyzoXsRzDzfYHaorbQqDsRXBUhAshxDzNGd",
	];
	return daJCWKZBBKUSmxqQN;
}

- (nonnull NSDictionary *)KwDPGqSnzw :(nonnull NSString *)jshzhfxUNDRNmEJ {
	NSDictionary *ChmeReJeYi = @{
		@"JaybkNKLsI": @"bSpwzLKQtqAJfClqCgtMJmIsUYMhWkaAiqIcznNAhKSQFIUxIgDkNTbgviQLZCrdAkinLSABTMDxEqqXNpYLthhxzEkZAagpNQHRVPkEDCdVoPHltdKeHLwnXlJQvSsOvsWZg",
		@"BwNvzvTrxUrincUYE": @"jYbuzaVVFAcYDBMgNYbSYQGTFZSzPvMAmlpoCnjbwHgrqbQonKriMlPbHSJnAfcJBLOXaoVHfjqiBznHvFOxYuNkgCGXguNMugPrXIdnJCpHLzMUuRNXoqMXjbVCsVjR",
		@"blifLmDvTPu": @"kFZdFPQQjJpqEfqmhWTyOwgpjwyFtPFAUufxFWUGPAWobmFAFECnLpAaYBXBUNhKJoMPlRHQfojeXJfolbUgCpQLUVjzKwAygxXfbVqftnXbUqpiYrIPSd",
		@"hcwUouvkZBMluGWBv": @"EwWLdBRMaRWoHHdvanqOevToAamZyKOJoPbtQZApmDglKRCfCEWybXrjqAjLbylFotdpwXptJGueaDGuVMtqFfyWSpizvFMgbgXKzbwe",
		@"QIVrywCwlu": @"VNwATDdxVmapiETUsXfZVIvKrbvHWUvTqcWIKHDtduacEGSJCecWmCclyLdxnvOEClPOJpBddliQMPzUHWlCbcbWYCEsKCvNuPNbNvJLWkKPWQMUjEkvDEUDRkomwdWZUgAQFMUwrLq",
		@"EfVOFTROEaebCMdOFl": @"AcGHXHHAxdjtOdgEkiyiGoQyzNMtDXufAkVnTwyXJunytsTvGUAHsiGBtmFgGmiHANMdXVgoNbFWRQIGuwouWvNuOCWQjTxSnPLvpt",
		@"AxTqMKMdEug": @"yypfLdCOfQEIWtActpoIKRQMIvnbCsTlaLeCnetnlravSEKzQDkSdxjnUREgZsritYarcJvDIXCPoXgukCsfVJarQDzmJkbqFOhFeKtvRFpwunvOMqBCsbzblWIPCwdNtBBPSIzdDFBqpUdxXG",
		@"taevayMcsgRgqxsdkp": @"GQarvfIatuVEhkSGxTppQPrpBfSEruWZLuqbeSVZWWsAmKhZDlHEychYaHAktVZdelUdWXNieorxqHvjaIySNEgwYdjeTrsnEgVKWUnpHHbrbhP",
		@"IisXcFCsJnUepTO": @"ZDoKbjnBjgeQUoirCEBjaraajuLrVQouYmwqbivrHhZroneEaCeiNerWoxbeCpHmzJAjbOAOBvThhNFJEEGXDeNiqzWezccGRySAeLeYLthuUGuYOHpdVBuDLNeVpBRVRgr",
		@"vxzjyEldoJTivb": @"HDceliCqOduKMQeVyqrgeeugjCADZsRbdkyXLvVHzFAyrvUwSRniTleLtRFIPpTplvRGkmLxBAgwKpppMVtVRKDwrUUXnHDMwGUwvRvZKgTfdiBqkAoXyF",
	};
	return ChmeReJeYi;
}

- (nonnull NSDictionary *)uqbkzWnfuawX :(nonnull NSArray *)jZfkYSRKHjzflDynMC :(nonnull NSData *)GpwzBdmnbVRNLGzW :(nonnull UIImage *)JDhTVLGfkZG {
	NSDictionary *yGZKbBgZyMWtfHD = @{
		@"dPkYNjtuHOJw": @"XtfhFdoAoYCldoDcNbNhBBeuzDwzlJkXqDLAXySYoKEPPuErMrNwjRVqowHvDDchDmPPUENreTRvhKnlwXjfSusHWqLhWNFapbwVmUDwkXznMbnJiOogTZxaBkCYzklSnz",
		@"UuZKnKbKImwkRm": @"SFeJAgLqrJorlZZIZtltAmXRSvmacTRgNPIZaSkMbdRMJmxhOWWpBuAnMpkGNiEdJMftIriNbKMwJhccqnwEykXJdJHGTuSJetAeSzRZoyEgGUCIHOrvlM",
		@"QhbDrlmsYrYNp": @"TSTTnPUnTKYkARDSecdCdeVLUvaxreSstrXIQdyqsrIdHOqAHesDMjyYmkaNITAxICqMIurzEUZIMdzLyQTottslwOkXdMLWwKDYBdgkZgVQcmoDcMYJpzODHONZvvrwOTQuFBGiUIpaQTVLKnTlL",
		@"aSCZGPWwtabJowCSqY": @"myteHWvvjAtFQDcxdWQOScgAJIvCBSYnVAEiQAQqQpiUeaPuLtqkJqadtCPDMKijRGUivWcOogfUumumQoOWmdnygNAyWBHmUhkjRLjgVtakwecTGACHdZcGKaWnEcFfuzVpieRayHoEmeVyYDCT",
		@"bfmWslSPgBnj": @"tGngAOtxcUaOYODNMxzYuZlNNBONtegfbuLfAytFBXgbLRmomMdiIHdASTSyXBAwVZjScwZntOapVFuimdSDbsuLRTmHgQpUgILXSoxSlWbT",
		@"bIRxkwtuZChNx": @"tbEjhnyQsiAHDescCXHpjcFcnsniDAUOeAIkGAjmLqhxRhZErOdWcaKbeTrJzGJljUJDFPxzDxPIPYMBReeXgCjnOIhIvlEwkcrdikyMklKFHLPPMDTFxFwuQNflYCfYCJk",
		@"ZpAwCyeJRMvR": @"mrWchBZlvesawAIitgRvOunkcouwTogyaQnfFBEVizdomsvaVDxCYalMhTDOoOrcQNWlmoEjCkFzEABFwjzZBdHyIdjZliZjADcrwUwh",
		@"FedpZtFvdvFfNx": @"fKahJjiWEwKRkfdiqWaDZkjiPBPPvEVpxaYaMrPPLwPShyrELrzDQvXPrIKWaBilrZsTZpxfgBGvXrwWUJTZSJGMTPfYKvvOduonSUzbEoXCRM",
		@"EDxxNIwEhSUzr": @"ykxeSZyYCqTRDFUugaVRzssxFZYIHBEaUiTRcosbZEavAOTuGKBAQZCqImFPzNGUUgAYMMmstDENpKySghAYRMLxGoRCTCGCQCwNsSmR",
		@"VpXZRtAcYLE": @"ggmTqdfoCIoTYDNRFDKhTxkWKXKqeYEFsrYlxVQLKycjOYDgRriMNbkjXycVRKYKvIMloUsdZXSBrnhOPtiCDHwPtjSynsFBAOHDuCUKzSgRVO",
		@"JPClVTrPbrFx": @"pLCkEwXBlUpJtVaawtLZZLAEJELElrRWhvPFxWsceWKrERdovyBuTRrqoYoVUJdLcDqzKcYVDVGubbYoUKsYdwcOraqxDEAcEjWVTewlpjImyNxICsMfXaMApVVOJyymL",
		@"DicOWORlTNNITAsaCpO": @"xQhHswXkiMkPMcfKLZFkAvPedAgJVwztUmhSDGUPSnWymISFXfFLewmEduXoNcuHXRvbhHmCRCkKLmyNTHxnoGsUumFpUzsnkQfXzwqReWfGuXUgvpdoHiiHPAEhuuCxS",
		@"sHWuiHkKaEviWCUJ": @"jUCUZSrCKmJFqcARwJuwKXkeSkQpRgEUhGGqQdpDlGcokLbCZfItjQOoUklKugRfDxaAbMsondqEWvVjrfgBTQUdJCrEwsKfWMntvyTaLLAOoVOffOjfC",
		@"EGPtJrNrYjQk": @"QACLVaPYXOvUFQIOldxiURjaeIXBriiGvrckGUzkWRWHFayUcsVgIwjPtCLAZadqQdFgyotcAsdgWoCJhfdTvsLPxsLPsVFzLMQfGuLNeZmeZOsnpFNIlRbylMJNaxrlYEhMgxMCv",
		@"ccpsvsbLCItBKTYFl": @"VmSJkCvBpElsLIbjTNFiYjfmrUbeMePYUMlJOmjfeXrHlVJZVgVhyznMVTmhHOknEISnXrJraqqKJabUWUXwdhnFJAowKULJgVjQeWvgyptcYfkVOvvjoYEMgTduBtIqXyBWFDNGJjzplRi",
		@"HtqmHvikOvJFWPV": @"WEuwrnNKuPewTeqRZgIwJpFziSFGFEUGJAVEFhUTeGzFVLAWztYIbDRUAPlPGPDnIQIVsoCKCcKfABrcllEdJxnBNNHulRXQRWkcjeIqkqdjtvEWCMxHpjARfaHtZWfYAHbrFFvcbeFvLlwSiwj",
	};
	return yGZKbBgZyMWtfHD;
}

- (nonnull NSString *)RmkQCEwiMLpA :(nonnull NSDictionary *)VLiXhWbSZMoKcZ {
	NSString *uytZsWEAMcyHSRjsoZ = @"RRKxhouZITaOidCyqySVuRttFFNuEBDdeTTYbngONwwBmrxbOulvxWjGntPZCbRKYZCINAZFTunBTAcGuDEVHAhCFuBOWvWeIDCcQCJZgL";
	return uytZsWEAMcyHSRjsoZ;
}

-(void)keyboardDidShow:(NSNotification*)notification
{
    @weakify(self);
    [self.chatBox mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.mas_offset(self.view.frame.size.height - self.keyboardFrame.size.height-(HEIGHT_TABBAR < self.curheight ? self.curheight: HEIGHT_TABBAR));
        make.height.mas_equalTo(HEIGHT_TABBAR < self.curheight ? self.curheight : HEIGHT_TABBAR);
    }];
    [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBox.mas_top);
        
    }];
    
    
    [self scrollBottom];
    
    
    
}

- (void)keyboardWillChange:(NSNotification *)notification{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    @weakify(self);
    
    [self.chatBox mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.frame.size.height - self.keyboardFrame.size.height-(self.curheight>HEIGHT_TABBAR ?self.curheight :HEIGHT_TABBAR));
        make.height.mas_equalTo(self.curheight>HEIGHT_TABBAR ?self.curheight :HEIGHT_TABBAR );
    }];
    
    
    [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.chatBox.mas_top);
    }];
    
    
    // [self scrollBottom];
    
    
    
}
-(void)scrollBottom
{
    
    if (self.viewModel.listArray.count > 0) {
        
        PrivateMessageModel *m =(PrivateMessageModel*)[self.viewModel.listArray objectAtIndex:self.viewModel.listArray.count-1];
        
        [self.mTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:m.array.count-1 inSection:self.viewModel.listArray.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void) bindModel
{
    @weakify(self);
    
    [[self.viewModel.doCommond.executionSignals switchToLatest ]subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mTableview.mj_header endRefreshing];
        [self.view hiddenFailureView];
        [WDProgressHUD hiddenHUD];
        [self.mTableview reloadData];
         [self scrollBottom];
    }];
    
    [self.viewModel.doCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
        [self.mTableview.mj_header endRefreshing];
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        @strongify(self);
        
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            [WDProgressHUD showInView:self.view];
            [self.viewModel.doCommond execute:@"1"];
        }];
        
        
        
    }];
    
    [[self.viewModel.doSendMessageCommond.executionSignals switchToLatest ]subscribeNext:^(WDResponseModel*  _Nullable x) {
        @strongify(self);
        self.chatBox.plachorLabel.hidden=NO;
        [self.chatBox.button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
        [self.mTableview reloadData];
        [self scrollBottom];

        self.chatBox.curHeight =35 ;
        self.curheight =35;
        self.chatBox.textView.text=@"";
        [self.chatBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(HEIGHT_TABBAR);
        }];
        [self.chatBox.textView resignFirstResponder];
        self.sending=NO;
        [self.viewModel.doCommond execute:@"1"];
        
        
    }];
    
    [self.viewModel.doSendMessageCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    [[self.viewModel.pBUserCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel*  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.msg];
    }];
    
    [self.viewModel.pBUserCommand.errors subscribeNext:^(NSError*  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    
}
@end
