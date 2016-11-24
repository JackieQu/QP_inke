//
//  QPAdView.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/23.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPAdView.h"
#import "QPShowHandler.h"
#import "QPAd.h"
#import "QPCacheHelper.h"

static NSInteger showTime = 3;

@interface QPAdView ()

@property (weak, nonatomic) IBOutlet UIImageView *backView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation QPAdView

+ (instancetype)loadAdView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"QPAdView" owner:self options:nil] lastObject];
    
}

// 广告页初始化
- (void)awakeFromNib {
 
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    // 展示广告
    [self showAd];
    
    // 下载广告
    [self downAd];
    
    // 倒计时
    [self startTimer];
    
}

- (void)showAd {
    
    NSString * filename = [QPCacheHelper getAd];
    NSString * filePath = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,filename];
    
    UIImage * lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:filePath];
    
    if (lastCacheImage) {
        self.backView.image = lastCacheImage;
    } else {
        self.hidden = YES;
    }
    
}

- (void)downAd {
    
    // 获取最新广告数据
    [QPShowHandler executeGetAdTaskWithSuccess:^(id obj) {
        
        QPAd * ad = obj;
        
        NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,ad.image]];
        
        // SDWebImageAvoidAutoSetImage 下载完不赋值
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [QPCacheHelper setAd:ad.image];
            
            NSLog(@"广告图片下载成功");
            
        }];
        
        
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
    
}

- (void)startTimer {
    
    __block NSUInteger timeout = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    self.timer = timer;
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout <= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text = [NSString stringWithFormat:@"跳过: %zd",timeout];
            });
            
            timeout --;
            
        }
        
    });
    dispatch_resume(timer);
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

@end
