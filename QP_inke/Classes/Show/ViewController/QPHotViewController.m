//
//  QPHotViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPHotViewController.h"
#import "QPShowHandler.h"

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
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.\
    
    [self initUI];
    
    [self loadData];
}

- (void)initUI {
    
    
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
