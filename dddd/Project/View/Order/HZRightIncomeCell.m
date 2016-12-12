//
//  HZRightIncomeCell.m
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZRightIncomeCell.h"

@implementation HZRightIncomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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





- (UILabel *)incomeNumberLb {
    if (!_incomeNumberLb) {
        _incomeNumberLb = [UILabel new];
        [self.contentView addSubview:_incomeNumberLb];
        [_incomeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
        _incomeNumberLb.textColor = [UIColor orangeColor];
        _incomeNumberLb.font = [UIFont systemFontOfSize:14];
        _incomeNumberLb.text = @"¥222.0";
    }
    return _incomeNumberLb;
}


- (UILabel *)incomeLb {
    if (!_incomeLb) {
        _incomeLb = [UILabel new];
        [self.contentView addSubview:_incomeLb];
        [_incomeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(self.incomeNumberLb.mas_left).equalTo(-3);
        }];
        _incomeLb.font = [UIFont systemFontOfSize:14];
        _incomeLb.text = @"本单收入:";
        
    }
    return _incomeLb;
}

@end
