//
//  HZPersonalCell.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPersonalCell.h"

@implementation HZPersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self signImg];
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
- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_iconBtn];
        
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(10);
            make.size.equalTo(CGSizeMake(60, 60));
        }];
        
        _iconBtn.layer.cornerRadius = 60 * 0.5;
        _iconBtn.clipsToBounds = YES;
        _iconBtn.backgroundColor = [UIColor redColor];
    }
    return _iconBtn;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconBtn.mas_top).equalTo(8);
            make.left.equalTo(_iconBtn.mas_right).equalTo(10);
            
        }];
        _nameLb.font = [UIFont systemFontOfSize:18];
        _nameLb.textColor = [UIColor blackColor];
    }
    return _nameLb;
}

- (UILabel *)jobLb {
    if (!_jobLb) {
        _jobLb = [UILabel new];
        [self.contentView addSubview:_jobLb];
        [_jobLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLb.mas_centerY);
            make.left.equalTo(self.nameLb.mas_right).equalTo(5);
            
        }];
        _jobLb.font = [UIFont systemFontOfSize:12];
        _jobLb.textColor = [UIColor grayColor];
        
    }
    return _jobLb;
}



- (UIButton *)signImg {
    if (!_signImg) {
        _signImg = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:_signImg];
        [_signImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(80);
            make.top.equalTo(self.jobLb.mas_bottom).equalTo(10);
            make.size.equalTo(CGSizeMake(54, 21));
        }];
        //[_signImg setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
        
    }
    return _signImg;
}



















@end
