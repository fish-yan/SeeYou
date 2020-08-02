//
//  HYUserInfoVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/15.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYUserInfoModel.h"

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeOther,
    UserTypeSelf,
};

@interface HYUserInfoVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *requestCmd;
@property (nonatomic, strong) RACCommand *updateCmd;

@property (nonatomic, assign) UserType type;

@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) id infoModel;


@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) BOOL appointmentstatus;
@property (nonatomic, assign) BOOL beckoningstatus;
@property (nonatomic, copy) NSString *dateId;
@end
