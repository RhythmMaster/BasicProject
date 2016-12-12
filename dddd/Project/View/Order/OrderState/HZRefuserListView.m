//
//  HZRefuserListView.m
//  dddd
//
//  Created by tang on 16/11/28.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZRefuserListView.h"

@implementation HZRefuserListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //[self listBtn];
        [self reasonLb];
        
        UIView *lineView = [UIView new];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
            
        }];
        lineView.backgroundColor = kGrayColor;
        
    }
    return self;
}

- (UIButton *)listBtn {
    if (!_listLb) {
        _listBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_listBtn];
        [_listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(16, 16));
        }];
        _listBtn.layer.cornerRadius = 8;
        _listBtn.clipsToBounds = YES;
        _listBtn.layer.borderWidth = 1;
        _listBtn.layer.borderColor = kGrayColor.CGColor;
        
    }
    return _listBtn;
}

- (UILabel *)listLb {
    if (!_listLb) {
        _listLb = [UILabel new];
        [self.listBtn addSubview:_listLb];
        [_listLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(2, 2));
            
        }];
        _listLb.layer.cornerRadius = 1;
        _listLb.clipsToBounds = YES;
        _listLb.backgroundColor = [UIColor blueColor];
    }
    return _listLb;
}

- (UILabel *)reasonLb {
    if (!_reasonLb) {
        _reasonLb = [UILabel new];
        [self addSubview:_reasonLb];
        [_reasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(self.listBtn.mas_right).equalTo(10);
        }];
        _reasonLb.text = @"的说法是多大个电饭锅电饭锅";
    }
    return _reasonLb;
}


@end
