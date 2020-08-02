//
//  HYNewHomeVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYNewHomeVC.h"
#import "HYHomeContentVC.h"
#import "HYMenuModel.h"
#import "HYOneKeyGreetVC.h"
#import "HYOneKeyPopConfig.h"

#define RIGHT_ITEM_WIDHT 60.0

@interface HYNewHomeVC ()<VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) HYHomeContentVC *commendVC;
@property (nonatomic, strong) HYHomeContentVC *latestVC;
@property (nonatomic, strong) HYHomeContentVC *nearestVC;
@property (nonatomic, strong) NSArray *menuList;
@property (nonatomic, strong) UIButton *subBtn;

@property (nonatomic, strong) HYFilterRecordModel *filterInfo;

@end

@implementation HYNewHomeVC

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupSubviews];
    [self bind];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


#pragma mark - Action

- (void)go2FilterView {
    @weakify(self);
    id callBack = ^(HYFilterRecordModel *filters){
        @strongify(self);
        self.filterInfo = filters;
        HYHomeContentVC *vc = self.magicController.currentViewController;
        [vc updataWithFilterInfos:filters];
    };
    NSDictionary *params = @{
                             @"callBack": callBack,
                             @"filterInfo": self.filterInfo ?: [NSNull null]
                             };
    [YSMediator pushToViewController:kModuleFilter
                          withParams:params
                            animated:YES
                            callBack:NULL];
}


#pragma mark - Bind

- (void)bind {
}


#pragma mark - Initialize

- (void)initialize {
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [[HYOneKeyPopConfig config] configPopTime:3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HYOneKeyPopConfig config] popWithActionHandle:^(NSArray *infos){
        }];
    }); 
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [self.magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self setupRightItemButton];
    
    [_magicController.magicView reloadData];
}


#pragma mark - VTMagicViewDataSource

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (HYMenuModel *menu in self.menuList) {
        [titleList addObject:menu.title];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        menuItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.f];
        [menuItem.subviews[0] setContentMode:UIViewContentModeScaleAspectFit];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    HYMenuModel *menuInfo = self.menuList[pageIndex];
    HYHomeContentVC *vc = (HYHomeContentVC *)menuInfo.contentVC;
    vc.type = [menuInfo.menuId integerValue];
    return vc;
}


#pragma mark - Setup Subviews

- (void)doSubBtnClickAction {
    [[AppDelegateUIAssistant shareInstance].rootTabBarController setSelectedIndex:2];
}

- (void)setupSubviews {
//    _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _subBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_tab_bg"]];
//    [_subBtn setTitle:@"约会" forState:UIControlStateNormal];
//    _subBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    _subBtn.layer.cornerRadius = 44 * 0.5;
//    _subBtn.clipsToBounds = YES;
//    [[_subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self doSubBtnClickAction];
//    }];
//    [self.view addSubview:_subBtn];
//    
//    [_subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(44);
//        make.bottom.offset(-12-48 -44);
//        make.right.offset(-12);
//    }];
}


- (void)setupRightItemButton {
    UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [filterBtn setImage:[[UIImage imageNamed:@"home_fileter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
               forState:UIControlStateNormal];
    [[filterBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self go2FilterView];
    }];
    filterBtn.frame = CGRectMake(0, 0, RIGHT_ITEM_WIDHT, 20);
    [self.magicController.magicView setRightNavigatoinItem:filterBtn];
    
}

#pragma mark - Lazy Loading

- (NSArray *)menuList {
    if (!_menuList) {
        _menuList = @[
                      [HYMenuModel modelWithTitle:@"推荐" contentVC:[HYHomeContentVC new] andID:@"1"],
                      [HYMenuModel modelWithTitle:@"最新" contentVC:[HYHomeContentVC new] andID:@"2"],
                      [HYMenuModel modelWithTitle:@"附近" contentVC:[HYHomeContentVC new] andID:@"3"]
                      ];
    }
    return _menuList;
}

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0, RIGHT_ITEM_WIDHT, 0, 0);
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderStyle = VTSliderStyleBubble;

        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderHidden = NO;
        _magicController.magicView.sliderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_tab_bg"]];
        _magicController.magicView.bubbleInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _magicController.magicView.bubbleRadius = 15;
        _magicController.magicView.headerHeight = 64;
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.againstStatusBar = YES;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.separatorHidden = YES;
        _magicController.magicView.needPreloading = NO;
    }
    return _magicController;
}
@end
