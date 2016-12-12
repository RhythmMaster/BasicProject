//
//  HZIndexOrderCell.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIndexOrderCell.h"

@implementation HZIndexOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self rightView];
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.height.equalTo(35);
            make.width.equalTo(1);
        }];
        lineView.backgroundColor = kGrayColor;
        
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

- (HZIndexTwoView *)leftView {
    if (!_leftView) {
        _leftView = [HZIndexTwoView new];
        [self.contentView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.centerY.equalTo(0);
            make.height.equalTo(50);
            make.width.equalTo(kScreenW * 0.5);
        }];
    }
    return _leftView;
}
- (HZIndexTwoView *)rightView {
    if (!_rightView) {
        _rightView = [HZIndexTwoView new];
        [self.contentView addSubview:_rightView];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftView.mas_right).equalTo(0);
            make.centerY.equalTo(0);
            make.height.equalTo(50);
            make.width.equalTo(kScreenW * 0.5);
        }];
        //_rightView.backgroundColor = [UIColor redColor];
    }
    return _rightView;
}














@end
