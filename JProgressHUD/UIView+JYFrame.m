//
//  UIView+Frame.m
//  miaoyi
//
//  Created by 陈刚 on 16/8/20.
//  Copyright © 2016年 jinyiyanglao. All rights reserved.
//

#import "UIView+JYFrame.h"

@implementation UIView (Frame)

- (void)setJY_size:(CGSize)JY_size
{
    CGRect frame = self.frame;
    frame.size = JY_size;
    self.frame = frame;
}
-(void)setJY_width:(CGFloat)JY_width
{
    CGRect frame = self.frame;
    frame.size.width = JY_width;
    self.frame =frame;
}
- (void)setJY_height:(CGFloat)JY_height
{
    CGRect frame = self.frame;
    frame.size.height = JY_height;
    self.frame = frame;
}
-(void)setJY_x:(CGFloat)JY_x
{
    CGRect frame = self.frame;
    frame.origin.x = JY_x;
    self.frame = frame;
    
}
- (void)setJY_y:(CGFloat)JY_y
{
    CGRect frame = self.frame;
    frame.origin.y = JY_y;
    self.frame = frame;
}
- (void)setJY_centerX:(CGFloat)JY_centerX
{
    CGPoint center = self.center;
    center.x = JY_centerX;
    self.center = center;
}
- (void)setJY_centerY:(CGFloat)JY_centerY
{

    CGPoint center = self.center;
    center.y = JY_centerY;
    self.center = center;
}
- (CGFloat)JY_x
{
    return self.frame.origin.x;
}
- (CGFloat)JY_y
{
  return self.frame.origin.y;
}
- (CGFloat)JY_centerX
{
    return self.center.x;
}
- (CGFloat)JY_centerY
{
    return self.center.y;
}
- (CGFloat)JY_height
{
    return self.frame.size.height;
}
- (CGFloat)JY_width
{
    return self.frame.size.width;
}
- (CGSize)JY_size
{
    return self.frame.size;
}
@end
