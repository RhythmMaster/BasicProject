//
//  HZTimeTableView.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableView.h"

@implementation HZTimeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self button];
    }
    return self;
}

- (HZTimeTableBtn *)button {
    if (!_button) {
        _button = [HZTimeTableBtn buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(77, 55));
        }];
    }
    return _button;
}

@end
