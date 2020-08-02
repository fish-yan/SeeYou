//
//  BailInstance.h
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeblcok)(NSString * status);
@interface BailInstance : NSObject
@property(nonatomic ,strong) completeblcok block;
+(BailInstance *)sharedInstance:(UIViewController*)vc  completeBlcok:(void(^)(NSString* status)) block;
-(id)initialize:(UIViewController *)vc completeBlcok:(void(^)(NSString* status)) block;
@end
