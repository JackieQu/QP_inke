//
//  QPNearViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPNearViewController.h"
#import "QPShowHandler.h"
#import "QPNearLiveCell.h"

static NSString * identifier = @"QPNearLiveCell";

@interface QPNearViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray * datalist;

@end

@implementation QPNearViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datalist.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QPNearLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.datalist[indexPath.row];
    
    return cell;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];

    [self loadData];
    
}

- (void)initUI {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"QPNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
}

- (void)loadData {
    
    [QPShowHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        self.datalist = obj;
        [self.collectionView reloadData];
        
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
    
}

@end
