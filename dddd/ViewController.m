//
//  ViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/6.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    
}





- (void) initUI {
    
    UIImageView *backView = [UIImageView new];
    backView.userInteractionEnabled = YES;//打开背景图片交互性
    backView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    backView.image = [UIImage imageNamed:@"icon_welcome"];
    [self.view addSubview:backView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(backView.mas_bottom).equalTo(-120);
        make.left.equalTo(60);
        make.height.equalTo(backView.mas_height).multipliedBy(0.1);
    }];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_welcome_bt"] forState:UIControlStateNormal];
    [backBtn bk_addEventHandler:^(id sender) {
        LoginViewController *loginVC = [LoginViewController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
