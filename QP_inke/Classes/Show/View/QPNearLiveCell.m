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
