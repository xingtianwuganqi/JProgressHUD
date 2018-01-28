//
//  ViewController.m
//  JProgressHUD
//
//  Created by jingjun on 2018/1/26.
//  Copyright © 2018年 com.technology. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "JProgressHUD.h"
#import "SecondViewController.h"
#import "Tool.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UIView *monitoring;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0){
        return 4;
    }else{
        return 4;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            cell.textLabel.text = @"带取消确定按钮的弹窗";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"只带取消按钮的大弹窗";
            
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"只带取消按钮的小弹窗";
            
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"无网络时的提醒";
            
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"简短提醒弹窗";
            
        }else{
            cell.textLabel.text = @"简短提醒弹窗";
            
        }
    }else{
        if (indexPath.row == 0){
            cell.textLabel.text = @"简短提醒弹窗";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"无图片页面提醒";
            
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"带图片页面提醒";
            
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"自定义loading动画";
            
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"简短提醒弹窗";
            
        }else{
            cell.textLabel.text = @"简短提醒弹窗";
            
        }
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            [[UIApplication sharedApplication].keyWindow addSubview:[[Tool sharedTool]showCancelAndConfirmBtnWithTitle:@"确定进行该操作吗？" ButtonTitle:@"确定" black:^(id sender) {
                //点击按钮后执行的代码
                
            }]];
        }else if (indexPath.row == 1){
            //之前项目需要有一个大弹窗一个小弹窗，可根据需求更改
            ;
            NSString *time = [NSString stringWithFormat:@"现在时刻：%@\n\n您有下列任务：\n\n1.XXXX\n\n2.XXXXX",[[Tool sharedTool]nowTimeWithForMat:@"YYYY年MM月dd日"]];
            
            [[UIApplication sharedApplication].keyWindow addSubview:[[Tool sharedTool]showConfirmBtnWithNameTitle:@"提示" Title:time ButtonTitle:@"确定" black:^(id sender) {
                //点击按钮后执行的代码
                
            }]];
        }else if (indexPath.row == 2){
            
            //之前项目需要有一个大弹窗一个小弹窗，可根据需求更改
            
            [[UIApplication sharedApplication].keyWindow addSubview:[[Tool sharedTool]showConfirmBtnWithNameTitleMini:@"提示" Title:@"确定前往appstore?" ButtonTitle:@"立即前往" black:^(id sender) {
                //点击按钮后执行的代码
                
            }]];
        }else if (indexPath.row == 3){
            if (![[Tool sharedTool] checkNetwork]){
                self.monitoring = [[Tool sharedTool]monitoringInternet:^(id sender) {
                    //点下刷新按钮请求网络，请求道数据后将self.monitoring 从父view上移除
                    [self.monitoring removeFromSuperview];
                    
                }];
                [self.view addSubview:self.monitoring];
            }
        }else if (indexPath.row == 4){
            
        }else{
            
        }
    }else{
    
    
        if (indexPath.row == 0){
            //比较适合简短的提示，字符太长的话，为了不影响背景图片弹出来会比较难看
            [JProgressHUD showPopViewAtView:self.view WithImage:[UIImage imageNamed:@"bj"] WithTitle:@"客服已离开" WithY:0.4];
        }else if (indexPath.row == 1){
            SecondViewController *second = [[SecondViewController alloc]init];
            second.type = @"1";
            [self.navigationController pushViewController:second animated:YES];
        }else if (indexPath.row == 2){
            SecondViewController *second = [[SecondViewController alloc]init];
            second.type = @"2";
            [self.navigationController pushViewController:second animated:YES];
        }else if (indexPath.row == 3){
            SecondViewController *second = [[SecondViewController alloc]init];
            second.type = @"3";
            [self.navigationController pushViewController:second animated:YES];
        }else if (indexPath.row == 4){
            
        }else{
            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
