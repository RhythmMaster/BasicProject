//
//  HZLbAndBtnCell.m
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZLbAndBtnCell.h"

@implementation HZLbAndBtnCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self leftLb];
        [self rightBtn];
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
            make.left.equalTo(8);
            make.centerY.equalTo(0);
        }];
        _leftLb.font = [UIFont systemFontOfSize:14];
        //test
        _leftLb.text = @"褥疮护理(二度褥疮)";
    }
    return _leftLb;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        [self.contentView addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.centerY.equalTo(0);
        }];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn setTitle:@"待医护接单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kRGBA(100, 143, 255, 1.0) forState:UIControlStateNormal];
    }
    return _rightBtn;
}



@end
