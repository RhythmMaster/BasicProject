//
//  HZIconCell.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIconCell.h"

@implementation HZIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self iconNameLb];
        [self iconBtn];
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




- (UILabel *)iconNameLb {
    if (!_iconNameLb) {
        _iconNameLb = [UILabel new];
        [self.contentView addSubview:_iconNameLb];
        [_iconNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            
        }];
        _iconNameLb.text = @"头像";
    }
    return _iconNameLb;
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(50, 50));
        }];
        _iconBtn.layer.cornerRadius = 25;
        _iconBtn.clipsToBounds = YES;
        [_iconBtn setImage:[UIImage imageNamed:@"icon_l_def_tx"] forState:UIControlStateNormal];
    }
    return _iconBtn;
}











@end
