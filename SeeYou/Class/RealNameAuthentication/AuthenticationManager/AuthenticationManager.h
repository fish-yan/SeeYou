//
//  AuthenticationManager.h
//  CPPatient
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  AuthenticationStatus: HYBaseModel

@property(nonatomic ,assign) NSNumber * status;
@property(nonatomic ,strong) NSString * name;
@property(nonatomic ,strong) NSString * cardNumber;
@property(nonatomic ,strong) NSString * reason;

@end

@interface AuthenticationManager : NSObject

+ (void)GetAuthenticationManagerStatus;

@end
