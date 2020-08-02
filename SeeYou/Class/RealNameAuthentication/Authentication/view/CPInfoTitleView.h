//
//  CPInfoTitleView.h
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^buttonBlock)();

@interface CPInfoTitleView : UIView

@property(nonatomic ,strong) NSString *titleString;
@property(nonatomic ,copy) buttonBlock  block;
@property(nonatomic ,assign) BOOL ishideButton;

@end
