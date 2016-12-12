//
//  HZEmptyCell.m
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZEmptyCell.h"

@implementation HZEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self emptyImg];
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


- (UIImageView *)emptyImg {
    if (!_emptyImg) {
        _emptyImg = [UIImageView new];
        [self.contentView addSubview:_emptyImg];
        [_emptyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(30);
            make.size.equalTo(CGSizeMake(80, 90));
        }];
        _emptyImg.image = [UIImage imageNamed:@"暂无订单"];
        
        
        _orderLb = [UILabel new];
        [self.contentView addSubview:_orderLb];
        [_orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(_emptyImg.mas_bottom).equalTo(8);
            
        }];
        _orderLb.font = [UIFont systemFontOfSize:18];
        _orderLb.textColor = kGrayColor;
        _orderLb.text = @"暂无订单";
    }
    return _emptyImg;
}


@end
