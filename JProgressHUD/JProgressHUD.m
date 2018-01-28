//
//  JProgressHUD.m
//  yiqidai
//
//  Created by TOBGO on 2017/3/28.
//  Copyright © 2017年 TOBGO. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//屏幕尺寸

#import "JProgressHUD.h"
#import "UIView+JYFrame.h"
#import "Masonry.h"
@interface JProgressHUD()
@property (nonatomic,strong)refreshBlock block;
@end
@implementation JProgressHUD

+ (void)showPopViewAtView:(UIView *)supview WithImage:(UIImage *)image WithTitle:(NSString *)title WithY:(CGFloat)y{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, supview.JY_height)];
    view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0];
    
    UIView *white = [[UIView alloc]init];
    [view addSubview:white];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGFloat length = [title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    
    CGFloat p = image.size.width/image.size.height;
    
    white.JY_size = CGSizeMake(length + 50, (length + 50)/p);
    
    white.JY_x = (ScreenW - length - 50)/2;
    NSLog(@"%f",supview.JY_height);
    white.JY_y = (supview.JY_height * y);//y点控制弹出框在父view上的y轴比例
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, white.JY_width, white.JY_height);
    [white addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = UIColorFromRGB(0xff4259);
    label.textAlignment = NSTextAlignmentCenter;
    [white addSubview:label];
    label.frame = CGRectMake(0, white.JY_height * 0.2, white.JY_width, white.JY_height * 0.8);
    
    
    
    [self animationWithView:view duration:0.5];
    
    [supview addSubview:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDefaultAnchorPointforView:view];
        [view removeFromSuperview];
        // 清空标签容器的子控件
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    });
    
}
+(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    //动画弹出的点
    [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:view];
    
    [view.layer addAnimation:animation forKey:nil];
}
+ (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}
+ (void)setDefaultAnchorPointforView:(UIView *)view
{
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:view];
}

+ (UIView *)showRemindString:(NSString *)string AtSuperView:(UIView *)superview{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, superview.JY_height)];
    view.backgroundColor = [UIColor whiteColor];
    [superview addSubview:view];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = string;
//    label.textColor = UIColorFromRGB(0x323232);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGFloat length = [string boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    label.JY_size = CGSizeMake(length + 15, 20);
    
    label.JY_x = (ScreenW - length - 15)/2;
    label.JY_y = (superview.JY_height * 0.4);
    [view addSubview:label];
    
    return view;
}


+ (UIView *)showKongkongViewInsuperView:(UIView *)view title:(NSString *)titleStr{
    
    UIView *backview = [[UIView alloc]init];
    backview.frame = CGRectMake(0, 0, view.JY_width, view.JY_height);
    backview.backgroundColor = UIColorFromRGB(0xf6f8fa);
    [view addSubview:backview];
    
    UIImage *image = [UIImage imageNamed:@"kongkong"];
    CGFloat p = image.size.width/image.size.height;
    
    UIImageView *imgview = [[UIImageView alloc]initWithImage:image];
    [backview addSubview:imgview];
    
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(50, 50/p));
        make.centerX.equalTo(view.centerX);
        make.centerY.equalTo(view.centerY).multipliedBy(0.7);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = titleStr;
    title.textColor = UIColorFromRGB(0x999999);
    title.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [backview addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(20);
        make.centerX.equalTo(view.centerX);
        make.top.equalTo(imgview.bottom).offset(10);
    }];
    
    return backview;
    
}

+ (UIView *)showLoadingInView:(UIView *)view{
    UIView *backIvew  =[[UIView alloc]init];
    backIvew.frame = view.frame;
    backIvew.backgroundColor = [UIColor whiteColor];
    [view addSubview:backIvew];
    
    UIImage *image = [UIImage imageNamed:@"新色值-loading序列_0000"];
    CGFloat p = image.size.width/image.size.height;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
        imageView.backgroundColor = [UIColor grayColor];//背景颜色
    
    NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:6];//因为这个动态图片是由6张图片组成所有把图片放到一个数组中
    for (int i=0; i<42; i++) {
        NSString *imageName = [NSString stringWithFormat:@"新色值-loading序列_000%d",i];//for循环依次把图片取出 这里我的图片名为1 － %d为i的值
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    //给imageView 制定了一组用于做动画的图片
    imageView.animationImages = images;
    
    //动画的总时长(一组动画坐下来的时间 6张图片显示一遍的总时间)
    imageView.animationDuration = 2;
    //动画进行几次结束
    [imageView startAnimating];//开始动画
    // [imageView stopAnimating];//停止动画
    [backIvew addSubview:imageView];
//    imageView.frame =CGRectMake(0, 50, ScreenW, ScreenW/p);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW, ScreenW/p));
        make.centerX.equalTo(backIvew.centerX);
        make.centerY.equalTo(backIvew.centerY).multipliedBy(0.9);
    }];

    return backIvew;
    
}


@end
