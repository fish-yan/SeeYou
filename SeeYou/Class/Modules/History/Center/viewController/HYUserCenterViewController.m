//
//  HYUserCenterViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserCenterViewController.h"
#import "HYusercenterViewModel.h"
#import "HYUserHeadCell.h"
#import "HYShowPicCell.h"
#import "HYUserBaseInfoCell.h"
//#import "XLPhotoBrowser.h"
#import <TZImagePickerController/TZImageManager.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "WDQiniuUploadHelper.h"
#define HYUserHeadCell_ID @"HYUserHeadCell"
#define HYUserCenterShowPicCell_ID @"HYShowPicCell"
#define HYUserBaseInfoCell_ID @"HYUserBaseInfoCell"
#import "HYLoginViewSubViewController.h"
#import "HYUserCenterModel.h"
@interface HYUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic ,strong) UITableView * mTableview;
@property(nonatomic ,strong) HYusercenterViewModel * viewModel;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property(nonatomic ,assign) BOOL uploadAvatar;
@end

@implementation HYUserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserinfo) name:LOGOUT_UPDATE_USERINFOKEY object:nil];
    
    self.uploadAvatar =NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    [self setUpview];
    self.viewModel =[HYusercenterViewModel new];
    
    
    @weakify(self);
    if([HYUserContext shareContext].userModel.uid.length == 0)
    {
         [WDProgressHUD showInView:self.view];
    }
   
    [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
        @strongify(self);
        
        [WDProgressHUD hiddenHUD];
        [self.viewModel getinfo];
        [self.viewModel loadSection];
        [self.mTableview reloadData];
    } failureHandle:^(NSError *error) {
        [WDProgressHUD hiddenHUD];
    }];

 
    

    // Do any additional setup after loading the view.
}



-(void)refreshUserinfo
{

    @weakify(self);
    [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
        @strongify(self);
        
        [WDProgressHUD hiddenHUD];
        [self.viewModel getinfo];
        [self.viewModel loadSection];
        [self.mTableview reloadData];
    } failureHandle:^(NSError *error) {
        [WDProgressHUD hiddenHUD];
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.viewModel getinfo];
    [self.viewModel loadSection];
    [self.mTableview reloadData];
    [[HYUserContext shareContext] getuserphotomaxsize];
    
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)setUpview
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStylePlain inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    [self.mTableview registerClass:[HYUserHeadCell class] forCellReuseIdentifier:HYUserHeadCell_ID];
    [self.mTableview registerClass:[HYShowPicCell class] forCellReuseIdentifier:HYUserCenterShowPicCell_ID];
    [self.mTableview registerClass:[HYUserBaseInfoCell class] forCellReuseIdentifier:HYUserBaseInfoCell_ID];
    
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
}



#pragma mark --TableviewDelegate--
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.viewModel.SectionArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:section] intValue];
    
    switch (index) {
        case HYUserBaseInfoType:
            return 1;
            break;
        case HYUserPicType:
            return 1;
        case HyBefriendConditionType:
            return self.viewModel.UserbaseInfoArray.count;
            break;
        case HySettingType:
            return 1;
            break;
        default:
            break;
    }
    
    return  0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    
    switch (index) {
        case HYUserBaseInfoType:
        {
            HYUserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:HYUserHeadCell_ID];
            [cell  bindWithViewModel:self.viewModel.headViewModel];
            return cell;
        }
            break;
        case HYUserPicType:
        {
            @weakify(self);
            HYShowPicCell *cell = [tableView dequeueReusableCellWithIdentifier:HYUserCenterShowPicCell_ID];
            cell.isShowAdd =YES;
            [cell updateArray: self.viewModel.picShwoViewModel.picArray];
            cell.block=^(int index)
            {
                self.uploadAvatar =NO;
                @strongify(self);
                if(index ==10000)
                {
                    if(self.viewModel.picShwoViewModel.picArray.count >= [HYUserContext shareContext].maxpicture)
                    {
                        [WDProgressHUD showTips:[NSString stringWithFormat:@"最多可上传%d张照片",[HYUserContext shareContext].maxpicture]];
                        return ;
                    }
                    [self showactionsheet];
                    return ;
                }
                
             
                
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
        case HyBefriendConditionType:
        {
            HYUserBaseInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserBaseInfoCell_ID];
            [cell  bindWithViewModel:[self.viewModel.UserbaseInfoArray objectAtIndex:indexPath.row]];
            if(indexPath.row ==0)
            {
                cell.showTopLine=YES;
            }
            else
            {
                cell.showTopLine =NO;
            }
            if(indexPath.row == self.viewModel.UserbaseInfoArray.count-1)
            {
            
                cell.showShortBottonLine =NO;
                cell.showBottomLine=YES;
            }
            else
            {
                cell.showShortBottonLine =YES;
                cell.showBottomLine=NO;
            }
            
            return cell;
            
        }
        case HySettingType:
        {
            HYUserBaseInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:HYUserBaseInfoCell_ID];
            [cell  bindWithViewModel:self.viewModel.settingViewModel];
            cell.showBottomLine=YES;
            cell.showTopLine=YES;
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
    
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    switch (index) {
        case HYUserBaseInfoType:
        {
            return SCREEN_WIDTH / 375.0 * 280;
        }
            break;
        case HYUserPicType:
        {
            return  [HYShowPicCell GetHeight:self.viewModel.picShwoViewModel.picArray.count];
        }
            break;
        case HyBefriendConditionType:
        {
            return 50;
        }
            break;
        case HySettingType:
        {
            return 50;
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
    if(index ==  HySettingType)
    {
        return 0.01;
    }
    else
    {
        return  10;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    
    switch (index) {
        case HyBefriendConditionType:
        {
          
            HYUserBaseInfoViewModel * m =[self.viewModel.UserbaseInfoArray objectAtIndex:indexPath.row];
            switch (m.type) {
                case HYGotoIndenty:
                {     
                    if([[HYUserContext shareContext].userModel.identityverifystatus boolValue])
                    {
                        return;
                    }
                    [YSMediator pushToViewController:@"IdentityAuthenticationViewController" withParams:@{@"source":@1} animated:YES callBack:nil];
                }
                    
                    break;
                case HYGotoBaseInfo:
                {
                    [YSMediator pushToViewController:@"HYBaseInfoViewController" withParams:@{} animated:YES callBack:nil];
                }
                    break;
                case HYGotoBefriend:
                {
                    [YSMediator pushToViewController:@"HYBeFriendConditionViewController" withParams:@{} animated:YES callBack:nil];
                }
                    break;
                case HYgotoIntduce:
                {
                
                    [YSMediator pushToViewController:@"HYUserCenterInterduceViewController" withParams:@{} animated:YES callBack:nil];
                }
                default:
                    break;
            }
            
            
            
        }
            break;
        case HySettingType:
        {
            //去设置
            
            
            
             [YSMediator pushToViewController:@"HYSettingViewController" withParams:@{} animated:YES callBack:nil];
            
        }
            break;
        case HYUserBaseInfoType:
        {
            self.uploadAvatar =YES;
            [self showactionsheet];
        }
        default:
            break;
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
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied))
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
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     if (granted) {
                                         dispatch_sync(dispatch_get_main_queue( ), ^{
                                             [self takePhoto];
                                         });
                                     }
                                 }];

        // 拍照之前还需要检查相册权限
    } else if (authStatus == 2) {    // 已被拒绝，没有相册权限，将无法保存拍的照片
        
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
        
    } else if (authStatus == 0) {    // 未请求过相册权限
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
        _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
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
    
    
    NSInteger number=0;
    if(self.uploadAvatar==NO)
    {
        number = [HYUserContext shareContext].maxpicture - [HYUserContext shareContext].userModel.photos.count;
        if(number ==0)
        {
            [WDProgressHUD showTips:@"已经达到上传图片最大限制"];
            return;
        }
    };
    
    
    TZImagePickerController *imagePickerVc =
    [[TZImagePickerController alloc] initWithMaxImagesCount:self.uploadAvatar?1:number   columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
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
        if(self.uploadAvatar)
        {
             [self uploadAvatar:photos];
        }
        else
        {
            [self uploadShowPicture:photos];
        }
       
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
        //上传图片
        //        [self.viewModel.uplodUserPhotoCommand execute:@[image]];
        
        
        if(self.uploadAvatar ==YES)
        {
            [self uploadAvatar:@[image]];
        }
        else
        {
        
            [self uploadShowPicture:@[image]];
        }
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


- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker
{

}

-(void)uploadAvatar:(NSArray*) photos
{
    @weakify(self);
    [WDProgressHUD showInView:self.view];
    [[WDQiniuUploadHelper shareInstance] uploadImagesSignalWithImages:photos withSuccessBlock:^(NSArray *imgURLs) {
        [WDProgressHUD hiddenHUD];
        
        [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
            @strongify(self);
            [self.viewModel getinfo];
            [self.viewModel loadSection];
            [self.mTableview reloadData];
            
        } failureHandle:^(NSError *error) {
            
            
        }];
        
    } failreBlock:^(NSError *error) {
         [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:error.localizedDescription];
    }];

}

-(void) uploadShowPicture:(NSArray *)photos
{
    @weakify(self);
    [WDProgressHUD showInView:self.view];
    [[WDQiniuUploadHelper shareInstance] uploadImagesSignalWithImagesWithShowPhotos:photos withSuccessBlock:^(WDResponseModel *model) {
        
        [WDProgressHUD hiddenHUD];
        
        [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
            @strongify(self);
            [self.viewModel getinfo];
            [self.viewModel loadSection];
            [self.mTableview reloadData];
            
        } failureHandle:^(NSError *error) {
            
            
        }];
        
    } failreBlock:^(NSError *error) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:error.localizedDescription];
    }];


}


@end
