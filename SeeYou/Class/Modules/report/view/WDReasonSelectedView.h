//
//  WDReasonSelectedView.h
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "HYBaseView.h"

typedef void(^ReasonSelectedHandler)(BOOL isSelected);

@interface WDReasonSelectedView : HYBaseView

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) ReasonSelectedHandler selectedBlock;

@end
