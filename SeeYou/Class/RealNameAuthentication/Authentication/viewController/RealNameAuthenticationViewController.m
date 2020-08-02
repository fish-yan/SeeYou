//
//  RealNameAuthenticationViewController.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"
#import "CPInfoTitleView.h"
#import "CPInformationView.h"
#import "CPUploadView.h"
#import "HYNavigationController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <TZImagePickerController/TZImageManager.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CPAuthenticationViewModel.h"
#import "CPAuthentionExample.h"



@interface RealNameAuthenticationViewController ()<TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic ,strong) CPAuthenticationViewModel * viewModel;
@property(nonatomic ,assign) AuthentionPhotoType  type;
@property(nonatomic, strong) UIImagePickerController *imagePicker;

@property(nonatomic ,strong) UIScrollView * scroviewBgView;
@property(nonatomic ,strong) UIView * verticalContainerView;

@property(nonatomic ,strong) CPInfoTitleView * userinfoView;
@property(nonatomic ,strong) CPInformationView * usernameView;
@property(nonatomic ,strong) UIView            * lineView;
@property(nonatomic ,strong) CPInformationView * identidyNumberView;

@property(nonatomic ,strong) CPInfoTitleView * forwardtitleView;
@property(nonatomic ,strong) CPUploadView    * forwardView;

@property(nonatomic ,strong) CPInfoTitleView * backwordtitleView;
@property(nonatomic ,strong) CPUploadView    * backwordView;

@property(nonatomic ,strong) CPInfoTitleView * allwordtitleView;
@property(nonatomic ,strong) CPUploadView    * allwordView;


@property(nonatomic ,strong) UIView * buttonView;
@property(nonatomic ,strong) UIButton * commitButton;


@property(nonatomic ,assign) BOOL imageStatusComplete;
@end

@implementation RealNameAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageStatusComplete=NO;
    self.navigationItem.title=@"实名认证";
    // Do any additional setup after loading the view.
    
    [self setUpviews];
    [self subViewsLayout];
    
    self.viewModel = [CPAuthenticationViewModel new];
    
    [self bindViewModel];
    
    
    UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doaction)];
    [self.view addGestureRecognizer:ges];
    
}


- (void)doaction
{

    [self.usernameView.contextflied resignFirstResponder];
    [self.identidyNumberView.contextflied resignFirstResponder];
    
}

- (void) bindViewModel
{
    @weakify(self);
    
    [self.viewModel.doUploadForwardImageRaccomand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    [self.viewModel.doUploadBackImageRaccomand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    [self.viewModel.doUploadAllImageRaccomand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    RACSignal *signal =[self.viewModel.doUploadForwardImageRaccomand.executionSignals switchToLatest];
    RACSignal *signal1 =[self.viewModel.doUploadBackImageRaccomand.executionSignals switchToLatest];
    RACSignal *signal2 =[self.viewModel.doUploadAllImageRaccomand.executionSignals switchToLatest];
    
    RAC(self,imageStatusComplete) = [RACSignal combineLatest:@[signal,signal1,signal2] reduce:^(NSArray * forwardUrl,NSArray * backUrl,NSArray *  allUrl )
    {
        @strongify(self);
        if(forwardUrl.count >0 || backUrl.count >0 || allUrl.count>0)
        {
        
        [self.viewModel.doRaccomand execute:@"1"];
        return @YES;
        }
        
        return @NO;
    }];
    
    
    
    
    [[self.viewModel.doRaccomand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
          [YSMediator pushToViewController:@"AuthenticationIngCommitSuccessViewController" withParams:@{@"username":self.viewModel.userName,@"useridentify":self.viewModel.identifyNumber,@"type":@"1" } animated:YES callBack:nil];
        //上传成功；gotonext
    }];
    
    [self.viewModel.doRaccomand.errors subscribeNext:^(NSError * _Nullable x) {
         [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    
    
}

- (void)setUpviews
{
    self.scroviewBgView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroviewBgView setShowsVerticalScrollIndicator:NO];
    self.scroviewBgView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    self.scroviewBgView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.scroviewBgView];
    
    
    self.verticalContainerView = [UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.scroviewBgView];
    
    self.userinfoView =[CPInfoTitleView new];
    [self.verticalContainerView addSubview:self.userinfoView];
    self.userinfoView.ishideButton =YES;
    self.userinfoView.titleString=@"用户身份资料";
    
    
    self.usernameView = [CPInformationView new];
    self.usernameView.siginLabel.text=@"真实姓名";
    self.usernameView.type = CPInformationViewUserNameType;
    self.usernameView.contextflied.placeholder=@"请输入真实姓名";
    [self.verticalContainerView addSubview:self.usernameView];
    
    
    self.identidyNumberView =[CPInformationView new];
    self.identidyNumberView.siginLabel.text=@"身份证号";
    self.identidyNumberView.type = CPInformationViewIdentifyType;
    self.identidyNumberView.contextflied.placeholder=@"请输入身份证";
    [self.verticalContainerView addSubview:self.identidyNumberView];
    self.lineView = [UIView viewWithBackgroundColor:[UIColor redColor] inView:self.identidyNumberView];
    
    
    @weakify(self);
    
    
    self.forwardtitleView = [CPInfoTitleView new];
    [self.verticalContainerView addSubview:self.forwardtitleView];
    self.forwardtitleView.titleString=@"本人证件正面照片";
    self.forwardtitleView.block = ^()
    {
        @strongify(self);
        self.type = fordwardType;
        [self showExample];
    
    };

    
    self.forwardView     = [CPUploadView new];
    self.forwardView.titleString=@"请上传本人证件正面照片";
    self.forwardView.desString=@"上传身份证正面照，建议使用二代身份证";
    [self.verticalContainerView addSubview:self.forwardView];
    
    self.forwardView.block = ^(){
        @strongify(self);
        self.type = fordwardType;
        [self showPhotoAlert];
    };
    
    
    
    
    self.backwordtitleView = [CPInfoTitleView new];
    [self.verticalContainerView addSubview:self.backwordtitleView];
    self.backwordtitleView.titleString=@"本人证件反面照片";
    self.backwordtitleView.block = ^()
    {
        @strongify(self);
        self.type = backwardType;
        [self showExample];
        
    };
    
    
    self.backwordView     = [CPUploadView new];
    self.backwordView.titleString=@"请上传本人证件反面照片";
    self.backwordView.desString=@"上传身份证反面照，建议使用二代身份证";
    [self.verticalContainerView addSubview:self.backwordView];
    self.backwordView.block = ^(){
        @strongify(self);
        self.type = backwardType;
        [self showPhotoAlert];
    };
    
    
    
    
    
    self.allwordtitleView = [CPInfoTitleView new];
    [self.scroviewBgView addSubview:self.allwordtitleView];
    self.allwordtitleView.titleString=@"本人证件合照";
    self.allwordtitleView.block = ^()
    {
        @strongify(self);
        self.type = allType;
        [self showExample];
        
    };
    
    
    self.allwordView     = [CPUploadView new];
    self.allwordView.titleString=@"请上传本人与证件合照";
    self.allwordView.desString=@"照片需能看清本人和身份证上的文字和头像";
    [self.verticalContainerView addSubview:self.allwordView];
    
    self.allwordView.block = ^(){
        @strongify(self);
        self.type = allType;
        [self showPhotoAlert];
    };
    
    
    self.buttonView =[UIView viewWithBackgroundColor:[UIColor redColor] inView:self.view];
    
    self.commitButton =[UIButton buttonWithTitle:@"申请实名认证" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor redColor]  inView:self.view action:^(UIButton *btn) {
        @strongify(self);
        [self commitJust ];
    }];
    [self.commitButton.layer setMasksToBounds:YES];
    [self.commitButton.layer setCornerRadius:5];
    
}






-(void) subViewsLayout
{
    @weakify(self);
    
    [self.verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.bottom.and.right.equalTo(self.scroviewBgView).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(self.scroviewBgView);
    }];
    
    [self.userinfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.verticalContainerView.mas_top);
        make.height.equalTo(@40);
    }];
    
    [self.usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.userinfoView.mas_bottom);
        make.height.equalTo(@44);
    }];
    
    [self.identidyNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.usernameView.mas_bottom);
        make.height.equalTo(@44);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.identidyNumberView.mas_top);
        make.height.equalTo(@0.5);
    }];
    
    
    [self.forwardtitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.identidyNumberView.mas_bottom);
        make.height.equalTo(@40);
    }];

    
    [self.forwardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.forwardtitleView.mas_bottom);
        
    }];
    
    [self.backwordtitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.forwardView.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    
    [self.backwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.backwordtitleView.mas_bottom);
        
    }];
    
    [self.allwordtitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.backwordView.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    
    [self.allwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.allwordtitleView.mas_bottom);
       
        
    }];
    
    
    [self. verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.allwordView.mas_bottom).offset(125);
    }];
    
    

    
    
    [self. commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.commitButton.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


/// 修改用户头像
- (void)showPhotoAlert {
    [self.view endEditing:YES];

    NSString *string=@"";
    
    if(self.type == fordwardType)
    {
        string =@"正面照";
    }
    else if (self.type ==backwardType)
    {
        string =@"反面照";
    }
    else
    {
       string =@"合照";
    }
    
    
    
    
//    WDAlertController *alert = [WDAlertController alertControllerWithTitle:string
//                                                                   message:nil
//                                                            preferredStyle:WDAlertControllerStyleActionSheet];
//    @weakify(self);
//    [alert addAction:[WDAlertAction actionWithTitle:@"取消"
//                                              style:WDAlertActionStyleCancel
//                                            handler:^(WDAlertAction *action){
//                                                
//                                            }]];
//    [alert addAction:[WDAlertAction actionWithTitle:@"拍照"
//                                              style:WDAlertActionStyleDefault
//                                            handler:^(WDAlertAction *action) {
//                                                @strongify(self);
//                                                [self takePhoto];
//                                            }]];
//    
//    [alert addAction:[WDAlertAction actionWithTitle:@"从相册选取"
//                                              style:WDAlertActionStyleDefault
//                                            handler:^(WDAlertAction *action) {
//                                                @strongify(self);
//                                                [self pushTZImagePickerController];
//                                                
//                                            }]];
//    [self.navigationController presentViewController:alert animated:YES completion:NULL];
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限 做一个友好的提示
//        WDAlertController *alert = [WDAlertController alertControllerWithTitle:@"请在iPhone的"
//                                    "设置-隐私-相机"
//                                    "中允许访问相机"
//                                                                       message:nil
//                                                                preferredStyle:WDAlertControllerStyleAlert];
//
//        [alert addAction:[WDAlertAction actionWithTitle:@"取消"
//                                                  style:WDAlertActionStyleCancel
//                                                handler:^(WDAlertAction *action){
//
//                                                }]];
//        [alert addAction:[WDAlertAction actionWithTitle:@"设置"
//                                                  style:WDAlertActionStyleDefault
//                                                handler:^(WDAlertAction *action) {
//                                                    if ([[UIApplication sharedApplication]
//                                                         canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
//                                                        [[UIApplication sharedApplication]
//                                                         openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                                                    }
//
//                                                }]];
//        [self.navigationController presentViewController:alert animated:YES completion:NULL];
//
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        @weakify(self);
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     if (granted) {
                                         dispatch_sync(dispatch_get_main_queue( ), ^{
                                             @strongify(self);
                                             [self takePhoto];
                                         });
                                     }
                                 }];
        // 拍照之前还需要检查相册权限
    }
    else if (authStatus == 2) {    // 已被拒绝，没有相册权限，将无法保存拍的照片
//        WDAlertController *alert = [WDAlertController alertControllerWithTitle:@"请在iPhone的"
//                                    "设置-隐私-相册"
//                                    "中允许访问相册"
//                                                                       message:nil
//                                                                preferredStyle:WDAlertControllerStyleAlert];
//
//        [alert addAction:[WDAlertAction actionWithTitle:@"取消"
//                                                  style:WDAlertActionStyleCancel
//                                                handler:^(WDAlertAction *action){
//
//                                                }]];
//        [alert addAction:[WDAlertAction actionWithTitle:@"设置"
//                                                  style:WDAlertActionStyleDefault
//                                                handler:^(WDAlertAction *action) {
//
//                                                    if ([[UIApplication sharedApplication]
//                                                         canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
//                                                        [[UIApplication sharedApplication]
//                                                         openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                                                    }
//
//                                                }]];
//        [self.navigationController presentViewController:alert animated:YES completion:NULL];
        
    }
    else if (authStatus == 0) {    // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushCameraPickerController];
    }
}

/// 调用相机
- (void)pushCameraPickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType    = sourceType;
        self.imagePicker.allowsEditing = YES;
        _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
       
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusDenied) {
//        WDAlertController *alert = [WDAlertController alertControllerWithTitle:@"请在iPhone的"
//                                    "设置-隐私-相册"
//                                    "中允许访问相册"
//                                                                       message:nil
//                                                                preferredStyle:WDAlertControllerStyleAlert];
//
//        [alert addAction:[WDAlertAction actionWithTitle:@"取消"
//                                                  style:WDAlertActionStyleCancel
//                                                handler:^(WDAlertAction *action){
//
//                                                }]];
//        [alert addAction:[WDAlertAction actionWithTitle:@"设置"
//                                                  style:WDAlertActionStyleDefault
//                                                handler:^(WDAlertAction *action) {
//                                                    if ([[UIApplication sharedApplication]
//                                                         canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
//                                                        [[UIApplication sharedApplication]
//                                                         openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                                                    }
//
//                                                }]];
//        [self.navigationController presentViewController:alert animated:YES completion:NULL];
//
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
    TZImagePickerController *imagePickerVc =
    [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = NO;
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
//    [imagePickerVc.navigationBar setBackgroundImage:[ barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingImage         = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif           = YES;
    
    imagePickerVc.showSelectBtn      = NO;
    imagePickerVc.allowCrop          = YES;
    CGFloat imgW                     = SCREEN_WIDTH - 50 * 2;
    imagePickerVc.cropRect           = CGRectMake((SCREEN_WIDTH - imgW) / 2, (SCREEN_HEIGHT - imgW) / 2, imgW, imgW);
    imagePickerVc.isStatusBarDefault = NO;
    
    @weakify(self);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"photo%@", photos);
        @strongify(self);
        switch (self.type) {
            case fordwardType:
                self.forwardView.picimage = [photos objectAtIndex:0];
//                [self.viewModel.doUploadForwardImageRaccomand1 execute:photos];
                break;
            case backwardType:
                self.backwordView.picimage = [photos objectAtIndex:0];
//                [self.viewModel.doUploadBackImageRaccomand execute:photos];
                break;
            case allType:
                self.allwordView.picimage = [photos objectAtIndex:0];
//                [self.viewModel.doUploadAllImageRaccomand execute:photos];
                break;
            default:
                break;
        }
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    @weakify(self);
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
         @strongify(self);
        switch (self.type) {
            case fordwardType:
                self.forwardView.picimage = image;
//                [self.viewModel.doUploadForwardImageRaccomand1 execute:@[image]];
                break;
            case backwardType:
                self.backwordView.picimage =image;
//                [self.viewModel.doUploadBackImageRaccomand execute:@[image]];
                break;
            case allType:
                self.allwordView.picimage =image;
//                [self.viewModel.doUploadAllImageRaccomand execute:@[image]];
                break;
            default:
                break;
        }
        
//        [self.viewModel.uplodaIconCommand execute:@[image]];
    }
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@", phAsset.location);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)commitJust
{
    
    
    NSString * string =[self.usernameView.contextflied.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.usernameView.contextflied.text =string;
    
    string =[self.identidyNumberView.contextflied.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.identidyNumberView.contextflied.text =string;
    
    self.viewModel.userName = self.usernameView.contextflied.text;
    self.viewModel.identifyNumber=self.identidyNumberView.contextflied.text;
    
    
    if(self.viewModel.userName.length==0)
    {
        [WDProgressHUD showTips:@"请输入完整信息"];
        return;
    }
    if(self.viewModel.identifyNumber.length==0)
    {
        [WDProgressHUD showTips:@"请输入正确的身份证号"];
        return;
    }
    
    
    if(self.forwardView.uploadImage==nil)
    {
        [WDProgressHUD showTips:@"请上传本人证件正面照片"];
        return;
    }
    if(self.backwordView.uploadImage==nil)
    {
        [WDProgressHUD showTips:@"请上传本人证件反面照片"];
        return;
    }
    if(self.allwordView.uploadImage==nil)
    {
        [WDProgressHUD showTips:@"请上传本人与证件合照"];
        return;
    }
    
    
    
    
    [WDProgressHUD showInView:self.view];
    
    [self.viewModel.doUploadForwardImageRaccomand execute:@[self.forwardView.uploadImage]];
    [self.viewModel.doUploadBackImageRaccomand execute:@[self.backwordView.uploadImage]];
    [self.viewModel.doUploadAllImageRaccomand execute:@[self.allwordView.uploadImage]];
    
//
    
    
    
}


- (void) showExample
{
    [self.view endEditing:YES];
    CPAuthentionExample *ex =[[CPAuthentionExample alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    ex.type = self.type;
    [self.view addSubview:ex];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 懒加载
- (UIImagePickerController *)imagePicker {
    if (_imagePicker == nil) {
        _imagePicker               = [[UIImagePickerController alloc] init];
        _imagePicker.delegate      = self;
        _imagePicker.allowsEditing = YES;
        // set appearance / 改变相册选择页的导航栏外观
//        [_imagePicker.navigationBar setBackgroundImage:[WDNavigationController barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
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


@end
