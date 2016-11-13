//
//  QPLocationManager.h
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/13.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString * lat, NSString * lon);

@interface QPLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)getGps:(LocationBlock)block;

@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * lon;

@end
