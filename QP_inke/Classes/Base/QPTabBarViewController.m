//
//  QPTabBarViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPTabBarViewController.h"
#import "QPTabBar.h"
#import "QPBaseNavViewController.h"
#import "QPLiveViewController.h"

@interface QPTabBarViewController ()<QPTabBarDelegate>

@property (nonatomic, strong) QPTabBar * qpTabbar;

@end

@implementation QPTabBarViewController

#pragma mark - getters and setters

- (QPTabBar *)qpTabbar {
    
    if (!_qpTabbar) {
        _qpTabbar = [[QPTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _qpTabbar.delegate = self;
    }
    return _qpTabbar;
    
}

#pragma mark - QPTabBarDelegate

- (void)tabbar:(QPTabBar *)tabbar clickButton:(QPItemType)idx {
    
    if (idx != QPItemTypeLive) {
        // 当前 tabbar 索引
        self.selectedIndex = idx - QPItemTypeShow;
        return;
    }
    
    QPLiveViewController * liveVC = [[QPLiveViewController alloc] init];
    
    [self presentViewController:liveVC animated:YES  completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载控制器
    [self configViewControllers];
    
    // 加载 tabbar
    [self.tabBar addSubview:self.qpTabbar];
    
    // 删除 tabbar 阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
}

#pragma mark - private methods

- (void)configViewControllers {
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"QPMainViewController",@"QPMeViewController"]];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        
        NSString * vcName = array[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        
        QPBaseNavViewController * nav = [[QPBaseNavViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
        
    }
    
    self.viewControllers = array;
    
}

@end
