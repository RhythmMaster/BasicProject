//
//  HZaddBtn.m
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZaddBtn.h"

@implementation HZaddBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //[self jiaLb];
        [self addLb];
    }
    return self;
}

- (UILabel *)addLb {
    if (!_addLb) {
        _addLb = [UILabel new];
        [self addSubview:_addLb];
        [_addLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            //make.bottom.equalTo(-30);
            make.top.equalTo(self.jiaLb.mas_bottom).equalTo(5);
        }];
        _addLb.textColor = kBlueColor;
        _addLb.text = @"请点击上传证书";
    }
    return _addLb;
}

- (UILabel *)jiaLb {
    if (!_jiaLb) {
        _jiaLb = [UILabel new];
        [self addSubview:_jiaLb];
        [_jiaLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(30);
            //make.bottom.equalTo(self.addLb.mas_top).equalTo(-10);
            //make.size.equalTo(CGSizeMake(60, 60));
        }];
        _jiaLb.font = [UIFont systemFontOfSize:40];
        _jiaLb.textColor = kBlueColor;
        _jiaLb.text = @"+";
    }
    return _jiaLb;
}



@end
