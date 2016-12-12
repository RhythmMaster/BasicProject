//
//  HZBillQueryBtn.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZBillQueryBtn.h"

@implementation HZBillQueryBtn


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self iconImg];
    }
    return self;
}


- (UILabel *)queryLb {
    if (!_queryLb) {
        _queryLb = [UILabel new];
        [self addSubview:_queryLb];
        [_queryLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.top.equalTo(4);
            make.right.equalTo(-3);
        }];
        _queryLb.text = @"查询";
        _queryLb.textColor = [UIColor whiteColor];
    }
    return _queryLb;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(5);
            make.centerY.equalTo(0);
            
            make.size.equalTo(CGSizeMake(15, 15));
        }];
    }
    return _iconImg;
}


@end
