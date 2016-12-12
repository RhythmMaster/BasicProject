//
//  HZMainTabBarVC.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMainTabBarVC.h"
#import "HZHomeViewController.h"
#import "HZOrderViewController.h"
#import "HZMyViewController.h"
#import "HZPageViewController.h"

@interface HZMainTabBarVC ()

@end

@implementation HZMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method

- (void) initUI {
    
    HZHomeViewController *homeVC = [HZHomeViewController new];
    
    
    HZPageViewController *orderVC = [HZPageViewController new];
    
    
    HZMyViewController *myVC = [HZMyViewController new];
    
    
    
    [self initChildVC:homeVC naTitle:@"快护理" taTitle:@"首页" imageName:@"icon_m_sy_unselect"selectedImageName:@"icon_m_sy_select"];
    [self initChildVC:orderVC naTitle:@"快护理" taTitle:@"订单" imageName:@"icon_m_dd_unselect"selectedImageName:@"icon_m_dd_select"];
    [self initChildVC:myVC naTitle:@"个人中心" taTitle:@"我的" imageName:@"icon_m_my_unselect"selectedImageName:@"icon_m_my_select"];
    
}


- (void)initChildVC:(UIViewController *)childVC naTitle:(NSString *)naTitle taTitle:(NSString *)taTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:childVC];
    
    navi.navigationBar.translucent = NO;
    navi.navigationBar.barStyle = UIBarStyleBlack;
    navi.navigationBar.tintColor = [UIColor whiteColor];
    navi.navigationBar.barTintColor = kRGBA(38, 107, 255, 2.0);
    
    // 不渲染图片
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 未选中时tabBarItem上字体的颜色
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kRGBA(38, 107, 255, 1.0)} forState:UIControlStateSelected];
    // 设置标题和图片
    
    childVC.navigationItem.title = naTitle;
    
    
    childVC.tabBarItem = [childVC.tabBarItem initWithTitle:taTitle image:image selectedImage:selectedImage];
    
    [self addChildViewController:navi];
}










@end
