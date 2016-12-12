//
//  LogoView.m
//  dddd
//
//  Created by NSX443 on 16/11/7.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self LogoView];
    }
    return self;
}


/** 快护理Logo模块UI */
- (UIView *)LogoView {
    if (!_LogoView) {
        
        _LogoView = [UIView new];
        _LogoView.frame = CGRectMake(0, 0, kScreenW, kScreenH * 0.45);
        [self addSubview:_LogoView];
        
        //LogoImg
        UIImageView *LogoImg = [UIImageView new];
        LogoImg.image = [UIImage imageNamed:@"Loginlogo"];
        [_LogoView addSubview:LogoImg];
        [LogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_LogoView.mas_centerX);
            make.top.equalTo(100);
            make.width.equalTo(_LogoView.mas_width).multipliedBy(0.3);
            make.height.equalTo(_LogoView.mas_width).multipliedBy(0.3);
        }];
        
        //快护理Label
        UILabel *upTitleLb = [UILabel new];
        upTitleLb.text = @"快护理";
        upTitleLb.textColor = kRGBA(38, 107, 255, 1.0);
        upTitleLb.textAlignment = NSTextAlignmentCenter;
        upTitleLb.font = [UIFont systemFontOfSize:18];
        [_LogoView addSubview:upTitleLb];
        [upTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_LogoView.mas_centerX);
            make.top.equalTo(LogoImg.mas_bottom).equalTo(8);
            
        }];
        
        //医护端
        UILabel *downLb = [UILabel new];
        downLb.text = @"医护端";
        downLb.textColor = kRGBA(38, 107, 255, 1.0);
        downLb.textAlignment = NSTextAlignmentCenter;
        downLb.font = [UIFont systemFontOfSize:14];
        [_LogoView addSubview:downLb];
        [downLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_LogoView.mas_centerX);
            make.top.equalTo(upTitleLb.mas_bottom).equalTo(5);
        }];
    }
    return _LogoView;
}

@end
