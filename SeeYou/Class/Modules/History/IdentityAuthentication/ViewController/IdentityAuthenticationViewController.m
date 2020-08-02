//
//  IdentityAuthenticationViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IdentityAuthenticationViewController.h"

//#import "IdentityAuthenticationView.h"
#import "IndentifityAuthenDescriptionCell.h"
#import "IndentifityAuthenViewModel.h"
#import "IndentituAuthenUploadIdentifyPhotoCell.h"

#define HY_INDENTIFITYAUTHEN_ID @"IndentifityAuthenDescriptionCell"
#define HY_INDENTIFITYAUTHENUPLOAD_ID @"IndentituAuthenUploadIdentifyPhotoCell"

@interface IdentityAuthenticationViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UITableView *mTableview;
@property (nonatomic, strong) IndentifityAuthenViewModel *viewModel;
@property (nonatomic, assign) int forOrback;    // 1 来自真面照，2 背面照

@property (nonatomic, assign) NSNumber *source;    // 1来自个人中心 2，其他

@end

@implementation IdentityAuthenticationViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"used"];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpview];
    self.viewModel = [IndentifityAuthenViewModel new];
    [self.viewModel GetDataList];
    [self.viewModel loadSection];
    [self.mTableview reloadData];

    self.canBack = YES;
    self.title   = @"身份认证";
}


- (void)popBack {
    if ([self.source intValue] == 1) {
        [super popBack];
    } else {
        [[AppDelegateUIAssistant shareInstance].setLoginVCASRootVCComand execute:@"1"];
    }
}


- (void)setUpview {
    self.mTableview =
    [UITableView tableViewOfStyle:UITableViewStylePlain inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator = NO;
    self.mTableview.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor              = [UIColor clearColor];
    [self.mTableview registerClass:[IndentifityAuthenDescriptionCell class]
            forCellReuseIdentifier:HY_INDENTIFITYAUTHEN_ID];
    [self.mTableview registerClass:[IndentituAuthenUploadIdentifyPhotoCell class]
            forCellReuseIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark--TableviewDelegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.SectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:section] intValue];

    switch (index) {
        case IndentifityAuthenDescriptionType:
            return self.viewModel.listArray.count;
            break;
        case IndentifityAuthenUploadPhtotoType:
            return 1;
            break;
        default:
            break;
    }

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];

    switch (index) {
        case IndentifityAuthenDescriptionType: {
            IndentifityAuthenDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HY_INDENTIFITYAUTHEN_ID];
            [cell BindModel:[self.viewModel.listArray objectAtIndex:indexPath.row]];
            return cell;
        } break;
        case IndentifityAuthenUploadPhtotoType: {
            IndentituAuthenUploadIdentifyPhotoCell *cell =
            [tableView dequeueReusableCellWithIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID];
            cell.source = [self.source intValue];
            [cell BindViewmodel:self.viewModel.uploadViewModel];
            cell.frowardblock = ^() {
                self.forOrback = 1;
                [self showactionsheet];
            };
            cell.backwardblock = ^() {
                self.forOrback = 2;
                [self showactionsheet];
            };

            return cell;
        } break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];

    switch (index) {
        case IndentifityAuthenDescriptionType: {
            return [tableView fd_heightForCellWithIdentifier:HY_INDENTIFITYAUTHEN_ID
                                               configuration:^(IndentifityAuthenDescriptionCell *cell) {

                                                   [cell BindModel:[self.viewModel.listArray objectAtIndex:indexPath.row]];
                                               }];
        } break;
        case IndentifityAuthenUploadPhtotoType: {
            return [tableView fd_heightForCellWithIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID
                                               configuration:^(IndentituAuthenUploadIdentifyPhotoCell *cell) {

                                                   [cell BindViewmodel:self.viewModel.uploadViewModel];
                                               }];
        } break;
        default:
            break;
    }
    return 0;
}


/***
    上传照片
 **/

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        id cancelBlock = ^() {

        };
        id sureBlock = ^() {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        };


        [YSMediator presentToViewController:@"HYAlertViewController"
                                 withParams:@{
                                     @"message": @"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                     @"type": @2,
                                     @"rightButtonTitle": @"设置",
                                     @"rightTitleColor": [UIColor tc31Color],
                                     @"cancelBlock": cancelBlock,
                                     @"sureBlock": sureBlock
                                 }
                                   animated:YES
                                   callBack:nil];


    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     if (granted) {
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             [self takePhoto];
                                         });
                                     }
                                 }];
       
        // 拍照之前还需要检查相册权限
    } else if (authStatus == 2) {    // 已被拒绝，没有相册权限，将无法保存拍的照片

        id cancelBlock = ^() {

        };
        id sureBlock = ^() {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        };


        [YSMediator presentToViewController:@"HYAlertViewController"
                                 withParams:@{
                                     @"message": @"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                     @"type": @2,
                                     @"rightButtonTitle": @"设置",
                                     @"rightTitleColor": [UIColor tc31Color],
                                     @"cancelBlock": cancelBlock,
                                     @"sureBlock": sureBlock
                                 }
                                   animated:YES
                                   callBack:nil];

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
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusDenied) {
        id cancelBlock = ^() {

        };
        id sureBlock = ^() {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        };


        [YSMediator presentToViewController:@"HYAlertViewController"
                                 withParams:@{
                                     @"message": @"请在iPhone的\"设置-隐私-相机\"中允许访问相机",
                                     @"type": @2,
                                     @"rightButtonTitle": @"设置",
                                     @"rightTitleColor": [UIColor tc31Color],
                                     @"cancelBlock": cancelBlock,
                                     @"sureBlock": sureBlock
                                 }
                                   animated:YES
                                   callBack:nil];


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
    imagePickerVc.navigationBar.barTintColor = [UIColor tc31Color];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal   = [UIColor whiteColor];
    imagePickerVc.naviTitleColor             = [UIColor whiteColor];
    imagePickerVc.barItemTextColor           = [UIColor whiteColor];
    imagePickerVc.navigationBar.translucent  = NO;
    //    [imagePickerVc.navigationBar setBackgroundImage:[self barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图


    imagePickerVc.allowPickingImage         = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif           = YES;

    imagePickerVc.showSelectBtn      = NO;
    imagePickerVc.allowCrop          = YES;
    CGFloat imgW                     = SCREEN_WIDTH;
    imagePickerVc.cropRect           = CGRectMake((SCREEN_WIDTH - imgW) / 2, (SCREEN_HEIGHT - imgW) / 2, imgW, imgW);
    imagePickerVc.isStatusBarDefault = NO;

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"photo%@", photos);

        if (self.forOrback == 1) {
            self.viewModel.uploadViewModel.forwardimage = photos[0];
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photos[0])
                                                      forKey:@"forwardimage"];
        } else {
            self.viewModel.uploadViewModel.backwardimage = photos[0];
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(photos[0])
                                                      forKey:@"backwardimage"];
        }


        //上传图片
        //        [self.viewModel.uplodUserPhotoCommand execute:photos];
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
        if (self.forOrback) {
            self.viewModel.uploadViewModel.forwardimage = image;
        } else {
            self.viewModel.uploadViewModel.backwardimage = image;
        }

        //上传图片
        //        [self.viewModel.uplodUserPhotoCommand execute:@[image]];
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@", phAsset.location);
    }
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


- (void)showactionsheet {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"上传身份证照片"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"相机"
                                              otherButtonTitles:@"相册", nil];
    // actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    sheet.delegate = self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long) buttonIndex);
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


- (NSString *)saveFileInpath:(UIImage *)image andName:(NSString *)name {
    NSData *imagedata            = UIImagePNGRepresentation(image);
    NSArray *paths               = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath =
    [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imagedata]];
    [imagedata writeToFile:savedImagePath atomically:YES];
    return savedImagePath;
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
