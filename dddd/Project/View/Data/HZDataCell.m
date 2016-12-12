//
//  HZDataCell.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZDataCell.h"

@implementation HZDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self rightTF];
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



- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _backView;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.backView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _nameLb.text = @"姓名";
    }
    return _nameLb;
}

- (UITextField *)rightTF {
    if (!_rightTF) {
        _rightTF = [UITextField new];
        [self.backView addSubview:_rightTF];
        [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLb.mas_right).equalTo(10);
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.top.bottom.equalTo(0);
            
        }];
        _rightTF.textAlignment = NSTextAlignmentRight;
        _rightTF.placeholder = @"请输入您的姓名";
    }
    return _rightTF;
}








@end
