//
//  HZPageViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPageViewController.h"
#import "HZOrderViewController.h"

@interface HZPageViewController ()

@end

@implementation HZPageViewController


- (NSArray<NSString *> *)titles {
    return @[@"全部", @"进行中", @"已完成"];
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    HZOrderViewController *orderVC = [[HZOrderViewController alloc] initWithOrderType:index];
    
    return orderVC;
}

- (UIColor *)titleColorSelected {
    return kRGBA(37, 108, 255, 1.0);
}

- (UIColor *)titleColorNormal {
    return [UIColor grayColor];
}

- (WMMenuViewStyle)menuViewStyle {
    return WMMenuViewStyleLine;
}


- (UIColor *)menuBGColor {
    return [UIColor whiteColor];
}

- (CGFloat)menuHeight {
    return 35;
}

- (CGFloat)progressHeight {
    return 3;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}




@end
