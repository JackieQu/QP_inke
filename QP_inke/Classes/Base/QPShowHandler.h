//
//  QPShowHandler.h
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPBaseHandler.h"

@interface QPShowHandler : QPBaseHandler

/**
 获取热门直播

 @param success <#success description#>
 @param failed <#failed description#>
 */
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取附近直播

 @param success <#success description#>
 @param failed <#failed description#>
 */
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end
