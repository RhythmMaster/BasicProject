//
//  HZIsShowView.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIsShowView.h"

@implementation HZIsShowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self titleLb];
        [self commentSwitch];
    }
    return self;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
            
        }];
        _titleLb.text = @"只显示有内容的评价";
    }
    return _titleLb;
}

- (UISwitch *)commentSwitch {
    if (!_commentSwitch) {
        _commentSwitch = [UISwitch new];
        [self addSubview:_commentSwitch];
        [_commentSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.centerY.equalTo(0);
        }];
        [_commentSwitch setOn:YES];
    }
    return _commentSwitch;
}

@end
