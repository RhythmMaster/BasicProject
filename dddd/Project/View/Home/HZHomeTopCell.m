//
//  HZHomeTopCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZHomeTopCell.h"

@implementation HZHomeTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self nameLb];
        [self signBtn];
        [self lineView];
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
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(10);
            make.width.equalTo(50);
            make.height.equalTo(50);
        }];
        _iconImg.image = [UIImage imageNamed:@"minr"];
        _iconImg.layer.cornerRadius = 25;
        _iconImg.clipsToBounds = YES;
    }
    
    _iconImg.backgroundColor = [UIColor redColor];
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).equalTo(8);
            make.centerY.equalTo(0);
        }];
        _nameLb.font = [UIFont systemFontOfSize:16];
    }
    return _nameLb;
}

- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_signBtn];
        [_signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
        [_signBtn setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
    }
    return _signBtn;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.height.equalTo(1);
            make.bottom.equalTo(0);
        }];
        _lineView.backgroundColor = kRGBA(220, 220, 220, 1.0);
    }
    return _lineView;
}




@end
