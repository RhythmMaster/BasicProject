//
//  HZCertificateCell.h
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZaddBtn.h"

@interface HZCertificateCell : UITableViewCell

@property(nonatomic) UILabel *oneLb;

@property(nonatomic) UILabel *twoLb;

@property(nonatomic) HZaddBtn *addBtn;

@property(nonatomic) HZaddBtn *lastBtn;

@property(nonatomic) UIButton *deleteBtn;



@property(nonatomic) UIButton *addCertificateBtn;


@property(nonatomic) NSInteger addBtnNumber;

@property(nonatomic) NSInteger lastAddBtnNumber;


@property(nonatomic) BOOL deleteBtnState;




@property(nonatomic) NSMutableArray<UIButton *> *addBtnArr;

@property(nonatomic) NSMutableArray<UIButton *> *deleteBtnArr;




- (void)addBtnUI;


@end
