//
//  HYMoneyInfoView.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InfoViewType) {
    InfoViewTypeLeft,
    InfoViewTypeCenter,
};

@interface HYMoneyInfoView : UIView

+ (instancetype)viewWithType:(InfoViewType)type andFrame:(CGRect)frame;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) InfoViewType type;
@end
