//
//  HZIsOrderCell.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIsOrderCell.h"

@implementation HZIsOrderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self incomeNumberLb];
        [self cancleBtn];
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


- (UILabel *)incomeLb {
    if (!_incomeLb) {
        _incomeLb = [UILabel new];
        [self.contentView addSubview:_incomeLb];
        [_incomeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
            
        }];
        _incomeLb.font = [UIFont systemFontOfSize:14];
        _incomeLb.text = @"本单收入: ";
        
    }
    return _incomeLb;
}


- (UILabel *)incomeNumberLb {
    if (!_incomeNumberLb) {
        _incomeNumberLb = [UILabel new];
        [self.contentView addSubview:_incomeNumberLb];
        [_incomeNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.incomeLb.mas_right).equalTo(8);
            make.centerY.equalTo(0);
        }];
        _incomeNumberLb.font = [UIFont systemFontOfSize:14];
        _incomeNumberLb.textColor = [UIColor orangeColor];
        _incomeNumberLb.text = @"¥ 328.0";
    }
    return _incomeNumberLb;
}



- (UIButton *)isServiceBtn {
    if (!_isServiceBtn) {
        _isServiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_isServiceBtn];
        [_isServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        _isServiceBtn.layer.borderColor = kRGBA(100, 143, 255, 1.0).CGColor;
        _isServiceBtn.layer.borderWidth = 1;
        [_isServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
        _isServiceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _isServiceBtn.layer.cornerRadius = 3;
        _isServiceBtn.clipsToBounds = YES;
        
        //让文字不靠边
        _isServiceBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    }
    return _isServiceBtn;
}


- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_cancleBtn];
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.isServiceBtn.mas_left).equalTo(-8);
            make.centerY.equalTo(0);
        }];
        _cancleBtn.layer.borderColor = kRGBA(88, 88, 88, 1.0).CGColor;
        _cancleBtn.layer.borderWidth = 1;
        _cancleBtn.layer.cornerRadius = 3;
        _cancleBtn.clipsToBounds = YES;
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_cancleBtn setTitleColor:kRGBA(88, 88, 88, 1.0) forState:UIControlStateNormal];
        
        _cancleBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }
    return _cancleBtn;
}
















@end
