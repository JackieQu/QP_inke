//
//  QPShowHandler.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPShowHandler.h"
#import "HttpTool.h"
#import "QPLive.h"
#import "QPLocationManager.h"

@implementation QPShowHandler

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    QPLocationManager * manager = [QPLocationManager sharedManager];
    
    NSDictionary * params = @{@"uid":@"969957700",
                              @"latitude":manager.lat,
                              @"longition":manager.lon
                              };
    
    [HttpTool getWithPath:API_NearLive params:params success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            NSArray * lives = [QPLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
        }

    } failure:^(NSError *error) {
                
        failed(error);

    }];
    
    
}

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_HotLive params:nil success:^(id json) {
       
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            NSArray * lives = [QPLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];

            success(lives);
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
    
}

@end
