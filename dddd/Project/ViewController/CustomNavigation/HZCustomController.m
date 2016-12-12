//
//  HZCustomController.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCustomController.h"

@interface HZCustomController ()<UINavigationControllerDelegate>


@property(nonatomic, weak) id PopDelete;

@end

@implementation HZCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PopDelete = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    [self.navigationBar lt_setBackgroundColor:[UIColor blueColor]];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelete;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    
    viewController.navigationItem.backBarButtonItem = backBarButtonItem;
    
}

- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
}

















@end
