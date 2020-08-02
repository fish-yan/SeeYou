//
//  WDNumTextView.h
//  CPPatient
//
//  Created by Jam on 2017/9/12.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "HYBaseView.h"

@interface WDNumTextView : UIView

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *contentText;

@property (nonatomic, assign) NSInteger limitNum;

@property (nonatomic, assign) BOOL textViewEnabled;

@end
