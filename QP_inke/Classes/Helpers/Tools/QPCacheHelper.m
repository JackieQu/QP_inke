//
//  QPCacheHelper.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/23.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPCacheHelper.h"

#define advertiseImage @"adImage"

@implementation QPCacheHelper

+ (NSString *)getAd {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:advertiseImage];
    
}

+ (void)setAd:(NSString *)adImage {
    
    [[NSUserDefaults standardUserDefaults] setObject:adImage forKey:advertiseImage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
