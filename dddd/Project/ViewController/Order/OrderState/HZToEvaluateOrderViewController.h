//
//  HZToEvaluateOrderViewController.h
//  dddd
//
//  Created by tang on 16/11/28.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZOrderOperateNetManager.h"

#import "ZJD_StarEvaluateView.h"

@interface HZToEvaluateOrderViewController : UIViewController

@property(nonatomic) NSString *orderID;
- (instancetype)initWithOrderId:(NSString *)orderID;




@end
