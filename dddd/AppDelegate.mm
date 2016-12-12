//
//  AppDelegate.m
//  dddd
//
//  Created by NSX443 on 16/11/6.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Custom.h"
#import "WelcomeViewController.h"
#import "HZGetCodeNM.h"
#import "LoginViewController.h"

#import "HZMyCashchangeNM.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    
    
    
    
    
    
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    //归档实现 数据持久化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //FC3BC618-C61D-48B1-9EDE-3C978F79B2A0
    
    
    
    
    
    
    
    
    
    
    
    //通过key值 判断是否是第一次使用
    if ([defaults boolForKey:@"isLogin"] != YES) {
        //第一次使用 进入引导页
        [self showWelcomeView];
    } else {
        //不是第一次使用 进入首页
        [self showHomeViewController];
    }
    [_window makeKeyAndVisible];
    [self addGlobalConfig];
    return YES;
}

//进入欢迎页
- (void)showWelcomeView {
    WelcomeViewController *welcomeVC = [WelcomeViewController new];
    _window.rootViewController = welcomeVC;
}

//进入app首页
- (void)showHomeViewController {
    
    LoginViewController *loginVC = [LoginViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navi.navigationBarHidden = YES;
    _window.rootViewController = navi;
}





@end
