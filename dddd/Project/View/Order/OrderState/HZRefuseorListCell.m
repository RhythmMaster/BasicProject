//
//  HZRefuseorListCell.m
//  dddd
//
//  Created by tang on 16/11/28.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZRefuseorListCell.h"

@implementation HZRefuseorListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self contentLb];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
            
        }];
        lineView.backgroundColor = kRGBA(234, 234, 234, 1.0);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)listLb {
    if (!_listLb) {
        _listLb = [UILabel new];
        [self.contentView addSubview:_listLb];
        [_listLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(16, 16));
        }];
        _listLb.layer.cornerRadius = 8;
        _listLb.clipsToBounds = YES;
        _listLb.layer.borderColor = kGrayColor.CGColor;
        _listLb.layer.borderWidth = 2;
    }
    return _listLb;
}
- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [UILabel new];
        [self.contentView addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.listLb.mas_right).equalTo(10);
            make.centerY.equalTo(0);
        }];
    }
    return _contentLb;
}

@end
