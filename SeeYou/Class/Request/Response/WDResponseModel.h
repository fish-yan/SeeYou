//
//  WDResponseModel.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDResponseModel : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;
/// 响应的数据是否需要解密
@property (nonatomic, strong) NSNumber *encode;

//只有是列表的时候才会有
@property (nonatomic ,assign) int totalpage;//总页数
@property (nonatomic ,assign) int total;//总数量

@property (nonatomic , copy) NSString *extra;

@end

