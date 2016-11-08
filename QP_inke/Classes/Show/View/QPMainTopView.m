//
//  QPMainTopView.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPMainTopView.h"

@interface QPMainTopView ()

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation QPMainTopView

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
    
}

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height;
        
        for (NSInteger i = 0; i < titles.count; i ++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [self.buttons addObject:btn];
            
            NSString * btnName = titles[i];
            //设置按钮文字
            [btn setTitle:btnName forState:UIControlStateNormal];
            //设置按钮颜色
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //设置字体
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            
            btn.tag = i;
            
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            
            if (i == 1) {
                
                CGFloat h = 2;
                CGFloat y = 40;
                
                [btn.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc] init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.height  = h;
                self.lineView.width   = btn.titleLabel.width;
                self.lineView.top     = y;
                self.lineView.centerX = btn.centerX;
             
                [self addSubview:self.lineView];
            }
            
        }
        
    }
    return self;
    
}

- (void)btnClick:(UIButton *)button {
    
    self.block(button.tag);
    
    [self scrolling:button.tag];
    
}

- (void)scrolling:(NSInteger)tag {
    
    UIButton * button = self.buttons[tag];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.lineView.centerX = button.centerX;
        
    }];
    
}

@end
