//
//  HYAreaDataInstance.h
//  youbaner
//
//  Created by luzhongchang on 17/8/15.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AreaDataModel : HYBaseModel
@property(nonatomic ,assign) NSNumber *iD;
@property(nonatomic ,assign) NSNumber *parent;
@property(nonatomic ,strong) NSString *name;
@property(nonatomic ,assign) NSNumber *level;

@property(nonatomic ,strong) NSString *initchar;
@property(nonatomic ,strong) NSString *pinyin;
@property(nonatomic ,assign) NSNumber *isprovince;
@property(nonatomic ,assign) NSNumber *iscity;

@property(nonatomic ,assign) NSNumber *isleaf;
@property(nonatomic ,assign) NSNumber *opstatus;


@end

@interface HYAreaDataInstance : NSObject

@property(nonatomic ,strong) NSArray *proviceArray;
/// 用户数据环境单例
+ (instancetype)shareInstance;
- (NSArray *) getDistritData:(int)parentcode;
- (NSArray *) getAreaData:(int)parentcode;

- (int) findAreaData:(NSArray *)array  key:(NSNumber *)code;

@end
