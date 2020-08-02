//
//  HYPersonActionView.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/29.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPersonActionView : UIView


@property (nonatomic, strong) UIButton *heartBtn;
@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UIButton *msgBtn;

+ (instancetype)viewWithHeartClickAction:(void(^)(UIButton *btn))heartAction
                         dateClickAction:(void(^)(UIButton *btn))dateAction
                      messageClickAction:(void(^)(UIButton *btn))messageAction;
@end
