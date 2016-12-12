//
//  HZStatusCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZStatusCell.h"

@implementation HZStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self diseaseLb];
        [self statusLb];
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









- (UIImageView *)blueLineImg {
    if (!_blueLineImg) {
        _blueLineImg = [UIImageView new];
        [self.contentView addSubview:_blueLineImg];
        [_blueLineImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.centerY.equalTo(0);
            make.width.equalTo(3);
            make.height.equalTo(self.mas_height).multipliedBy(0.4);
        }];
        _blueLineImg.image = [UIImage imageNamed:@"icon_l_sg"];
    }
    return _blueLineImg;
}




- (UILabel *)diseaseLb {
    if (!_diseaseLb) {
        _diseaseLb = [UILabel new];
        [self.contentView addSubview:_diseaseLb];
        [_diseaseLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.blueLineImg.mas_right).equalTo(8);
            make.centerY.equalTo(0);
        }];
        _diseaseLb.font = [UIFont systemFontOfSize:14];
        //test
        _diseaseLb.text = @"褥疮护理(二度褥疮)";
    }
    return _diseaseLb;
}


- (UILabel *)statusLb {
    if (!_statusLb) {
        _statusLb = [UILabel new];
        [self.contentView addSubview:_statusLb];
        [_statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.centerY.equalTo(0);
        }];
        _statusLb.font = [UIFont systemFontOfSize:14];
        _statusLb.textColor = kRGBA(100, 143, 255, 1.0);
        //test
        _statusLb.text = @"待医护接单";
    }
    return _statusLb;
}






@end
