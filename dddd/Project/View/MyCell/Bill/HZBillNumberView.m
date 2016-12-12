//
//  HZBillNumberView.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZBillNumberView.h"

@implementation HZBillNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self nameLb];
    }
    return self;
}



- (UILabel *)incomeNumberLb {
    if (!_incomeNumberLb) {
        _incomeNumberLb = [UILabel new];
        [self addSubview:_incomeNumberLb];
        [_incomeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(8);
        }];
        _incomeNumberLb.font = [UIFont systemFontOfSize:24];
        _incomeNumberLb.textColor = kRGBA(253, 162, 43, 1.0);
    }
    return _incomeNumberLb;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.incomeNumberLb.mas_bottom).equalTo(4);
        }];
        _nameLb.textColor = kGrayColor;
        _nameLb.font = [UIFont systemFontOfSize:14];
    }
    return _nameLb;
}


@end
