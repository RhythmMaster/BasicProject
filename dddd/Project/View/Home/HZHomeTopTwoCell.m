//
//  HZHomeTopTwoCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZHomeTopTwoCell.h"



@implementation HZHomeTopTwoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self rightView];
        
        UIView *lineView1 = [UIView new];
        [self.contentView addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.bottom.equalTo(-5);
            make.width.equalTo(1);
            make.left.equalTo(_leftView.mas_right);
        }];
        lineView1.backgroundColor = kRGBA(220, 220, 220, 1.0);
        
        UIView *lineView2 = [UIView new];
        [self.contentView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.bottom.equalTo(-5);
            make.width.equalTo(1);
            make.left.equalTo(_centerView.mas_right);
        }];
        lineView2.backgroundColor = kRGBA(220, 220, 220, 1.0);
        
        
        
        
        
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

- (HZTwoSetView *)leftView {
    if (!_leftView) {
        _leftView = [HZTwoSetView new];
        [self.contentView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(self.mas_width).multipliedBy(0.33);
        }];
    }
    
    return _leftView;
}

- (HZTwoSetView *)centerView {
    if (!_centerView) {
        _centerView = [HZTwoSetView new];
        [self.contentView addSubview:_centerView];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftView.mas_right);
            make.top.bottom.equalTo(0);
            make.width.equalTo(self.mas_width).multipliedBy(0.33);
        }];
        _centerView.titleLb.text = @"接单(件)";
        
    }
    return _centerView;
}

- (HZTwoSetView *)rightView {
    if (!_rightView) {
        _rightView = [HZTwoSetView new];
        [self.contentView addSubview:_rightView];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView.mas_right);
            make.top.bottom.equalTo(0);
            make.right.equalTo(0);
        }];
        _rightView.titleLb.text = @"收入(元)";
    }
    return _rightView;
}































@end
