//
//  HYLocationHelper.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYLocationHelper.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface HYLocationHelper()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) void(^callBack)(HYLocation *location, NSError *error);

@end

@implementation HYLocationHelper

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    static HYLocationHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [HYLocationHelper new];
        [instance initAmap];
    });
    return instance;
}

- (void)initAmap {
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
}
- (void)getLocationWithResult:(void(^)(HYLocation *location, NSError *error))rst {
    self.callBack = rst;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
 
            if (error.code == AMapLocationErrorLocateFailed) {
                if (self.callBack) {
                    self.callBack(nil, error);
                }
                
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode) {
            NSLog(@"reGeocode:%@", regeocode);
            HYLocation *loc = [HYLocation new];
            loc.country = regeocode.country;
            loc.city = regeocode.city;
            loc.district = regeocode.district;
            loc.citycode = regeocode.citycode;
            loc.adcode = regeocode.adcode;
            loc.street = regeocode.street;
            loc.number = regeocode.number;
            loc.POIName = regeocode.POIName;
            loc.AOIName = regeocode.AOIName;
            
            HYCoordinate *coordinate = [HYCoordinate new];
            coordinate.latitude = location.coordinate.latitude;
            coordinate.longitude = location.coordinate.longitude;
            
            loc.coordinate = coordinate;
            self.coordinate = coordinate;
            self.location = loc;
            
            if (self.callBack) {
                self.callBack(loc, nil);
            }
        }
    }];
}
//
//
////开始定位
//- (void)startSerialLocation {
//    NSLog(@"============> 开始定位 <============");
//    [self.locationManager startUpdatingLocation];
//}
//
/////停止定位
//- (void)stopSerialLocation {
//    NSLog(@"============> 停止定位 <============");
//    [self.locationManager stopUpdatingLocation];
//}
//
///// 定位错误
//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"============> 定位失败 <============");
//    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
//    if (self.callBack) {
//        self.callBack(nil, error);
//    }
//    [self stopSerialLocation];
//}
//
/////定位结果
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
//    NSLog(@"============> 定位成功 <============");
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//    
//    HYCoordinate *coordinate = [HYCoordinate new];
//    coordinate.latitude = location.coordinate.latitude;
//    coordinate.longitude = location.coordinate.longitude;
//    
//    self.coordinate = coordinate;
//    
//    if (self.callBack) {
//        self.callBack(coordinate, nil);
//    }
//    [self stopSerialLocation];
//}
@end
