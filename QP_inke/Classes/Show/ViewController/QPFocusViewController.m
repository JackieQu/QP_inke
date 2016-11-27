//
//  QPFocusViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPFocusViewController.h"
#import "QPShowCell.h"
#import "QPPlayerViewController.h"

static NSString * identifier = @"focus";

@interface QPFocusViewController ()

@property (nonatomic, strong) NSArray * datalist;

@end

@implementation QPFocusViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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
    
    self.view.backgroundColor = RGB(238, 245, 245);
    
    [self initUI];
    
    [self loadData];
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QPShowCell" bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)loadData {
    
    QPLive * live = [[QPLive alloc] init];
    live.city = @"在火星";
    live.onlineUsers = 1234;
    live.streamAddr = Live_JackieQu;
    
    QPCreator * create = [[QPCreator alloc] init];
    live.creator = create;
    
    create.nick = @"哎呀我Qu";
    create.portrait = @"QPIcon";
    
    self.datalist = @[live];
    
    [self.tableView reloadData];
    
}

@end
