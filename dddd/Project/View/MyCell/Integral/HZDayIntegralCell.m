//
//  HZDayIntegralCell.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZDayIntegralCell.h"

@implementation HZDayIntegralCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self timeLb];
        [self integralNumberLb];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kRGBA(234, 234, 234, 1.0);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}





#pragma mark -懒加栽
- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(10);
            
        }];
        _nameLb.font = [UIFont systemFontOfSize:16];
        _nameLb.text = @"用户每天登陆";
    }
    return _nameLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLb.mas_left);
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(5);
            
        }];
        _timeLb.textColor = kGrayColor;
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.text = @"2016-10-24 12:42";
    }
    return _timeLb;
}


- (UILabel *)integralNumberLb {
    if (!_integralNumberLb) {
        _integralNumberLb = [UILabel new];
        [self.contentView addSubview:_integralNumberLb];
        [_integralNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            
        }];
        _integralNumberLb.font = [UIFont systemFontOfSize:18];
        _integralNumberLb.textColor = kRGBA(50, 173, 143, 1.0);
        _integralNumberLb.text = @"+20";
    }
    return _integralNumberLb;
}


@end
