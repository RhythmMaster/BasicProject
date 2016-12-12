//
//  HZOrderDetailVC.h
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZIndexOrderCell.h"
#import "HZPatientDetailCell.h"
#import "HZLbAndBtnCell.h"
#import "HZRightIncomeCell.h"
#import "HZIncomeDetailCell.h"
#import "HZTotalCell.h"
#import "HZServicesCell.h"
#import "HZCountDownCell.h"

#import "HZOrderDetailNetManager.h"
#import "HZOrderDetailViewModel.h"

@interface HZOrderDetailVC : UIViewController

@property(nonatomic) NSString *ID;
- initWithID:(NSString *)ID;

@end
