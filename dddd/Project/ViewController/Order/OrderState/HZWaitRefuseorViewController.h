//
//  HZWaitRefuseorViewController.h
//  dddd
//
//  Created by tang on 16/11/26.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZOrderOperateNetManager.h"
#import "HZRefuserListView.h"

#import "HZCustomLabel.h"
#import "HZRefuseorListCell.h"

@interface HZWaitRefuseorViewController : UIViewController

@property(nonatomic) NSString *orderID;
- (instancetype)initWithOrderId:(NSString *)orderID;

@end
