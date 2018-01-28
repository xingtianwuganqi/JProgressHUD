//
//  UIView+Frame.h
//  miaoyi
//
//  Created by 陈刚 on 16/8/20.
//  Copyright © 2016年 jinyiyanglao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYFrame)
//返回view的尺寸
@property (nonatomic, assign) CGSize JY_size;
//宽度
@property (nonatomic, assign) CGFloat JY_width;
//高度
@property (nonatomic, assign) CGFloat JY_height;
//x
@property (nonatomic, assign) CGFloat JY_x;
//y
@property (nonatomic, assign) CGFloat JY_y;
//x轴中心点
@property (nonatomic, assign) CGFloat JY_centerX;
//Y轴中心点
@property (nonatomic, assign) CGFloat JY_centerY;
@end
