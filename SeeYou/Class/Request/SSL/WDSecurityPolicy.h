//
//  WDSecurityPolicy.h
//  HCPatient
//
//  Created by Jam on 2016/12/27.
//  Copyright © 2016年 ZJW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WDSecurityPolicy : NSObject


+ (AFSecurityPolicy *)securityPolicy;

@end
