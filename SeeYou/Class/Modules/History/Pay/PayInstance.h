//
//  PayInstance.h
//  youbaner
//
//  Created by luzhongchang on 17/8/19.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import "WXApi.h"
#import "alipayModel.h"


//0 success 1 失败
typedef void(^cpmpleteblock)(int status);
@interface ALIPayViewModel : HYBaseViewModel
@property(nonatomic ,strong)RACCommand * doCommand;
@property(nonatomic ,strong) NSString * orderid;

@end

@interface PayInstance : NSObject<WXApiDelegate>
@property(nonatomic ,strong) ALIPayViewModel * viewModel;
@property(nonatomic ,copy)   cpmpleteblock  block;
+(PayInstance *)sharedInstance;
-(void)doPay:(alipayModel *)product;


-(void)doWechatPay:(id)product;
@end
