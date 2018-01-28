//
//  Tool.h
//  yiqidai
//
//  Created by TOBGO on 2017/3/30.
//  Copyright © 2017年 TOBGO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ButtonBlock) (id sender);
typedef void (^ConfirmBlock) (id sender);
typedef void (^MoveBlock) (id sender);
@interface Tool : NSObject

+ (instancetype)sharedTool;

#pragma mark - 显示带有取消确定按钮的弹窗
- (UIView *)showCancelAndConfirmBtnWithTitle:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(ConfirmBlock)block;

#pragma mark - 显示只有确定按钮的大弹窗
- (UIView *)showConfirmBtnWithNameTitle:(NSString *)nameTitle Title:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(MoveBlock)block;
#pragma mark - 只有确定按钮的弹窗小弹窗
- (UIView *)showConfirmBtnWithNameTitleMini:(NSString *)nameTitle Title:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(MoveBlock)block;
#pragma mark - 改变字体颜色
- (NSMutableAttributedString *)changeText:(NSString *)text rangeString:(NSString *)string Color:(UIColor *)color font:(CGFloat)font;

#pragma mark - 获取时间
- (NSString *)nowTimeWithForMat:(NSString *)format;

#pragma mark - 获取特定格式时间
- (NSString *)dateTimeWithForMat:(NSString *)format WithDate:(NSDate *)datel;
#pragma mark - 根据时间戳获取时间

- (NSString *)getTimeWithTimeInterval:(NSString *)time WithDateFarmat:(NSString *)format;

#pragma mark - 生成某个颜色的图片
- (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 获取当前控制器
- (UIViewController *)topViewController;
#pragma mark - 计算字体高度
- (CGFloat)heightForString:(NSString *)string WithWidth:(CGFloat)width WithtextSize:(CGFloat)size;
#pragma mark - 计算字体宽度
- (CGFloat)WidthForString:(NSString *)string WithWidth:(CGFloat)width WithtextSize:(CGFloat)size;


- (UIView *)monitoringInternet:(ButtonBlock)block;

#pragma mark - 查看是否有网络
-(BOOL) checkNetwork;

#pragma mark - 元转化为分
- (NSString *)changeFormatToFen:(NSString *)str;


@end
