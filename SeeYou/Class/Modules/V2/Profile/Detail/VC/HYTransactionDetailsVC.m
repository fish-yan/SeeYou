//
//  HYTransactionDetailsVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYTransactionDetailsVC.h"
#import "HYTransactionDetailsContentVC.h"

@interface HYTransactionDetailsVC ()<VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) HYTransactionDetailsContentVC *incomeVC;
@property (nonatomic, strong) HYTransactionDetailsContentVC *payVC;
@end

@implementation HYTransactionDetailsVC

+ (void)load {
    [self mapName:kModuleAccountDetail withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
}

#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"明细";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [self.view setNeedsUpdateConstraints];
    [self.magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_magicController.magicView reloadData];
}


#pragma mark - VTMagicViewDataSource

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return @[@"收入", @"支出"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [menuItem setTitleColor:[UIColor colorWithHexString:@"#313131"] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    return (pageIndex == 0) ? self.incomeVC : self.payVC;
}


#pragma mark - Lazy Loading

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderStyle = VTSliderStyleBubble;
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        
        UIImage *img = [UIImage gradientImageOfSize:CGSizeMake(120, 40)];
        _magicController.magicView.sliderColor = [UIColor colorWithPatternImage:img];
        _magicController.magicView.bubbleInset = UIEdgeInsetsMake(10, 40, 10 ,40);
        _magicController.magicView.bubbleRadius = 20;
        _magicController.magicView.itemWidth = 120;
        _magicController.magicView.itemSpacing = 100;
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.navigationHeight = 70;
        //_magicController.magicView.againstStatusBar = YES;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
        _magicController.magicView.separatorColor = [UIColor colorWithHexString:@"#E7E7E7"];
    }
    return _magicController;
}

- (HYTransactionDetailsContentVC *)incomeVC {
    if (!_incomeVC) {
        _incomeVC = [HYTransactionDetailsContentVC new];
        _incomeVC.type = TransactionDetailsTypeIncome;
    }
    return _incomeVC;
}

- (HYTransactionDetailsContentVC *)payVC {
    if (!_payVC) {
        _payVC = [HYTransactionDetailsContentVC new];
        _payVC.type = TransactionDetailsTypePay;
    }
    return _payVC;
}
@end
