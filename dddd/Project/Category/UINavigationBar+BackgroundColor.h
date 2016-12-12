//
//  UINavigationBar+BackgroundColor.h
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

- (UIView *)overlay;
- (void)setOverlay:(UIView *)overlay;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;

@end
