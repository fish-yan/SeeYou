//
//  HYMembershipBtnView.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/19.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMembershipBtnView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle action:(void (^)(void))action;

@end
