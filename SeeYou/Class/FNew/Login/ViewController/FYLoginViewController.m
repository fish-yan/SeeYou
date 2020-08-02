//
//  FYLoginViewController.m
//  SeeYou
//
//  Created by Yan on 2019/8/31.
//  Copyright © 2019 luzhongchang. All rights reserved.
//

#import "FYLoginViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface FYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation FYLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imgArr = @[@"bg_login_banner1", @"bg_login_banner2", @"bg_login_banner3"];
    SDCycleScrollView *sdView = [SDCycleScrollView cycleScrollViewWithFrame:self.bannerView.bounds imageNamesGroup:imgArr];
    sdView.backgroundColor = UIColor.clearColor;
    sdView.autoScrollTimeInterval = 3;
    sdView.pageControlBottomOffset = -30;
    CGFloat height = self.bannerView.bounds.size.height;
    NSArray *heiArr = @[@(87*height/400), @(154*height/400), @(113*height/400)];
    NSArray *textArr = @[@"遇见喜欢的人", @"别错过，一起吃顿饭吧", @"平台监管约会流程安全"];
    self.top.constant = [heiArr[0] floatValue];
    sdView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
        self.top.constant = [heiArr[currentIndex] floatValue];
        self.lab.text = textArr[currentIndex];
    };
    [self.bannerView addSubview:sdView];
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
