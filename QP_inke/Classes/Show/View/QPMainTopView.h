//
//  QPMainTopView.h
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface QPMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@property (nonatomic, copy) MainTopBlock block;

- (void)scrolling:(NSInteger)tag;

@end
