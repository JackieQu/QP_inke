//
//  QPLiveViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPLiveViewController.h"
#import "LFLivePreview.h"

@interface QPLiveViewController ()

@end

@implementation QPLiveViewController

- (IBAction)closeLive:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)startLive:(id)sender {
    
    UIView * backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    LFLivePreview * preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    [self.view addSubview:preView];
    
    // 开启直播
    [preView startLive];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
