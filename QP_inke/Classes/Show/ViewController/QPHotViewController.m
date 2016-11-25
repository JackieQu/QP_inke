//
//  QPHotViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPHotViewController.h"
#import "QPShowHandler.h"
#import "QPShowCell.h"
#import "QPPlayerViewController.h"

static NSString * identifier = @"QPShowCell";

@interface QPHotViewController ()

@property (nonatomic, strong) NSMutableArray * datalist;

@end

@implementation QPHotViewController

- (NSMutableArray *)datalist {
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QPShowCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.datalist[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QPLive * live = self.datalist[indexPath.row];
    
    QPPlayerViewController * playerVC = [[QPPlayerViewController alloc] init];
    playerVC.live = live;
    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    /*系统自带播放器无法解码直播视频格式*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.\
    
    [self initUI];
    
    [self loadData];
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QPShowCell" bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadData {
    
    [QPShowHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        
        [self.datalist addObjectsFromArray:obj];
        [self.tableView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
    }];
    
}

@end
