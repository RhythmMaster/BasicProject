//
//  HZIDCardCell.m
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIDCardCell.h"

@implementation HZIDCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addBtnUI];
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



- (UILabel *)oneLb {
    if (!_oneLb) {
        _oneLb = [UILabel new];
        [self.contentView addSubview:_oneLb];
        [_oneLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(8);
        }];
        _oneLb.textColor = kGrayColor;
        _oneLb.font = [UIFont systemFontOfSize:14];
        _oneLb.text = @"1. 请上传您本人身份证的正反面清晰照";
    }
    return _oneLb;
}


- (UILabel *)twoLb {
    if (!_twoLb) {
        _twoLb = [UILabel new];
        [self.contentView addSubview:_twoLb];
        [_twoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.oneLb.mas_bottom).equalTo(4);
        }];
        _twoLb.font = [UIFont systemFontOfSize:14];
        _twoLb.textColor = kGrayColor;
        _twoLb.text = @"2. 照片支持jpg/jpeg/bmp格式, 最大不超过10M;";
        
        
    }
    return _twoLb;
}

- (void)addBtnUI {
    HZaddBtn *lastBtn = nil;
    for (int i = 0; i < 2; i++) {
        _addBtn = [HZaddBtn buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.height.equalTo(130);
            if (i == 0) {
                make.top.equalTo(self.twoLb.mas_bottom).equalTo(15);
            } else {
                make.top.equalTo(lastBtn.mas_bottom).equalTo(15);
            }
        }];
        if (i) {
            _addBtn.addLb.text = @"请点击上传身份证背面";
        } else {
            _addBtn.addLb.text = @"请点击上传身份证正面";
        }
        
        _addBtn.layer.cornerRadius = 4;
        _addBtn.clipsToBounds = YES;
        _addBtn.backgroundColor = kRGBA(223, 236, 254, 1.0);
        
        _addBtn.layer.borderWidth = 1;
        _addBtn.layer.borderColor = kBlueColor.CGColor;
        
        
        lastBtn = _addBtn;
    }
}



@end
