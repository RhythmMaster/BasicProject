//
//  HZCommentCell.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCommentCell.h"


@implementation HZCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self contentLb];
        [self timeLb];
       // [self starView];
        self.starView.hidden = YES;
        [self starRatingView];
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


#pragma mark delete
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(8);
            make.size.equalTo(CGSizeMake(46, 46));
        }];
        _iconImg.layer.cornerRadius = 23;
        _iconImg.clipsToBounds = YES;
        _iconImg.backgroundColor = [UIColor redColor];
    }
    return _iconImg;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(8);
            make.left.equalTo(self.iconImg.mas_right).equalTo(10);
        }];
        _nameLb.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
        _nameLb.text = @"王玲";
    }
    return _nameLb;
}


- (StarView *)starView {
    if (!_starView) {
        _starView = [[StarView alloc] initWithFrame:CGRectMake(60, 33, 120, 20)];
        [self.contentView addSubview:_starView];
        
        
        
    }
    return _starView;
}

- (HCSStarRatingView *)starRatingView {
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(60, 33, 120, 20)];
        [self.contentView addSubview:_starRatingView];
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.tintColor = [UIColor orangeColor];
        _starRatingView.allowsHalfStars = NO;
    }
    return _starRatingView;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [UILabel new];
        [self.contentView addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(self.starView.mas_bottom).equalTo(14);
            make.right.equalTo(-8);
            make.bottom.equalTo(-8);
        }];
        _contentLb.font = [UIFont systemFontOfSize:16];
        _contentLb.textColor = [UIColor grayColor];
        _contentLb.numberOfLines = 0;
        _contentLb.text = @"水电费水电费水电费等水电费水电费是发顺丰是否是否放松放松放松了经费落实 水电费是否是";
    }
    return _contentLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(8);
            make.right.equalTo(-10);
        }];
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.textColor = [UIColor grayColor];
        _timeLb.text = @"2016-11-11";
    }
    return _timeLb;
}












@end
