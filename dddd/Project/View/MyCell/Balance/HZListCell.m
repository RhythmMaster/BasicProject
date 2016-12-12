//
//  HZListCell.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZListCell.h"

@implementation HZListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self timeLb];
        [self incomeLb];
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
- (UILabel *)markLb {
    if (!_markLb) {
        _markLb = [UILabel new];
        [self.contentView addSubview:_markLb];
        [_markLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(8);
        }];
        _markLb.text = @"提现";
    }
    return _markLb;
}


- (UILabel *)incomeLb {
    if (!_incomeLb) {
        _incomeLb = [UILabel new];
        [self.contentView addSubview:_incomeLb];
        [_incomeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.markLb.mas_top);
            make.right.equalTo(-10);
            
        }];
        _incomeLb.text = @"-72.00";
    }
    return _incomeLb;
}


- (UILabel *)balanceLb {
    if (!_balanceLb) {
        _balanceLb = [UILabel new];
        [self.contentView addSubview:_balanceLb];
        [_balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(self.markLb.mas_bottom).equalTo(8);
            
        }];
        _balanceLb.textColor = kGrayColor;
        _balanceLb.font = [UIFont systemFontOfSize:12];
        _balanceLb.text = @"余额: ¥0";
    }
    return _balanceLb;
}


- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balanceLb.mas_top);
            make.right.equalTo(-10);
        }];
        _timeLb.textColor = kGrayColor;
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.text = @"2015-03-22 12:32";
    }
    return _timeLb;
}




@end
