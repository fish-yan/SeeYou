//
//  AuthenticationBridge.m
//  CPPatient
//
//  Created by luzhongchang on 2017/10/13.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "AuthenticationBridge.h"
#import "AuthenticationManager.h"

@implementation AuthenticationBridge

- (id)init
{
    self =[super init];
    if(self)
    {
        [AuthenticationManager  GetAuthenticationManagerStatus];
    }
    return self;
}
@end
