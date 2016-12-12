//
//  HZIncomeDetailCell.m
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIncomeDetailCell.h"

@implementation HZIncomeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier count:(NSInteger)count {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.count = count;
        
        //[self initLb];
        [self labelArr];
        
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


- (NSArray<UILabel *> *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSArray new];
        NSMutableArray *tmpArr = [NSMutableArray new];
        UILabel *lastLb = nil;
        for (int i = 0; i < _count; i++) {
            UILabel *label = [UILabel new];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(8);
                if (i == 0) {
                    make.top.equalTo(8);
                } else {
                    make.top.equalTo(lastLb.mas_bottom).equalTo(4);
                }
                if (i == _count - 1) {
                    make.bottom.equalTo(-8);
                }
            }];
            
            label.textColor = kGrayColor;
            label.font = [UIFont systemFontOfSize:12];
            label.text = [NSString stringWithFormat:@"%d", i];
            lastLb = label;
            [tmpArr addObject:label];
            
        }
        _labelArr = tmpArr.copy;
    }
    return _labelArr;
}



@end
