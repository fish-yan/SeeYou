//
//  WDResponseChecking.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDResponseChecking : NSObject

/**
 *  检查response结果
 *
 *  @param  response    : 接口返回数据
 *  @return 返回NSError  : nil为访问成功，返回NSError则接口访问失败，
 */
+ (NSError *)checkResponseObject:(id)response;

/**
 *  检查Error结果
 *
 *  @param  error    : 接口返回的错误提示
 *  @return 返回NSError  : nil为访问成功，返回NSError则接口访问失败，
 */

+ (NSError *)checkResponseError:(NSError *)error;


/**
 *  检查ErrorCode
 *
 *  @param  code    : 接口访问失败所返回的NSError的code
 *  @return 返回BOOL : 如果code符合用户登录过期或者被踢，则返回YES，否则返回NO
 */
+ (BOOL)isInvalidToken: (NSError *)error;

@end
