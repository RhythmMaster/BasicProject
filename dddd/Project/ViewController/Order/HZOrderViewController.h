//
//  HZOrderViewController.h
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZOrderViewModel.h"
#import "XWLocationManager.h"
#import "HZOrderOperateNetManager.h"

@interface HZOrderViewController : UIViewController

@property(nonatomic) OrderType orderType;
- (instancetype)initWithOrderType:(OrderType)type;

@end
