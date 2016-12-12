//
//  HZThreeSetView.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZThreeSetView.h"

@implementation HZThreeSetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self downLb];
    }
    return self;
}


#pragma mark -懒加栽
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.size.equalTo(CGSizeMake(21, 25));
            make.left.equalTo(15);
            
        }];
    }
    return _iconImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).equalTo(10);
            make.top.equalTo(_titleLb.mas_top);
        }];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = [UIColor grayColor];
    }
    return _titleLb;
}

- (UILabel *)downLb {
    if (!_downLb) {
        _downLb = [UILabel new];
        [self addSubview:_downLb];
        [_downLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLb.mas_left);
            make.top.equalTo(_titleLb.mas_bottom).equalTo(10);
        }];
        _downLb.font = [UIFont systemFontOfSize:12];
        _downLb.textColor = [UIColor grayColor];
    }
    return _downLb;
}















@end
