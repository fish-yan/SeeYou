//
//  AppVersionModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface AppVersionModel : HYBaseModel
@property(nonatomic ,strong)NSString * appid;
@property(nonatomic ,strong)NSString * version;
@property(nonatomic ,strong)NSString * releasenote;
@property(nonatomic ,strong)NSString * releasedate;
@property(nonatomic ,strong)NSString * updatecmd;

@property(nonatomic ,strong)NSString * newversion;
@property(nonatomic ,strong)NSString * newnote;
@property(nonatomic ,strong)NSString * newdate;
@property(nonatomic ,strong)NSString * downloadurl;
@end
