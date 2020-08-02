//
//  WDCancelMyAppointmentViewController.m
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDCancelMyAppointmentViewController.h"
#import "WDCancelMyAppointmentViewModel.h"
#import "WDCancelCell.h"
#import "WDNumTextView.h"
#import "WDReportModel.h"
#import <TZImagePickerController/TZImageManager.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "HYReportView.h"
#import "WDQiniuUploadHelper.h"

#define WDCancelCell_ID @"WDCancelCell"

@interface WDCancelMyAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic ,strong) UITableView * mTableview;

@property(nonatomic ,strong) WDCancelMyAppointmentViewModel * viewModel;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic ,assign) BOOL editorEnabled;
@property (nonatomic ,strong) NSString * uid;
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *memo;

@property (nonatomic ,strong) HYReportView * numberView;
@end
@implementation WDCancelMyAppointmentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor bge5e7e9Color];
    [self setUpView];
    self.viewModel  =[[WDCancelMyAppointmentViewModel alloc] init];
    self.editorEnabled =FALSE;
    
    [self bindModel];
    [WDProgressHUD showInView:self.view];
    [self.viewModel.getreportListCommand execute:@"1"];
    
    
}

-(void) bindModel
{
    @weakify(self);
    [[self.viewModel.getreportListCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [self.mTableview reloadData];
        [self.view hiddenFailureView];
        if (self.viewModel.reportContentList.count ==0)
        {
            [self.view showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                @strongify(self);
                [WDProgressHUD showInView:self.view];
                [self.viewModel.getreportListCommand execute:@"1"];
            }];
        }
    }];
    [self.viewModel.getreportListCommand.errors subscribeError:^(NSError * _Nullable error) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:error.localizedDescription];
        [self.view hiddenFailureView];
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            @strongify(self);
            [WDProgressHUD showInView:self.view];
            [self.viewModel.getreportListCommand execute:@"1"];
        }];
    
    }];
}

-(void)setUpView
{
    
    @weakify(self);
    UIView * topbgview =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_STATUSBAR_HEIGHT -20, SCREEN_WIDTH, 64)];
    topbgview.backgroundColor =[[UIColor alloc] initWithRed:233/255.0 green:51/255.0 blue:42/255.0 alpha:1.0];
    [self.view addSubview:topbgview];
    UILabel *lable =[UILabel labelWithText:@"用户举报" textColor:[UIColor whiteColor] fontSize:17 inView:topbgview tapAction:nil];
    lable.textAlignment=NSTextAlignmentCenter;
    
    lable.frame=CGRectMake(100, 20, SCREEN_WIDTH-200, 44);
    
    UIButton * closebutton =[UIButton buttonWithNormalImgName:@"close" bgColor:[UIColor clearColor] inView:topbgview action:^(UIButton *btn) {
        
        [YSMediator pushToViewController:@"HYUserDetialViewController" withParams:nil animated:YES callBack:NULL];
    }];
    
    closebutton.frame = CGRectMake(SCREEN_WIDTH-60, 20, 60, 44);

    
    
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStyleGrouped inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    //    self.mTableview.rowHeight=SCREEN_WIDTH+100;
    [self.mTableview registerClass:[WDCancelCell class] forCellReuseIdentifier:WDCancelCell_ID];

    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64 + SCREEN_STATUSBAR_HEIGHT-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
    }];
    
   
    
    UIButton *logoutButton =[UIButton buttonWithTitle:@"提交" titleColor:[UIColor whiteColor] fontSize:14 bgColor:[UIColor bgff8bb1Color] inView:self.view action:^(UIButton *btn) {
        
        [WDProgressHUD showInView:nil];
        @strongify(self);
        [self uploadImageAndContent];
        
    }];
    [logoutButton.layer setMasksToBounds:YES];
    [logoutButton.layer setCornerRadius:2];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@50);
        
    }];
}

#pragma mark -- tableview delegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.reportContentList.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCancelCell *cell = [tableView dequeueReusableCellWithIdentifier:WDCancelCell_ID];
    //    if (self.mTableview.dragging == NO && self.mTableview.decelerating == NO)
    {
        cell.reportModel =[self.viewModel.reportContentList objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 230.0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelected:indexPath.row];
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel * la =[[UILabel alloc] initWithFrame:CGRectMake(15, 8, 100, 14)];
    la.text=@"选择举报原因";
    la.textAlignment=NSTextAlignmentLeft;
    la.textColor=[UIColor bgdbdbdbdColor];
    la.font =Font_PINGFANG_SC(14);
    [view addSubview:la];
    view.backgroundColor =[UIColor clearColor];
    
    return view;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    HYReportView * v =[[HYReportView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    
    if(self.editorEnabled==YES)
    {
        
        [v.imageBG.layer setBorderColor:[UIColor tc31Color].CGColor];
        v.textView.textViewEnabled=YES;
        v.block=^{
            [self showactionsheet];
        };
    }
    else
    {
        v.textView.textViewEnabled=NO;
        [v.imageBG.layer setBorderColor:[UIColor bgdbdbdbdColor].CGColor];
    }
    v.picNumber =[NSString stringWithFormat:@"%lu",(unsigned long)self.viewModel.readyUploadImageArray.count];
    self.numberView = v;
    return v;
}


-(void)setSelected:(NSInteger )index
{

    for (int i=0; i< self.viewModel.reportContentList.count; i++) {
        ((WDReportModel *) [self.viewModel.reportContentList objectAtIndex:i]).Selected=NO;
    }
    ((WDReportModel *) [self.viewModel.reportContentList objectAtIndex:index]).Selected=YES;
    self.content = ((WDReportModel *) [self.viewModel.reportContentList objectAtIndex:index]).content;
    
    if(index == self.viewModel.reportContentList.count-1)
    {
        self.editorEnabled=YES;
    }
    else
    {
        self.editorEnabled =NO;
    }
    
       [self.mTableview reloadData];
    
}


-(void)showactionsheet
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"上传展示照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:TIP_TAKEPHONE otherButtonTitles:TIP_TAKEPIC,nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    sheet.delegate = self;
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"%ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self requestPhoto];
            break;
            
        default:
            break;
    }
    
}

/***
 上传照片
 **/

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later)
    {
        id cancelBlock=^()
        {
            
        };
        id sureBlock=^()
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }
        };
        
        
        [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                                                                          @"type":@2,
                                                                                          @"rightButtonTitle":@"设置",
                                                                                          @"rightTitleColor":[UIColor tc31Color],
                                                                                          @"cancelBlock":cancelBlock,
                                                                                          @"sureBlock":sureBlock
                                                                                          } animated:YES callBack:nil];
        
        
        
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                     completionHandler:^(BOOL granted) {
                                         if (granted) {
                                             dispatch_sync(dispatch_get_main_queue( ), ^{
                                                 [self takePhoto];
                                             });
                                         }
                                     }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) {    // 已被拒绝，没有相册权限，将无法保存拍的照片
        
        id cancelBlock=^()
        {
            
        };
        id sureBlock=^()
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }
        };
        
        
        [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                                                                          @"type":@2,
                                                                                          @"rightButtonTitle":@"设置",
                                                                                          @"rightTitleColor":[UIColor tc31Color],
                                                                                          @"cancelBlock":cancelBlock,
                                                                                          @"sureBlock":sureBlock
                                                                                          } animated:YES callBack:nil];
        
    } else if ([TZImageManager authorizationStatus] == 0) {    // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
// 调用相机
- (void)pushImagePickerController {
    
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType    = sourceType;
        self.imagePicker.allowsEditing = YES;
        if (iOS8Later) {
            _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        //        self.tabBarController.tabBar.hidden = YES;
        [self.tabBarController.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
        
        //        [YSMediator presentViewController:self.imagePicker withParams:@{} animated:YES callBack:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusDenied) {
        id cancelBlock=^()
        {
            
        };
        id sureBlock=^()
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }
        };
        
        
        [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                                                                          @"type":@2,
                                                                                          @"rightButtonTitle":@"设置",
                                                                                          @"rightTitleColor":[UIColor tc31Color],
                                                                                          @"cancelBlock":cancelBlock,
                                                                                          @"sureBlock":sureBlock
                                                                                          } animated:YES callBack:nil];
        
        
        return;
    } else if (authStatus == ALAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self requestPhoto];
        }];
    } else {
        [self requestPhoto];
    }
}
- (void)requestPhoto {
    
    
    // 剩余数量
    
    if(self.viewModel.readyUploadImageArray.count>=6)
    {
    
        [WDProgressHUD showTips:@"照片已选择最大数量"];
        return;
    }
    
    
    TZImagePickerController *imagePickerVc =
    [[TZImagePickerController alloc] initWithMaxImagesCount:6-self.viewModel.readyUploadImageArray.count   columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture =NO;
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    imagePickerVc.navigationBar.barTintColor = [UIColor tc31Color];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = [[UIColor alloc] initWithRed:28/255.0 green:170/255.0 blue:9/255.0 alpha:1];
    imagePickerVc.naviTitleColor =[UIColor whiteColor];
    
    imagePickerVc.barItemTextColor =[UIColor whiteColor];
    imagePickerVc.navigationBar.translucent = NO;
    //    [imagePickerVc.navigationBar setBackgroundImage:[self barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    
    imagePickerVc.allowPickingImage         = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif           = YES;
    
    imagePickerVc.showSelectBtn      = YES;
    imagePickerVc.isStatusBarDefault = YES;
    imagePickerVc.allowCrop          =  YES;
    CGFloat imgW                     = SCREEN_WIDTH ;
    imagePickerVc.cropRect           = CGRectMake((SCREEN_WIDTH - imgW) / 2, (SCREEN_HEIGHT - imgW) / 2, imgW, imgW);
    
    
    
    @weakify(self);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self);
        [self.viewModel.readyUploadImageArray addObjectsFromArray:photos];
        [self.mTableview reloadData];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        // TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1
        // delegate:self];
        // tzImagePickerVc.sortAscendingByModificationDate = YES;
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.viewModel.readyUploadImageArray addObject:image];
         [self.mTableview reloadData];
        

    }
}
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    // 2.图片位置信息
    //    if (iOS8Later) {
    //        for (PHAsset *phAsset in assets) {
    //            NSLog(@"location:%@", phAsset.location);
    //        }
    //    }
}

- (UIImage *)barBackgroundImage {
    return [UIImage
            imageOfGradientColorWithColors:@[[UIColor colorWithHexString:@"46A2F9"], [UIColor colorWithHexString:@"60D2FA"]]
            locations:@[@0, @1.0]
            andImageSize:CGSizeMake(SCREEN_WIDTH, 64)];
}

- (UIImagePickerController *)imagePicker {
    if (_imagePicker == nil) {
        _imagePicker               = [[UIImagePickerController alloc] init];
        _imagePicker.delegate      = self;
        _imagePicker.allowsEditing = YES;
        // set appearance / 改变相册选择页的导航栏外观
        [_imagePicker.navigationBar setBackgroundImage:[self barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem   = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePicker;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)uploadImageAndContent
{
    
    
    if(self.content.length==0)
    {
        [WDProgressHUD showTips:@"请选择原因"];
        return;
    }
    

    self.memo = self.numberView.textView.contentText;
    if(self.memo.length==0)
    {
        self.memo=@"";
    }
    
    [[WDQiniuUploadHelper shareInstance] uploadImagesAndReportSignalWithImages:self.viewModel.readyUploadImageArray
                                        parms:@{@"uid":self.uid,
                                                @"content":self.content,
                                                @"memo" :self.memo,
                                                } withSuccessBlock:^(NSArray *imgURLs) {
                                                    
                                                    [WDProgressHUD hiddenHUD];
                                                    [YSMediator popToViewControllerName:@"HYUserDetialViewController" animated:YES];
                                                    
                                                } failreBlock:^(NSError *error) {
                                                    [WDProgressHUD showTips:error.localizedDescription];
                                                   [WDProgressHUD hiddenHUD];
                                                }];

}

@end
