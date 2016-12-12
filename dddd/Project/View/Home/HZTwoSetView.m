//
//  HZTwoSetView.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTwoSetView.h"

@implementation HZTwoSetView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self timesLb];
    }
    return self;
}



- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(7);
        }];
        _titleLb.font = [UIFont systemFontOfSize:10];
        _titleLb.textColor = [UIColor grayColor];
        _titleLb.text = @"服务(次)";
    }
    return _titleLb;
}


- (UILabel *)timesLb {
    if (!_timesLb) {
        _timesLb = [UILabel new];
        [self addSubview:_timesLb];
        [_timesLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(4);
            
        }];
        _timesLb.font = [UIFont systemFontOfSize:14];
        _timesLb.text = @"t189";
    }
    return _timesLb;
}


@end
