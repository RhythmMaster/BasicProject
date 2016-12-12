//
//  HZQueryCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZQueryCell.h"

@implementation HZQueryCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self rightThreeSetBtn];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.bottom.equalTo(-10);
            make.width.equalTo(1);
            make.centerX.equalTo(0);
        }];
        lineView.backgroundColor = kRGBA(220, 220, 220, 1.0);
        
        
    }
    return  self;
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (HZThreeSetBtn *)leftThreeSetBtn {
    if (!_leftThreeSetBtn) {
        _leftThreeSetBtn = [HZThreeSetBtn buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_leftThreeSetBtn];
        [_leftThreeSetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(0);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_width).multipliedBy(0.5);
        }];
        
        
        
    }
    return _leftThreeSetBtn;
}

- (HZThreeSetBtn *)rightThreeSetBtn {
    if (!_rightThreeSetBtn) {
        _rightThreeSetBtn = [HZThreeSetBtn buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_rightThreeSetBtn];
        [_rightThreeSetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftThreeSetBtn.mas_right);
            make.top.equalTo(0);
            make.right.equalTo(0);
            make.height.equalTo(self.mas_height);
        }];
        
    }
    return _rightThreeSetBtn;
}




@end
