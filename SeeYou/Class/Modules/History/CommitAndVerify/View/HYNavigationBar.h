//
//  HYNavigationBar.h
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^popBack)();
typedef void(^doNext)();

@interface HYNavigationBar : UIView

@property(nonatomic ,strong) UIButton * leftBarButton;
@property(nonatomic ,strong) UIButton * leftBarButtonm;
@property (nonatomic ,strong) UILabel * mtitleLabel;
@property(nonatomic ,strong) UIButton * rightBarButton;
@property(nonatomic,copy) popBack block;
@property(nonatomic,copy) doNext doNextblock;
@end
