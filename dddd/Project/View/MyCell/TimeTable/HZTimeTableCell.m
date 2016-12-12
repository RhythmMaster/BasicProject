//
//  HZTimeTableCell.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableCell.h"

@implementation HZTimeTableCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:(CGRect)frame]) {
        [self timeLb];
    }
    return self;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _width = (kScreenW - 5*5 - 7*8 - 16) / 6;
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(_width, _width));
        }];
        _timeLb.layer.borderWidth = 0.5;
        _timeLb.layer.borderColor = kGrayColor.CGColor;
        _timeLb.layer.cornerRadius = _width * 0.5;
        _timeLb.clipsToBounds = YES;
        _timeLb.font = [UIFont systemFontOfSize:13];
        _timeLb.textAlignment = NSTextAlignmentCenter;
        _timeLb.textColor = [UIColor blackColor];
        
    }
    return _timeLb;
}

@end
