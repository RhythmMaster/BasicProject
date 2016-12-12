//
//  HZPatientCell.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPatientCell.h"

@implementation HZPatientCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self timeLb];
        
        [self callBtn];
        [self orderTimeLb];
        
        //        [self titleLb];
        
        
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
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        [self.contentView addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(60);
        }];
        
    }
    return _topView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        [_topView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.centerY.equalTo(0);
            make.width.equalTo(42);
            make.height.equalTo(42);
        }];
        _iconImg.backgroundColor = [UIColor blueColor];
        //头像变圆
        _iconImg.layer.cornerRadius = 21;
        _iconImg.clipsToBounds = YES;
    }
    return _iconImg;
}

- (UILabel *)patientNameLb {
    if (!_patientNameLb) {
        _patientNameLb = [UILabel new];
        [_topView addSubview:_patientNameLb];
        [_patientNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).equalTo(8);
            make.top.equalTo(_iconImg.mas_top);
            
        }];
        _patientNameLb.font = [UIFont systemFontOfSize:12];
        _patientNameLb.textColor = kRGBA(88, 88, 88, 1.0);
        //test
        _patientNameLb.text = @"就诊人员: 王玲 女 63";
    }
    return _patientNameLb;
}


- (UILabel *)projectLb {
    if (!_projectLb) {
        _projectLb = [UILabel new];
        [_topView addSubview:_projectLb];
        [_projectLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.patientNameLb.mas_left);
            make.centerY.equalTo(0);
            
        }];
        _projectLb.font = [UIFont systemFontOfSize:12];
        _projectLb.textColor = kRGBA(88, 88, 88, 1.0);
        //test
        _projectLb.text = @"服务项目: 服务+医疗包+纱布";
        
    }
    return _projectLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [UILabel new];
        [self.topView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.projectLb.mas_left);
            make.bottom.equalTo(_iconImg.mas_bottom);
        }];
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.textColor = kRGBA(88, 88, 88, 1.0);
        //test
        _timeLb.text = @"服务时间: 2016-10-13-16:43";
    }
    return _timeLb;
}




- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        [self.contentView addSubview:_centerView];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(_topView.mas_bottom).equalTo(0);
            make.height.equalTo(self.mas_height).multipliedBy(0.35);
        }];
        
    }
    return _centerView;
}


- (UILabel *)contactsLb {
    if (!_contactsLb) {
        _contactsLb = [UILabel new];
        [_centerView addSubview:_contactsLb];
        [_contactsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(4);
        }];
        _contactsLb.font = [UIFont systemFontOfSize:11];
        _contactsLb.textColor = [UIColor grayColor];
        //test
        _contactsLb.text = @"联系人员: 李智 1330909090";
    }
    return _contactsLb;
}

- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb = [UILabel new];
        [_centerView addSubview:_addressLb];
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contactsLb.mas_left);
            make.top.equalTo(_contactsLb.mas_bottom).equalTo(3);
            
            
        }];
        _addressLb.font = [UIFont systemFontOfSize:11];
        _addressLb.textColor = [UIColor grayColor];
        //test
        _addressLb.text = @"服务地址: 上海经办区恒大";
    }
    return _addressLb;
}

- (UILabel *)orderTimeLb {
    if (!_orderTimeLb) {
        _orderTimeLb = [UILabel new];
        [_centerView addSubview:_orderTimeLb];
        [_orderTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.addressLb.mas_left);
            make.top.equalTo(_addressLb.mas_bottom).equalTo(3);
        }];
        _orderTimeLb.font = [UIFont systemFontOfSize:12];
        _orderTimeLb.textColor = [UIColor grayColor];
        //test
        _orderTimeLb.text = @"下订单时间: 2016-10-12-14:23";
    }
    return _orderTimeLb;
}


- (UIButton *)callBtn {
    if (!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.centerView addSubview:_callBtn];
        [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.addressLb.mas_centerY);
            make.right.equalTo(-8);
        }];
        [_callBtn setImage:[UIImage imageNamed:@"icon_l_tellogo"] forState:UIControlStateNormal];
    }
    return _callBtn;
}



- (UIView *)clockView {
    if (!_clockView) {
        _clockView = [UIView new];
        [self.contentView addSubview:_clockView];
        [_clockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.centerView.mas_bottom);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.15);
        }];
        
    }
    return _clockView;
}

- (UILabel *)secondLb {
    if (!_secondLb) {
        _secondLb = [UILabel new];
        [self.clockView addSubview:_secondLb];
        [_secondLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.bottom.equalTo(-3);
            make.size.equalTo(CGSizeMake(14, 14));
        }];
        _secondLb.font = [UIFont systemFontOfSize:11];
        _secondLb.textColor = kRGBA(59, 161, 235, 10);
        _secondLb.text = @"22";
        _secondLb.layer.borderColor = kRGBA(59, 161, 235, 10).CGColor;
        _secondLb.layer.borderWidth = 1;
        _secondLb.layer.cornerRadius = 2;
        _secondLb.clipsToBounds = YES;
        _secondLb.textAlignment = NSTextAlignmentCenter;
        
    }
    
    UILabel *colonLb = [UILabel new];
    [self.clockView addSubview:colonLb];
    [colonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondLb.mas_left).equalTo(-0.5);
        make.bottom.equalTo(-3);
    }];
    colonLb.textAlignment = NSTextAlignmentCenter;
    colonLb.font = [UIFont systemFontOfSize:12];
    colonLb.text = @":";
    
    
    
    
    
    return _secondLb;
}


- (UILabel *)minuteLb {
    if (!_minuteLb) {
        _minuteLb = [UILabel new];
        [self.clockView addSubview:_minuteLb];
        [_minuteLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.secondLb.mas_left).equalTo(-4);
            make.bottom.equalTo(-3);
            make.size.equalTo(CGSizeMake(14, 14));
        }];
        _minuteLb.font = [UIFont systemFontOfSize:11];
        _minuteLb.textColor = kRGBA(59, 161, 235, 10);
        _minuteLb.text = @"11";
        _minuteLb.layer.borderColor = kRGBA(59, 161, 235, 10).CGColor;
        _minuteLb.layer.borderWidth = 1;
        _minuteLb.layer.cornerRadius = 2;
        _minuteLb.clipsToBounds = YES;
        _minuteLb.textAlignment = NSTextAlignmentCenter;
    }
    
    
    
    UILabel *colonLb = [UILabel new];
    [self.clockView addSubview:colonLb];
    [colonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_minuteLb.mas_left).equalTo(-0.5);
        make.bottom.equalTo(-3);
    }];
    colonLb.textAlignment = NSTextAlignmentCenter;
    colonLb.font = [UIFont systemFontOfSize:12];
    colonLb.text = @":";
    
    
    return _minuteLb;
}


- (UILabel *)hourLb {
    if (!_hourLb) {
        _hourLb = [UILabel new];
        [self.clockView addSubview:_hourLb];
        [_hourLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.minuteLb.mas_left).equalTo(-4);
            make.bottom.equalTo(-3);
            make.size.equalTo(CGSizeMake(14, 14));
        }];
        _hourLb.font = [UIFont systemFontOfSize:11];
        _hourLb.textColor = kRGBA(59, 161, 235, 10);
        _hourLb.text = @"23";
        _hourLb.layer.borderColor = kRGBA(59, 161, 235, 10).CGColor;
        _hourLb.layer.borderWidth = 1;
        _hourLb.layer.cornerRadius = 2;
        _hourLb.clipsToBounds = YES;
        _hourLb.textAlignment = NSTextAlignmentCenter;
    }
    return _hourLb;
}


- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.clockView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.hourLb.mas_left).equalTo(-8);
            make.bottom.equalTo(-3);
        }];
        _titleLb.font = [UIFont systemFontOfSize:12];
        _titleLb.textColor = kRGBA(59, 161, 235, 10);
        _titleLb.text = @"距离预定服务时间开始还剩:";
    }
    return _titleLb;
}



@end
