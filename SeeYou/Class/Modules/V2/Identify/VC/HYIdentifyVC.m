//
//  HYIdentifyVC.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/16.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYIdentifyVC.h"
#import "HYIdentifyViewModel.h"
#import "HYIdentifyInfoCell.h"
#import "HYIdentifyUploadIDImageCell.h"
#import "HYImagePickerHelper.h"


static NSString *const kInfoCellReuseID = @"kInfoCellReuseID";
static NSString *const kUploadImageCellReuseID = @"kUploadImageCellReuseID";

@interface HYIdentifyVC ()

@property (nonatomic, strong) HYIdentifyViewModel *viewModel;
@property (nonatomic, strong) HYImagePickerHelper *imgPicker;

@end

@implementation HYIdentifyVC


+ (void)load {
    [self mapName:kModuleIdentity withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Action

- (void)uploadAction {
    if (!self.viewModel.frontIdPhoto || !self.viewModel.backIdPhoto) {
        return;
    }
    NSArray *photos = @[self.viewModel.frontIdPhoto,
                        self.viewModel.backIdPhoto];
    [self.imgPicker uploadIdentifyPhoto:photos withResult:^(NSArray *imgURLs, NSError *error) {
        if (!error) {
            [WDProgressHUD showTips:@"上传成功, 请等待验证"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self popBack];
        });
    }];
}

- (void)addImageAction:(UIButton *)btn {;
    @weakify(self);
    [self.imgPicker showImagePickerInVC:self selectedHandler:^(NSArray<UIImage *> *imgs) {
        @strongify(self);
        UIImage *img = [imgs firstObject];
        if (btn.tag == 100) {
            self.viewModel.frontIdPhoto = img;
        } else if (btn.tag == 101) {
            self.viewModel.backIdPhoto = img;
        }
        [btn setBackgroundImage:img forState:UIControlStateNormal];
    }];
}

#pragma mark - Bind

- (void)bind {
}


#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"身份认证";
    self.viewModel = [HYIdentifyViewModel new];
}



#pragma mark - UITableView DataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYIdentifyCellModel *model = self.viewModel.dataArray[indexPath.row];
    HYIdentifyCellType cellType =  model.cellType;
    switch (cellType) {
        case HYIdentifyCellTypeInfo: {
            HYIdentifyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kInfoCellReuseID forIndexPath:indexPath];
            cell.cellModel = model;
            return cell;
            break;
        }
        case HYIdentifyCellTypeUpIDImage: {
            HYIdentifyUploadIDImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kUploadImageCellReuseID forIndexPath:indexPath];
            cell.cellModel = model;
            @weakify(self);
            cell.addBtnClickHandler = ^(UIButton * _Nonnull btn) {
                @strongify(self);
                [self addImageAction:btn];
            };
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    HYIdentifyCellModel *model = self.viewModel.dataArray[indexPath.row];
    HYIdentifyCellType cellType =  model.cellType;
    switch (cellType) {
        case HYIdentifyCellTypeInfo:
            [(HYIdentifyInfoCell *)cell setCellModel:model];
            break;
        case HYIdentifyCellTypeUpIDImage:
            [(HYIdentifyUploadIDImageCell *)cell setCellModel:model];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseId = nil;
    HYIdentifyCellModel *model = self.viewModel.dataArray[indexPath.row];
    HYIdentifyCellType cellType =  model.cellType;
    switch (cellType) {
        case HYIdentifyCellTypeInfo:
            reuseId = kInfoCellReuseID;
            break;
        case HYIdentifyCellTypeUpIDImage:
            reuseId = kUploadImageCellReuseID;
            break;
        default:
            break;
    }
    @weakify(self);
    return [tableView fd_heightForCellWithIdentifier:reuseId configuration:^(id cell) {
        @strongify(self);
        [self configCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - Setup Subviews

- (void)setupSubviews {
    [super setupSubviews];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HYIdentifyInfoCell class] forCellReuseIdentifier:kInfoCellReuseID];
    [self.tableView registerNib:[UINib nibWithNibName:@"HYIdentifyUploadIDImageCell" bundle:nil] forCellReuseIdentifier:kUploadImageCellReuseID];
    self.tableView.tableFooterView = [self footerView];
}

- (UIView *)footerView {
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    @weakify(self);
    UIButton *submitBtn = [UIButton buttonWithTitle:@"提交"
                                         titleColor:[UIColor whiteColor]
                                           fontSize:16
                                      normalImgName:nil
                                  normalBgImageName:@"btn_bg"
                                             inView:content
                                             action:^(UIButton *btn) {
                                                 @strongify(self);
                                                 [self uploadAction];
                                             }];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(content);
        make.top.offset(25);
        make.size.mas_equalTo(CGSizeMake(315, 45));
    }];
    return content;
}


#pragma mark - Lazy Loading

- (HYImagePickerHelper *)imgPicker {
    if (!_imgPicker) {
        _imgPicker = [HYImagePickerHelper new];
        _imgPicker.uploadType = ImageUploadTypeIdentify;
    }
    return _imgPicker;
}

@end
