//
//  HYUnreadInfoFetcher.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/13.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUnreadInfoModel : HYBaseModel

/// 消息未读数量
@property (nonatomic, assign) NSInteger msgcount;
/// 进行中的约会数量
@property (nonatomic, assign) NSInteger appointmentcount;
/// 新增通讯录数量
@property (nonatomic, assign) NSInteger addresscount;

@end


@interface HYUnreadInfoFetcher : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) RACCommand *unreadMsgCmd;

@end

NS_ASSUME_NONNULL_END
