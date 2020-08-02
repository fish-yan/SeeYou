//
//  HYLocation.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCoordinate : NSObject

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@end

@interface HYLocation : NSObject

@property (nonatomic, strong) HYCoordinate *coordinate;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *citycode;
@property (nonatomic, copy) NSString *adcode;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *POIName;
@property (nonatomic, copy) NSString *AOIName;

@end
