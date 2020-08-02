//
//  HYLocationHelper.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYLocationHelper : NSObject

+ (instancetype)shareHelper;

@property (nonatomic, strong) HYCoordinate *coordinate;
@property (nonatomic, strong) HYLocation *location;

- (void)getLocationWithResult:(void(^)(HYLocation *location, NSError *error))rst;


@end
