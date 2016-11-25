//
//  QPShowCell.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPShowCell.h"

@interface QPShowCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;


@end

@implementation QPShowCell

- (void)setLive:(QPLive *)live {
    
    _live = live;
    
    self.nameLabel.text     = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onLineLabel.text   = [@(live.onlineUsers) stringValue];
    
    if ([live.creator.portrait isEqualToString:@"QPIcon"]) {
        
        self.headView.image = [UIImage imageNamed:@"QPIcon"];
        self.coverView.image = [UIImage imageNamed:@"QPIcon"];
        
    } else {
        
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
        [self.coverView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];

    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headView.layer.cornerRadius  = 25;
    self.headView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
