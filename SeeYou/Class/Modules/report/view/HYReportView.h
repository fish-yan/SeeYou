//
//  HYReportView.h
//  youbaner
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseView.h"
#import "WDNumTextView.h"

typedef void(^clickBlock)();

@interface HYReportView : HYBaseView
@property(nonatomic,strong) UIView * imageBG;
@property(nonatomic ,strong) NSString * picNumber;
@property(nonatomic ,strong) WDNumTextView * textView;
@property(nonatomic ,copy) clickBlock block;
@end
