//
//  QPLocationManager.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/13.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface QPLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locManager;

@property (nonatomic, copy) LocationBlock block;

@end

@implementation QPLocationManager

+ (instancetype)sharedManager {
    
    static QPLocationManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[QPLocationManager alloc] init];
    });
    
    return _manager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"请开启定位服务");
        } else {
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
            
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    NSString * lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString * lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    
    [QPLocationManager sharedManager].lat = lat;
    [QPLocationManager sharedManager].lon = lon;

    self.block(lat,lon);
    
    [self.locManager stopUpdatingLocation];
    
//    NSLog(@"%@",@(coor.latitude));
//    NSLog(@"%@",@(coor.longitude));
    
}

- (void)getGps:(LocationBlock)block {
    
    self.block = block;
    [self.locManager startUpdatingLocation];
    
}

@end
