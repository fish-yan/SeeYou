//
//  HYTopPayVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/21.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "IAPHelperViewModel.h"
//#import "alipayModel.h"

//typedef NS_ENUM(NSInteger, HYPopPayType) {
//    HYPopPayTypeTopDisplay,
//    HYPopPayTypeMatchMaker,
//};

@interface HYTopPayVM : IAPHelperViewModel


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger itemSelectedIdx;

- (NSArray *)updateDataArray:(NSArray *)data;


//@property (nonatomic, assign) HYPopPayType type;

//@property (nonatomic, assign) CGFloat popViewHeight;
@property (nonatomic, copy) NSString *tips;
//@property (nonatomic, strong) NSArray *listArr;
//@property (nonatomic,strong) prepayappointmentModel * extraModel;
//
//@property (nonatomic, strong) RACCommand * topDisplayRaccommand;
//@property (nonatomic, strong) RACCommand * matchMakerRaccommand;
//@property (nonatomic, strong) RACCommand * TrayHasExtraRaccommand;
@end
