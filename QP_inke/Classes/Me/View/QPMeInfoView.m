//
//  QPMeInfoView.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/27.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPMeInfoView.h"

@implementation QPMeInfoView

+ (instancetype)loadInfoView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"QPMeInfoView" owner:self options:nil] lastObject];
    
}

@end
