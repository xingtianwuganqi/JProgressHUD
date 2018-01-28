//
//  JProgressHUD.h
//  yiqidai
//
//  Created by TOBGO on 2017/3/28.
//  Copyright © 2017年 TOBGO. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^refreshBlock)(id responseObject);
typedef void (^successBlock)(id responseObject);

@interface JProgressHUD : UIView


//- (void)addButtonAction:(refreshBlock)block;
#pragma mark - 自定义提示框
+ (void)showPopViewAtView:(UIView *)supview WithImage:(UIImage *)image WithTitle:(NSString *)title WithY:(CGFloat)y;
#pragma mark - 页面提示语
+ (UIView *)showRemindString:(NSString *)string AtSuperView:(UIView *)superview;

#pragma mark - 自定义loading动画
+ (UIView *)showLoadingInView:(UIView *)view;
#pragma mark - 带图片页面提示
+ (UIView *)showKongkongViewInsuperView:(UIView *)view title:(NSString *)titleStr;

#pragma mark - 弹出服务器异常图片
//+ (UIView *)showServiceAbnormalView;
//
//+ (UIView *)showNoInternetView;

+(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration;

+ (void)setDefaultAnchorPointforView:(UIView *)view;
@end
