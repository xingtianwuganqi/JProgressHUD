//
//  SecondViewController.m
//  JProgressHUD
//
//  Created by jingjun on 2018/1/27.
//  Copyright © 2018年 com.technology. All rights reserved.
//

#import "SecondViewController.h"
#import "JProgressHUD.h"
@interface SecondViewController ()
@property (nonatomic,strong)UIView *showView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.type isEqualToString:@"1"]){
    
        self.showView = [JProgressHUD showRemindString:@"暂无网络，请稍后重试" AtSuperView:self.view];
    }else if ([self.type isEqualToString:@"2"]){
        
        //小图片可更换
        self.showView = [JProgressHUD showKongkongViewInsuperView:self.view title:@"暂无相关订单"];
    }else{
        self.showView = [JProgressHUD showLoadingInView:self.view];
        //完成loading之后将self.showView 从页面移除
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
