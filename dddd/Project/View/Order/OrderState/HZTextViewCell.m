//
//  HZTextViewCell.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTextViewCell.h"

@implementation HZTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self textView];
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
            make.top.equalTo(8);
        }];
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.textColor = kGrayColor;
        _titleLb.text = @"医护填写诊疗记录:";
    }
    return _titleLb;
}
- (JSTextView *)textView {
    if (!_textView) {
        _textView = [JSTextView new];
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(8);
            make.right.equalTo(-8);
            make.height.equalTo(100);
        }];
        _textView.placeholder = @"请填写诊疗记录";
    }
    return _textView;
}

@end
