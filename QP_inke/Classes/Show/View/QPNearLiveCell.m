//
//  QPNearLiveCell.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/14.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPNearLiveCell.h"

@interface QPNearLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation QPNearLiveCell

- (void)showAnimation {
    
    if (self.live.isShow) {
        return;
    }
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
        self.live.show = YES;
        
    }];
    
}

- (void)setLive:(QPLive *)live {
    
    _live = live;
    
    [self.headView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    self.distanceLabel.text = live.distance;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
