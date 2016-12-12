//
//  HZTotalCell.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTotalCell.h"

@implementation HZTotalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self leftLb];
        [self rightLb];
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


- (UILabel *)leftLb {
    if (!_leftLb) {
        _leftLb = [UILabel new];
        [self.contentView addSubview:_leftLb];
        [_leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(8);
        }];
        _leftLb.font = [UIFont systemFontOfSize:14];
        _leftLb.textColor = kGrayColor;
        _leftLb.text = @"合计:¥222.0";
    }
    return _leftLb;
}

- (UILabel *)rightLb {
    if (!_rightLb) {
        _rightLb = [UILabel new];
        [self.contentView addSubview:_rightLb];
        [_rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-8);
        }];
        _rightLb.font = [UIFont systemFontOfSize:14];
        _rightLb.textColor = kGrayColor;
        _rightLb.text = @"实付:¥222.0";
    }
    return _rightLb;
}


@end
