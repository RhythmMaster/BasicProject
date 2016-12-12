//
//  HZIndexTwoView.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIndexTwoView.h"

@implementation HZIndexTwoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bottomLb];
    }
    return self;
}


- (UILabel *)topLb {
    if (!_topLb) {
        _topLb = [UILabel new];
        [self addSubview:_topLb];
        [_topLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(5);
        }];
        _topLb.textColor = [UIColor orangeColor];
        _topLb.font = [UIFont systemFontOfSize:14];
        _topLb.text = @"¥ 222";
        
    }
    return _topLb;
}

- (UILabel *)bottomLb {
    if (!_bottomLb) {
        _bottomLb = [UILabel new];
        [self addSubview:_bottomLb];
        [_bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.topLb.mas_bottom).equalTo(2);
        }];
        _bottomLb.textColor = kGrayColor;
        _bottomLb.font = [UIFont systemFontOfSize:12];
        _bottomLb.text = @"本单收入";
    }
    return _bottomLb;
}










@end
