//
//  HZIsShowCell.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIsShowCell.h"

@implementation HZIsShowCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self titleLb];
        [self commentSwitch];
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



- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
            
        }];
        _titleLb.text = @"只显示有内容的评价";
    }
    return _titleLb;
}

- (UISwitch *)commentSwitch {
    if (!_commentSwitch) {
        _commentSwitch = [UISwitch new];
        [self.contentView addSubview:_commentSwitch];
        [_commentSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.centerY.equalTo(0);
        }];
        [_commentSwitch setOn:YES];
    }
    return _commentSwitch;
}
















@end
