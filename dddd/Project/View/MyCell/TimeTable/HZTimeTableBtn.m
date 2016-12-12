//
//  HZTimeTableBtn.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableBtn.h"

@implementation HZTimeTableBtn


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self dataLb];
    }
    return self;
}



- (UILabel *)dayLb {
    if (!_dayLb) {
        _dayLb = [UILabel new];
        [self addSubview:_dayLb];
        [_dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(7);
            
        }];
        _dayLb.font = [UIFont systemFontOfSize:16];
        _dayLb.text = @"今天";
    }
    return _dayLb;
}
- (UILabel *)dataLb {
    if (!_dataLb) {
        _dataLb = [UILabel new];
        [self addSubview:_dataLb];
        [_dataLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.dayLb.mas_bottom).equalTo(4);
        }];
        _dataLb.font = [UIFont systemFontOfSize:14];
        _dataLb.textColor = kGrayColor;
        _dataLb.text = @"09/23";
    }
    return _dataLb;
}



@end
