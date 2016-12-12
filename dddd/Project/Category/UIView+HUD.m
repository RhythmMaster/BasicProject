//
//  UIView+HUD.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/28.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "UIView+HUD.h"
#define kTimeOut 1.5
#define kDuration 1
@implementation UIView (HUD)
- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        [hud hideAnimated:YES afterDelay:kTimeOut];
        //[hud hide:YES afterDelay:kTimeOut];
        //[hud hideAnimated:YES afterDelay:kTimeOut];
        
    });
}

- (void)showWarning:(NSString *)warning{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = warning;
        //[hud hide:YES afterDelay:kDuration];
        [hud hideAnimated:YES afterDelay:kTimeOut];
        
    });
}

- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
@end
