//
//  HYUserDetialViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserDetialViewController.h"
#import "HYUserDetialViewModel.h"
#import "HYUserHeadCell.h"
#import "HYShowPicCell.h"
#import "HYUserDetialBaseCell.h"
#import "HYUserDetialDescroptionCell.h"
#import "HYNavigationBar.h"
#import "HYuserCenterShowPicViewModel.h"
#import "UIImage+blur.h"


@interface HYUserDetialViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

#define HYUserHeadCell_ID @"HYUserHeadCell"
#define HYUserCenterShowPicCell_ID @"HYShowPicCell"
#define HYUserDetialBaseCell_ID @"HYUserDetialBaseCell"
#define HYUserDetialDescroptionCell_ID @"HYUserDetialDescroptionCell"

@property(nonatomic ,strong) UITableView * mTableview;
@property(nonatomic ,strong) HYUserDetialViewModel * viewModel;
@property(nonatomic ,strong) NSString * uid;
@property(nonatomic ,strong) UIView         *userOprationView;//心动和私信底座
@property(nonatomic ,strong) UIButton       *isBeMovedButton;
@property(nonatomic ,strong) UIButton       *isPrivatrButton;
@property(nonatomic ,strong) UIView         *stickView;
@property(nonatomic ,strong) UIView * blankview;

@property(nonatomic,strong) UIImageView * imgProfile;
@end

@implementation HYUserDetialViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    [self setUpview];
    

    
    [self subviewslayout];
    
    self.viewModel = [HYUserDetialViewModel new];
    self.viewModel.uid=self.uid.length==0?@"":self.uid;

    [self bindModel];
    
    HYNavigationBar *b =[[HYNavigationBar alloc] initWithFrame:CGRectMake(0, SCREEN_STATUSBAR_HEIGHT -20, SCREEN_WIDTH, 64)];
    b.mtitleLabel.text=@"";
    b.mtitleLabel.textColor=[UIColor blackColor];
    b.block=^{
        [super popBack];
    };
    b.rightBarButton.hidden=NO;
    [b.rightBarButton setImage:[UIImage imageNamed:@"warning"]  forState:UIControlStateNormal];
    [b.rightBarButton setImage:[UIImage imageNamed:@"warning"]  forState:UIControlStateHighlighted];
    b.doNextblock=^()
    {
        [YSMediator pushToViewController:@"WDCancelMyAppointmentViewController" withParams:@{@"uid":self.uid} animated:YES callBack:nil];
    };
    
    [self.view addSubview:b];
    
    
 
    [WDProgressHUD showInView:self.view];
    [self.viewModel.doCommand execute:@"1"];
    // Do any additional setup after loading the view.
}


- (void)setUpview
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStylePlain inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    
    [self.mTableview registerClass:[HYUserHeadCell class] forCellReuseIdentifier:HYUserHeadCell_ID];
    [self.mTableview registerClass:[HYShowPicCell class] forCellReuseIdentifier:HYUserCenterShowPicCell_ID];
    [self.mTableview registerClass:[HYUserDetialBaseCell class] forCellReuseIdentifier:HYUserDetialBaseCell_ID];
    [self.mTableview registerClass:[HYUserDetialDescroptionCell class] forCellReuseIdentifier:HYUserDetialDescroptionCell_ID];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
    
    
    self.userOprationView=[UIView viewWithBackgroundColor:[UIColor blackColor] inView:self.view];
    self.userOprationView.backgroundColor =[[UIColor alloc] initWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:0.9];
    self.isBeMovedButton =[UIButton buttonWithTitle:@"心动" titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10) titleColor:[UIColor whiteColor] fontSize:14.0 normalImgName:@"heartNormal" highlightedImageName:@"heartNormal" imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10) bgColor:[UIColor clearColor] normalBgImageName:nil highlightedBgImageName:nil inView:self.view action:^(UIButton *btn) {
        @strongify(self);
        [self.viewModel.doBeMoved execute:@"1"];
        
    }];
    
    self.isPrivatrButton =[UIButton buttonWithTitle:@"私聊" titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10) titleColor:[UIColor whiteColor] fontSize:14.0 normalImgName:@"chartNormal" highlightedImageName:@"chartNormal" imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10) bgColor:[UIColor clearColor] normalBgImageName:nil highlightedBgImageName:nil inView:self.view action:^(UIButton *btn) {
        
        @strongify(self);
     
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        if(![[HYUserContext shareContext].userModel.vipstatus boolValue])
        {
            //todo 购买会员
            [YSMediator pushToViewController:@"HYMembershipVC" withParams:@{} animated:YES callBack:nil];
            return;
        }
        [YSMediator pushToViewController:@"PrivateMessageDetialViewController" withParams:@{@"cantactName":self.viewModel.headViewModel.username ,@"cantactID":self.viewModel.uid,@"avatar":[self.viewModel.headViewModel.avatar path] } animated:YES callBack:nil];
    }];
    
    self.stickView =[UIView viewWithBackgroundColor:[UIColor bg9b9b9bColor] inView:self.view];
    

    self.blankview =[UIView viewWithBackgroundColor:[UIColor bgf5f5f5Color] inView:self.view];
    [self.blankview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.blankview.hidden =YES;
}


-(void)subviewslayout
{
    @weakify(self);
    [self.userOprationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.mTableview.mas_bottom);
    }];
    
    [self.isBeMovedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.userOprationView.mas_left);
        make.top.equalTo(self.userOprationView.mas_top);
        make.bottom.equalTo(self.userOprationView.mas_bottom);
        make.right.equalTo(self.userOprationView.mas_centerX);
    }];
    
    [self.isPrivatrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.userOprationView.mas_right);
        make.top.equalTo(self.userOprationView.mas_top);
        make.bottom.equalTo(self.userOprationView.mas_bottom);
        make.left.equalTo(self.userOprationView.mas_centerX);
    }];
    
    [self.stickView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.userOprationView.mas_centerX);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0.5);
        make.centerY.equalTo(self.userOprationView.mas_centerY);
    }];

    
    self.imgProfile = [[UIImageView alloc] init];
    self.imgProfile.frame= CGRectMake(0, 0, self.view.frame.size.width, SCREEN_WIDTH);
    [self.view addSubview:self.imgProfile];
}



- (void) bindModel
{
    @weakify(self);
    
    [[self.viewModel.doCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [self.viewModel loadSection];
        [self.mTableview reloadData];
        [self.view hiddenFailureView];
//        [self.imgProfile sd_setImageWithURL:self.viewModel.headViewModel.avatar placeholderImage:[UIImage imageNamed:@"defauleimage1"]];
        [self.imgProfile sd_setImageWithURL:self.viewModel.headViewModel.avatar placeholderImage:[UIImage imageNamed:@"defauleimage1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image)
            {
                @strongify(self);
                self.imgProfile.image = [self cutImage:image];
            }
        }];
        
        if(self.viewModel.SectionArray.count==0)
        {
            self.blankview.hidden=NO;
            [self.blankview showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                [WDProgressHUD showInView:nil];
                self.blankview.hidden=YES;
                [self.viewModel.doCommand execute:@"1"];
            }];
        }
        
        
    }];
    
    [self.viewModel.doCommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
        [self.view hiddenFailureView];
        self.blankview.hidden=NO;
        [self.blankview showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            [WDProgressHUD showInView:nil];
            self.blankview.hidden=YES;
            [self.viewModel.doCommand execute:@"1"];
        }];
    }];
    
    [RACObserve(self.viewModel, isBemoved) subscribeNext:^(NSNumber *  _Nullable x) {
            @strongify(self);
            if([x boolValue])
            {
                [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartSel"] forState:UIControlStateNormal];
                [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartSel"] forState:UIControlStateHighlighted];
            }
            else
            {
                [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartNormal"] forState:UIControlStateNormal];
                [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartNormal"] forState:UIControlStateHighlighted];
            }
            
        }];
    
    
    

    [[self.viewModel.doBeMoved.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
     
        @strongify(self);
        if(self.block)
        {
            self.block(self.viewModel.uid, self.viewModel.isBemoved);
        }
        
        
    }];
    [self.viewModel.doBeMoved.errors subscribeNext:^(NSError * _Nullable x) {
        
    }];
    
    
    
    
    
    
  
    
    
    
}



#pragma mark --TableviewDelegate--
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.viewModel.SectionArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    
    switch (index) {
        case HYDetialMainPicType:
        {
            HYUserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:HYUserHeadCell_ID];
            [cell  bindWithViewModel:(HYBaseViewModel*)self.viewModel.headViewModel];
            return cell;
        }
            break;
        case HYDetialShowPicType:
        {
            HYShowPicCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserCenterShowPicCell_ID];
            cell.delButton =YES;
            [cell updateArray:((HYuserCenterShowPicViewModel*)self.viewModel.picShwoViewModel).picArray ];
            //[cell  bindWithViewModel:(HYBaseViewModel*)self.viewModel.picShwoViewModel];
            
            cell.block=^(int index)
            {
                NSMutableArray *temarray =[NSMutableArray new];
                for (int i=0; i<self.viewModel.picShwoViewModel.picArray.count; i++) {
                    PhotoModel * m =[self.viewModel.picShwoViewModel.picArray objectAtIndex:i];
                    [temarray addObject:m.url];
                }
//                [XLPhotoBrowser showPhotoBrowserWithImages:[temarray copy] currentImageIndex:index];
                NSLog(@"index %d",index);
            };
            
            return cell;
        }
            break;
        case HYDetialBaseInfoType:
        {
            HYUserDetialBaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserDetialBaseCell_ID];
            [cell  bindWithViewModel:(HYBaseViewModel*)self.viewModel.baseInfoViewModel];
            return cell;
            
        }
        case HYDetialbeFriendType:
        {
            HYUserDetialDescroptionCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserDetialDescroptionCell_ID];
            [cell  bindWithViewModel:(HYBaseViewModel*)self.viewModel.befriendViewModel];
            return cell;
        }
            break;
        case HYDetialInterduceType:
        {
            HYUserDetialDescroptionCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserDetialDescroptionCell_ID];
            [cell  bindWithViewModel:(HYBaseViewModel*)self.viewModel.interduceViewModel];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
    
    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    @weakify(self);
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    switch (index) {
        case HYDetialMainPicType:
        {
            return [tableView fd_heightForCellWithIdentifier:HYUserHeadCell_ID  configuration:^(HYUserHeadCell* cell) {
                
                @strongify(self);
                [cell bindWithViewModel:(HYBaseViewModel*)self.viewModel.headViewModel];
            }];
        }
            break;
        case HYDetialShowPicType:
        {
            return  [HYShowPicCell  GetHeight: self.viewModel.picShwoViewModel.picArray.count];
        }
            break;
        case HYDetialBaseInfoType:
        {
            
            
            return [HYUserDetialBaseCell getHeight:(HYBaseViewModel*)self.viewModel.baseInfoViewModel]  ;
        }
            break;
        case HYDetialbeFriendType:
        {
            return [tableView fd_heightForCellWithIdentifier:HYUserDetialDescroptionCell_ID  configuration:^(HYUserDetialDescroptionCell* cell) {
                
                @strongify(self);
                [cell bindWithViewModel:(HYBaseViewModel*)self.viewModel.befriendViewModel];
            }];
        }
            break;
        case HYDetialInterduceType:
        {
            return [tableView fd_heightForCellWithIdentifier:HYUserDetialDescroptionCell_ID  configuration:^(HYUserDetialDescroptionCell* cell) {
                
                @strongify(self);
                [cell bindWithViewModel:(HYBaseViewModel*)self.viewModel.interduceViewModel];
            }];
        }
            break;
        default:
            break;
    }
    return 0;
    
    
}


-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor =[UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:section] intValue];
    if(index ==  HYDetialBaseInfoType || index == HYDetialInterduceType)
    {
        return 0.01;
    }
    else
    {
        return  10;
    }
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

- (void)updateImg {
    CGFloat yOffset   = self.mTableview .contentOffset.y;
    
    
    
    CGFloat ImageHeight  = SCREEN_WIDTH;
    CGFloat ImageWidth  = self.view.frame.size.width;
    if (yOffset < 0) {
        
        CGFloat factor = ((ABS(yOffset)+ImageHeight)*ImageWidth)/ImageHeight;
        CGRect f = CGRectMake(-(factor-ImageWidth)/2, 0, factor, ImageHeight+ABS(yOffset));
        self.imgProfile.frame = f;
        
        
    } else {
        CGRect f = self.imgProfile.frame;
        f.origin.y = -yOffset;
        self.imgProfile.frame = f;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    

    [self updateImg];
    
//    CGSize size =[UIScreen mainScreen].bounds.size;
//    float scale = 150/320.0;
//    float gaoodu = size.width*scale;
    
    
    
}

- (UIImage *)cutImage:(UIImage*)image1{
    
    if (image1.size.height>image1.size.width){
        image1 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image1 CGImage],CGRectMake(0,fabs(image1.size.height - image1.size.width)/2.0,              image1.size.width, image1.size.width))];
        
    }else{
        image1 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image1   CGImage],CGRectMake(fabs(image1.size.height - image1.size.width)/2.0,0,             image1.size.height, image1.size.height))];
    }
    
    return image1;
}

@end
