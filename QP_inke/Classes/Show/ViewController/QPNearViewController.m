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
#import "QPPlayerViewController.h"

#define kMargin 5
#define kItemWidth 100

static NSString * identifier = @"QPNearLiveCell";

@interface QPNearViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray * datalist;

@end

@implementation QPNearViewController

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QPNearLiveCell * c = (QPNearLiveCell *)cell;
    
    [c showAnimation];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = self.collectionView.width / kItemWidth;
    
    CGFloat etraWidth = (self.collectionView.width - kMargin * (count + 1)) / count;
    
    return CGSizeMake(etraWidth, etraWidth +20);
    //    CGFloat outInset = self.view.width - 2 * kMargin;
    //    NSInteger count = outInset / kItemWidth;
    //    NSInteger extraTotal = (NSInteger)(outInset - kMargin * (count - 1 ));
    //
    //    CGFloat itemWH;
    //
    //    if (extraTotal < count * kItemWidth) {
    //
    //        itemWH = extraTotal / count;
    //
    //    } else {
    //
    //        CGFloat extraWidth = extraTotal % kItemWidth;
    //        itemWH = kItemWidth + extraWidth / count;
    //    }
    //    
    //    return CGSizeMake(itemWH, itemWH + 25);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datalist.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QPNearLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.datalist[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    QPLive * live = self.datalist[indexPath.row];
    
    QPPlayerViewController * playVC = [[QPPlayerViewController alloc] init];
    playVC.live = live;
    [self.navigationController pushViewController:playVC animated:YES];
    
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
