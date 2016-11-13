//
//  QPTabBar.h
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QPItemType) {

    QPItemTypeLive = 10,
    QPItemTypeShow = 100,
    QPItemTypeMe,
    
};

@class QPTabBar;

typedef void(^TabBlock)(QPTabBar * tabbar, QPItemType idx);

@protocol QPTabBarDelegate <NSObject>

- (void)tabbar:(QPTabBar *)tabbar clickButton:(QPItemType) idx;

@end

@interface QPTabBar : UIView

@property (nonatomic, weak) id<QPTabBarDelegate> delegate;

@property (nonatomic, copy) TabBlock block;

@end
