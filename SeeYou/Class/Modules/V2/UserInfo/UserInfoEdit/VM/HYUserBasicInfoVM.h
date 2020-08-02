//
//  HYUserBasicInfoVM.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

typedef NS_ENUM(NSInteger, UserInfoEditType) {
    UserInfoEditTypeBasic,
    UserInfoEditTypeFriend,
};


@interface HYUserBasicInfoVM : HYBaseViewModel

@property (nonatomic, strong) HYUserCenterModel *infoModel;
@property (nonatomic, assign) UserInfoEditType type;

@property (nonatomic, strong) NSArray *dataArray;

@end
