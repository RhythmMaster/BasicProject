//
//  CustomBtn.m
//  TzlBasicProject
//
//  Created by NSX443 on 16/7/27.
//  Copyright © 2016年 WangYunYun. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self nameLb];
        
    }
    return self;
}



- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.centerX.equalTo(0);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
    }
    return _img;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.img.mas_centerX);
            make.top.equalTo(self.img.mas_bottom).equalTo(5);
            
        }];
        _nameLb.textColor = [UIColor whiteColor];
        _nameLb.font = [UIFont systemFontOfSize:14];
        
    }
    return _nameLb;
}

@end
