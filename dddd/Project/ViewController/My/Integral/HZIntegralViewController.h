//
//  HZIntegralViewController.h
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZIntegralViewModel.h"

@interface HZIntegralViewController : UIViewController
@property(nonatomic) IntegralType integralTYpe;
- (instancetype)initWithIntegralType:(IntegralType)integralType;

@end
