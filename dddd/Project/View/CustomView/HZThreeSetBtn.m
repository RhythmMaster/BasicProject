//
//  HZThreeSetBtn.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZThreeSetBtn.h"

@implementation HZThreeSetBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self detailLb];
    }
    return self;
}


- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.left.equalTo(15);
            make.width.equalTo(self.mas_height).multipliedBy(0.4);
            make.height.equalTo(self.mas_height).multipliedBy(0.4);
        }];
    }
    return _iconImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.left.equalTo(self.iconImg.mas_right).equalTo(10);
            
            make.height.equalTo(self.mas_height).multipliedBy(0.3);
        }];
        _titleLb.font = [UIFont systemFontOfSize:14];
    }
    return _titleLb;
}


- (UILabel *)detailLb {
    if (!_detailLb) {
        _detailLb = [UILabel new];
        [self addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(6);
            make.left.equalTo(_titleLb.mas_left);
            make.height.equalTo(self.mas_height).multipliedBy(0.2);
            
        }];
        _detailLb.font = [UIFont systemFontOfSize:13];
        _detailLb.textColor = [UIColor grayColor];
    }
    return _detailLb;
}










@end
