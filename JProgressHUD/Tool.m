//
//  Tool.m
//  yiqidai
//
//  Created by TOBGO on 2017/3/30.
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

#import "Tool.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@interface Tool ()

@property (nonatomic, strong, nullable) ButtonBlock block;
@property (nonatomic,strong,nullable)ConfirmBlock conBlock;
@property (nonatomic,strong,nullable)MoveBlock moveBlock;
@end

@implementation Tool
+ (instancetype)sharedTool{
    static Tool *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[Tool alloc]init];
    });
    return _manager;
}

#pragma mark - 显示取消确定按钮的背景
- (UIView *)showCancelAndConfirmBtnWithTitle:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(ConfirmBlock)block{
    
    self.conBlock = block;
    UIView *whiteBack = [[UIView alloc]init];
    whiteBack.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    whiteBack.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    whiteBack.userInteractionEnabled = YES;
    //        tap.delegate = self;
    //        self.zfBackView.tag = 2000;
    //        [self.zfBackView addGestureRecognizer:tap];
    
    UIImage *whiteImage = [UIImage imageNamed:@"bj_bssb"];
    CGFloat P = whiteImage.size.width/whiteImage.size.height;
    
    UIImageView *whiteImg = [[UIImageView alloc]init];
    whiteImg.image = whiteImage;
    whiteImg.userInteractionEnabled = YES;
    [whiteBack addSubview:whiteImg];
    [whiteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW * 0.7, ScreenW * 0.7/P));
        make.centerY.equalTo(whiteBack.centerY).multipliedBy(0.9);
        make.centerX.equalTo(whiteBack.centerX);
    }];
    
    UIView *lineview = [[UIView alloc]init];
    lineview.backgroundColor = UIColorFromRGB(0xdddddd);
    [whiteImg addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.bottom.equalTo(whiteImg.bottom).offset(-50);
        make.left.equalTo(whiteImg.left).offset(2);
        make.right.equalTo(whiteImg.right).offset(-2);
    }];
    
    UIView *twoline = [[UIView alloc]init];
    twoline.backgroundColor = UIColorFromRGB(0xdddddd);
    [whiteImg addSubview:twoline];
    [twoline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(1);
        make.centerX.equalTo(whiteImg.centerX);
        make.top.equalTo(lineview.bottom).offset(1);
        make.bottom.equalTo(whiteImg.bottom).offset(-2);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:btnTitle forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn setTitleColor:UIColorFromRGB(0xff386b) forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteImg addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview.bottom);
        make.left.equalTo(twoline.left);
        make.right.equalTo(whiteImg.right);
        make.bottom.equalTo(whiteImg.bottom).offset(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:UIColorFromRGB(0x7b7b7b) forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(cancelRenewal:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteImg addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview.bottom);
        make.left.equalTo(whiteImg.left);
        make.right.equalTo(twoline.left);
        make.bottom.equalTo(whiteImg.bottom).offset(0);
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    
    detailLab.textColor = UIColorFromRGB(0x333333);
    detailLab.font = [UIFont systemFontOfSize:15];
    detailLab.numberOfLines = 0;
    detailLab.text = title;
    detailLab.textAlignment = NSTextAlignmentCenter;
    [whiteImg addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteImg.left).offset(20);
        make.right.equalTo(whiteImg.right).offset(-20);
        make.bottom.equalTo(lineview.top);
        make.top.equalTo(whiteImg.centerY).multipliedBy(0.9);
    }];
    return whiteBack;
}
- (void)confirmClick:(UIButton *)button{
    UIView *view = (UIView *)button.superview.superview;
    [view removeFromSuperview];
    
    if (self.conBlock){
        self.conBlock(self.conBlock);
    }
}
- (void)cancelRenewal:(UIButton *)button{
    UIView *view = (UIView *)button.superview.superview;
    [view removeFromSuperview];
}

#pragma mark - 显示只有确定按钮的弹窗
- (UIView *)showConfirmBtnWithNameTitle:(NSString *)nameTitle Title:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(MoveBlock)block{
    self.moveBlock = block;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    backView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    UIImage *whiteImage = [UIImage imageNamed:@"白底"];
    CGFloat P = whiteImage.size.width/whiteImage.size.height;
    
    UIImageView *whiteImg = [[UIImageView alloc]init];
    whiteImg.image = whiteImage;
    whiteImg.userInteractionEnabled = YES;
    [backView addSubview:whiteImg];
    [whiteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW * 0.75, ScreenW * 0.75/P));
        make.centerY.equalTo(backView.centerY).multipliedBy(0.9);
        make.centerX.equalTo(backView.centerX);
    }];
    
    
    UILabel *name = [[UILabel alloc]init];
    name.text = nameTitle;
    name.textColor = UIColorFromRGB(0xffffff);
    name.font = [UIFont systemFontOfSize:17];
    [whiteImg addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(20);
        make.centerX.equalTo(whiteImg.centerX);
        make.centerY.equalTo(whiteImg.top).offset(20);
    }];
    
    
    UIImage *btnImg = [UIImage imageNamed:@"bind_btn"];
    CGFloat btnP = btnImg.size.width/btnImg.size.height;
    UIButton *butotn = [UIButton buttonWithType:UIButtonTypeCustom];
    [butotn setTitle:btnTitle forState:UIControlStateNormal];
    butotn.titleLabel.font = [UIFont systemFontOfSize:20];
    [butotn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [butotn setBackgroundImage:btnImg forState:UIControlStateHighlighted];
    [butotn addTarget:self action:@selector(MoveClick:) forControlEvents:UIControlEventTouchUpInside];
    butotn.layer.cornerRadius = 7;
    butotn.layer.masksToBounds = YES;
    [whiteImg addSubview:butotn];
    [butotn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW * 0.6, ScreenW * 0.6/btnP));
        make.bottom.equalTo(whiteImg.bottom).offset(-30);
        make.centerX.equalTo(whiteImg.centerX);
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    
    detailLab.textColor = UIColorFromRGB(0x323232);
    detailLab.font = [UIFont systemFontOfSize:17];
    detailLab.numberOfLines = 0;
    detailLab.text = title;
    detailLab.textAlignment = NSTextAlignmentLeft;
    [whiteImg addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteImg.left).offset(20);
        make.right.equalTo(whiteImg.right).offset(-20);
        make.bottom.equalTo(whiteImg.centerY).multipliedBy(1.4);
        make.top.equalTo(whiteImg.centerY).multipliedBy(0.4);
    }];
    return backView;
}

- (void)MoveClick:(UIButton *)btn{
    
    UIView *view = (UIView *)btn.superview.superview;
    [view removeFromSuperview];
    
    if (self.moveBlock){
        self.moveBlock(self.moveBlock);
    }
}
- (UIView *)showConfirmBtnWithNameTitleMini:(NSString *)nameTitle Title:(NSString *)title ButtonTitle:(NSString *)btnTitle black:(MoveBlock)block{
    self.moveBlock = block;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    backView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    UIImage *whiteImage = [UIImage imageNamed:@"圆角矩形1拷贝"];
    CGFloat P = whiteImage.size.width/whiteImage.size.height;
    
    UIImageView *whiteImg = [[UIImageView alloc]init];
    whiteImg.image = whiteImage;
    whiteImg.userInteractionEnabled = YES;
    [backView addSubview:whiteImg];
    [whiteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW * 0.66, ScreenW * 0.66/P));
        make.centerY.equalTo(backView.centerY).multipliedBy(0.9);
        make.centerX.equalTo(backView.centerX);
    }];
    
    
    UILabel *name = [[UILabel alloc]init];
    name.text = nameTitle;
    name.textColor = UIColorFromRGB(0xffffff);
    name.font = [UIFont systemFontOfSize:17];
    [whiteImg addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(20);
        make.centerX.equalTo(whiteImg.centerX);
        make.centerY.equalTo(whiteImg.top).offset(20);
    }];
    
    
    UIImage *btnImg = [UIImage imageNamed:@"bind_btn"];
    CGFloat btnP = btnImg.size.width/btnImg.size.height;
    UIButton *butotn = [UIButton buttonWithType:UIButtonTypeCustom];
    [butotn setTitle:btnTitle forState:UIControlStateNormal];
    butotn.titleLabel.font = [UIFont systemFontOfSize:16];
    [butotn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [butotn setBackgroundImage:btnImg forState:UIControlStateHighlighted];
    [butotn addTarget:self action:@selector(MoveClick:) forControlEvents:UIControlEventTouchUpInside];
    butotn.layer.cornerRadius = 7;
    butotn.layer.masksToBounds = YES;
    [whiteImg addSubview:butotn];
    [butotn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW * 0.5, ScreenW * 0.5/btnP));
        make.bottom.equalTo(whiteImg.bottom).offset(-30);
        make.centerX.equalTo(whiteImg.centerX);
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    
    detailLab.textColor = UIColorFromRGB(0x323232);
    detailLab.font = [UIFont systemFontOfSize:15];
    detailLab.numberOfLines = 0;
    detailLab.text = title;
    [UILabel changeLineSpaceForLabel:detailLab WithSpace:16.0];
    detailLab.textAlignment = NSTextAlignmentCenter;
    [whiteImg addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteImg.left).offset(20);
        make.right.equalTo(whiteImg.right).offset(-20);
        make.bottom.equalTo(whiteImg.centerY).multipliedBy(1.4);
        make.top.equalTo(whiteImg.centerY).multipliedBy(0.4);
    }];
    return backView;
}
#pragma mark - 改变字体颜色
- (NSMutableAttributedString *)changeText:(NSString *)text rangeString:(NSString *)string Color:(UIColor *)color font:(CGFloat)font{
    //获取需要改变的字符串在完整字符串的范围
    NSRange rang = [text rangeOfString:string];
    
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc]initWithString:text];
    //设置文字颜色
    [attributStr addAttribute:NSForegroundColorAttributeName value:color range:rang];
    [attributStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium"size:font] range:rang];
    return attributStr;
}

#pragma mark -- 获取时间
- (NSString *)nowTimeWithForMat:(NSString *)format

{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //YYYY/MM/dd
    [formatter setDateFormat:format];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}
#pragma mark -- 获取某个格式的时间
- (NSString *)dateTimeWithForMat:(NSString *)format WithDate:(NSDate *)date

{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //YYYY/MM/dd
    [formatter setDateFormat:format];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}
#pragma mark -- 根据时间戳获取时间

- (NSString *)getTimeWithTimeInterval:(NSString *)time WithDateFarmat:(NSString *)format{
    NSInteger timeInterger = [time integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterger];
    NSString *timeStr = [NSString stringWithFormat:@"%@",[self dateTimeWithForMat:format WithDate:confromTimesp]];
    return timeStr;
}

#pragma mark - 生成某个颜色的图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
#pragma mark - 获取当前控制器
- (UIViewController *)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
        
    }else if (rootViewController.presentedViewController){
        
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    }else{
        return  rootViewController;
    }
}
#pragma mark - 计算字体高度
- (CGFloat)heightForString:(NSString *)string WithWidth:(CGFloat)width WithtextSize:(CGFloat)size{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGFloat textH = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]} context:nil].size.height;
    return textH + 5;
}
#pragma mark - 计算字体宽度
- (CGFloat)WidthForString:(NSString *)string WithWidth:(CGFloat)width WithtextSize:(CGFloat)size{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    CGFloat textW = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]} context:nil].size.width;
    return textW + 5;
}
#pragma mark - 没网刷新界面
- (UIView *)monitoringInternet:(ButtonBlock)block{
    
    self.block = block;
    
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    backView.backgroundColor = [UIColor whiteColor];
    
    
    UIImage *image = [UIImage imageNamed:@"meiwang"];
    CGFloat H = (image.size.height / image.size.width) * ScreenW;
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:image];
    [backView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(ScreenW, H));
        make.centerX.equalTo(backView.centerX);
        make.centerY.equalTo(backView.centerY).multipliedBy(0.6);
    }];
    UIImage *ima = [UIImage imageNamed:@"sx"];
    CGFloat p = ima.size.width/ima.size.height;
    
    UIButton *button = [[UIButton alloc]init];
    [button setImage:ima forState:UIControlStateNormal];
    [backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(70, 70/p));
        make.top.equalTo(imageview.bottom).equalTo(10);
        make.centerX.equalTo(backView.centerX);
    }];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    return backView;

}
- (void)buttonAction {
    if (self.block) {
        self.block(self);
    }
}
-(BOOL) checkNetwork
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            return NO;
            break;
        case ReachableViaWWAN:
            return YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
        default:
            return NO;
    }
    
}




#pragma mark - 将元转换为分
- (NSString *)changeFormatToFen:(NSString *)str{
    
    NSString *fenStr = [NSString stringWithFormat:@"%.2f",[str floatValue] * 100];
    NSArray *arr = [fenStr componentsSeparatedByString:@"."];
    NSString *fen =[NSString stringWithFormat:@"%@",[arr firstObject]];
    return fen;
}


@end
