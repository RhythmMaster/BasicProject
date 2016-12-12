//
//  HZCountDownCell.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCountDownCell.h"

@implementation HZCountDownCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self countDownLb];
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


- (UILabel *)countDownTitleLb {
    if (!_countDownTitleLb) {
        _countDownTitleLb = [UILabel new];
        [self.contentView addSubview:_countDownTitleLb];
        [_countDownTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
        }];
        _countDownTitleLb.font = [UIFont systemFontOfSize:14];
        _countDownTitleLb.text = @"距离订单取消倒计时:";
    }
    return _countDownTitleLb;
}

- (HZCoutDownLb *)countDownLb {
    if (!_countDownLb) {
        _countDownLb = [HZCoutDownLb new];
        [self.contentView addSubview:_countDownLb];
        [_countDownLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.countDownTitleLb.mas_right).equalTo(8);
            make.centerY.equalTo(self.countDownTitleLb.mas_centerY);
        }];
        _countDownLb.textColor = [UIColor orangeColor];
        _countDownLb.font = [UIFont systemFontOfSize:16];
    }
    return _countDownLb;
}

- (UILabel *)cancelReasonLb {
    if (!_cancelReasonLb) {
        _cancelReasonLb = [UILabel new];
        [self.contentView addSubview:_cancelReasonLb];
        [_cancelReasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.countDownTitleLb.mas_right).equalTo(8);
            make.centerY.equalTo(self.countDownTitleLb.mas_centerY);
        }];
        _cancelReasonLb.font = [UIFont systemFontOfSize:16];
    }
    return _cancelReasonLb;
}

- (UILabel *)hourLb {
    if (!_hourLb) {
        _hourLb = [UILabel new];
        [self.contentView addSubview:_hourLb];
        [_hourLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.countDownTitleLb.mas_right).equalTo(8);
            make.centerY.equalTo(self.countDownTitleLb.mas_centerY);
        }];
        _hourLb.textColor = [UIColor orangeColor];
        _hourLb.font = [UIFont systemFontOfSize:12];
        _hourLb.text = @"00:";
    }
    return _hourLb;
}

- (UILabel *)minuteLb {
    if (!_minuteLb) {
        _minuteLb = [UILabel new];
        [self.contentView addSubview:_minuteLb];
        [_minuteLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hourLb.mas_right).equalTo(5);
            make.centerY.equalTo(self.countDownTitleLb.mas_centerY);
        }];
        _minuteLb.textColor = [UIColor orangeColor];
        _minuteLb.font = [UIFont systemFontOfSize:12];
        _minuteLb.text = @"00:";
    }
    return _minuteLb;
}

- (UILabel *)secondLb {
    if (!_secondLb) {
        _secondLb = [UILabel new];
        [self.contentView addSubview:_secondLb];
        [_secondLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minuteLb.mas_right).equalTo(5);
            make.centerY.equalTo(self.countDownTitleLb.mas_centerY);
        }];
        _secondLb.textColor = [UIColor orangeColor];
        _secondLb.font = [UIFont systemFontOfSize:12];
        _secondLb.text = @"00";
    }
    return _secondLb;
}






@end
