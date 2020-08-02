//
//  HYUserBasicInfoCellModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/23.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BasicInfoCellType) {
    BasicInfoCellTypeName,
    BasicInfoCellTypeWorkPlace,
    BasicInfoCellTypeHome,
    BasicInfoCellTypeBirthday,
    BasicInfoCellTypeHeight,
    BasicInfoCellTypeEdu,
    BasicInfoCellTypeJob,
    BasicInfoCellTypeIncome,
    BasicInfoCellTypeConstellation,
    BasicInfoCellTypeMarryDate,
    BasicInfoCellTypeMarryStatus,
    BasicInfoCellTypeFriendWorkPlace,
    BasicInfoCellTypeFriendHome,
    BasicInfoCellTypeFriendAge,
    BasicInfoCellTypeFriendHeight,
    BasicInfoCellTypeFriendEdu,
    BasicInfoCellTypeFriendIncome,
};

@interface HYUserBasicInfoCellModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) BasicInfoCellType type;

+ (instancetype)modelWithType:(BasicInfoCellType)type
                         name:(NSString *)name
                         icon:(NSString *)icon
                         info:(NSString *)info;


@end
