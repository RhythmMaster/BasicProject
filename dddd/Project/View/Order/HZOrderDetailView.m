//
//  HZOrderDetailView.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderDetailView.h"

@implementation HZOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self totalLb];
    }
    return self;
}



- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(5);
        }];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.textColor = kGrayColor;
        _titleLb.text = @"褥疮护理";
    }
    return _titleLb;
}

- (UILabel *)unitCostLb {
    if (!_unitCostLb) {
        _unitCostLb = [UILabel new];
        [self addSubview:_unitCostLb];
        [_unitCostLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(2);
        }];
        _unitCostLb.font = [UIFont systemFontOfSize:12];
        _unitCostLb.textColor = kGrayColor;
        _unitCostLb.text = @"¥ 333.0";
    }
    return _unitCostLb;
}

- (UILabel *)numberLb {
    if (!_numberLb) {
        _numberLb = [UILabel new];
        [self addSubview:_numberLb];
        [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.unitCostLb.mas_top);
        }];
        _numberLb.textColor = kGrayColor;
        _numberLb.font = [UIFont systemFontOfSize:12];
        _numberLb.text = @"x1";
    }
    return _numberLb;
}

- (UILabel *)totalLb {
    if (!_totalLb) {
        _totalLb = [UILabel new];
        [self addSubview:_totalLb];
        [_totalLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.top.equalTo(self.numberLb.mas_top);
        }];
        _totalLb.textColor = kGrayColor;
        _totalLb.font = [UIFont systemFontOfSize:12];
        _totalLb.text = @"¥ 333.0";
    }
    return _totalLb;
}

@end
