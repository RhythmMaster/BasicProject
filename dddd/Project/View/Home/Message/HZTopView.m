//
//  HZTopView.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTopView.h"

@implementation HZTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self nameLb];
        [self signBtn];
    }
    return self;
}

#pragma mark -懒加栽
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        _iconImg.layer.cornerRadius = 20;
        _iconImg.clipsToBounds = YES;
    }
    _iconImg.image = [UIImage imageNamed:@"minr"];
    _iconImg.backgroundColor = [UIColor redColor];
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).equalTo(8);
            make.centerY.equalTo(0);
        }];
        _nameLb.font = [UIFont systemFontOfSize:16];
    }
    return _nameLb;
}

- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_signBtn];
        [_signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
        [_signBtn setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
    }
    return _signBtn;
}

@end
