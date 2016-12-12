//
//  HZCountDownCell.h
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZCoutDownLb.h"

@interface HZCountDownCell : UITableViewCell

@property(nonatomic) UILabel *countDownTitleLb;

@property(nonatomic) HZCoutDownLb *countDownLb;
@property(nonatomic) UILabel *cancelReasonLb;

@property(nonatomic) UILabel *hourLb;
@property(nonatomic) UILabel *minuteLb;
@property(nonatomic) UILabel *secondLb;


@end
