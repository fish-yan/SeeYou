//
//  HYUserInfoEditVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

typedef NS_ENUM(NSInteger, EditInfoType) {
    EditInfoTypeNickName,
    EditInfoTypeJob,
    EditInfoTypeIntro,
};


@interface HYUserInfoEditVC : HYBaseViewController

@property (nonatomic, assign) EditInfoType type;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) void(^callback)(NSString *str);
@end
