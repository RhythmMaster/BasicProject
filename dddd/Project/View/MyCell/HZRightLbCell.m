//
//  HZRightLbCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZRightLbCell.h"

@implementation HZRightLbCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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



- (UILabel *)rightLb {
    if (!_rightLb) {
        _rightLb = [UILabel new];
        [self addSubview:_rightLb];
        [_rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
            
        }];
        _rightLb.font = [UIFont systemFontOfSize:14];
        _rightLb.textColor = [UIColor grayColor];
    }
    return _rightLb;
}

@end
