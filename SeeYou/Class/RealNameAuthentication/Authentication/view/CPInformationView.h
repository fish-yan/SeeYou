//
//  CPInformationView.h
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CPInformationViewUserNameType,
    CPInformationViewIdentifyType,
} CPInformationViewType;

@interface CPInformationView : UIView
@property(nonatomic ,assign)CPInformationViewType type;
@property(nonatomic ,strong) UILabel * siginLabel;
@property(nonatomic ,strong) UITextField * contextflied;

@end
