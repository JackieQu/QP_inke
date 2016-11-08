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

@interface QPTabBarViewController ()<QPTabBarDelegate>

@property (nonatomic, strong) QPTabBar * qpTabbar;

@end

@implementation QPTabBarViewController

- (QPTabBar *)qpTabbar {
    
    if (!_qpTabbar) {
        _qpTabbar = [[QPTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _qpTabbar.delegate = self;
    }
    return _qpTabbar;
    
}

- (void)tabbar:(QPTabBar *)tabbar clickButton:(QPItemType)idx {
    
    self.selectedIndex = idx - QPItemTypeShow;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载控制器
    [self configViewControllers];
    
    //加载tabbar
    [self.tabBar addSubview:self.qpTabbar];
}

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
