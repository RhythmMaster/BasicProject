//
//  HZPatientDetailCell.h
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZPatientDetailCell : UITableViewCell

@property(nonatomic) UIView *topView;

@property(nonatomic) UIImageView *iconImg;

@property(nonatomic) UILabel *patientNameLb;

@property(nonatomic) UILabel *projectLb;

@property(nonatomic) UILabel *timeLb;



@property(nonatomic) UIView *centerView;

@property(nonatomic) UILabel *contactsLb;

@property(nonatomic) UILabel *addressLb;

@property(nonatomic) UILabel *orderTimeLb;

@property(nonatomic) UIButton *callBtn;



@property(nonatomic) UIView *needView;
@property(nonatomic) UILabel *needLb;
@property(nonatomic) HZCustomLabel *describeLb;
@property(nonatomic) UIButton *describeBtn;


@end
