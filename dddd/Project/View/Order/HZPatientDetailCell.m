//
//  HZPatientDetailCell.m
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPatientDetailCell.h"

@implementation HZPatientDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self timeLb];
        
        [self callBtn];
        [self orderTimeLb];
        [self describeLb];
        // [self describeBtn];
        
        
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
        _iconImg.layer.cornerRadius = 20;
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
        _patientNameLb.font = [UIFont systemFontOfSize:11];
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
        _projectLb.font = [UIFont systemFontOfSize:11];
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
        _timeLb.font = [UIFont systemFontOfSize:11];
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
            make.height.equalTo(60);
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
        _contactsLb.textColor = kRGBA(88, 88, 88, 1.0);
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
        _addressLb.textColor = kRGBA(88, 88, 88, 1.0);
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
        _orderTimeLb.font = [UIFont systemFontOfSize:11];
        _orderTimeLb.textColor = kRGBA(88, 88, 88, 1.0);
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

- (UILabel *)needLb {
    if (!_needLb) {
        _needLb = [UILabel new];
        [self.contentView addSubview:_needLb];
        [_needLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(self.centerView.mas_bottom).equalTo(-5);
        }];
        _needLb.font = [UIFont systemFontOfSize:11];
        _needLb.textColor = kRGBA(88, 88, 88, 1.0);
        //test
        _needLb.text = @"需求描述:";
        
    }
    return _needLb;
}

- (HZCustomLabel *)describeLb {
    if (!_describeLb) {
        _describeLb = [HZCustomLabel new];
        [self.contentView addSubview:_describeLb];
        [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.width.equalTo(kScreenW - 16);
            make.top.equalTo(self.needLb.mas_bottom).equalTo(5);
            make.bottom.equalTo(-5);
        }];
        _describeLb.numberOfLines = 0;
        _describeLb.font = [UIFont systemFontOfSize:10];
        _describeLb.textColor = kGrayColor;
        
        
        _describeLb.layer.cornerRadius = 5;
        _describeLb.clipsToBounds = YES;
        _describeLb.layer.borderWidth = 1;
        _describeLb.layer.borderColor = kGrayColor.CGColor;
        
        _describeLb.textInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        _describeLb.lineBreakMode = NSLineBreakByCharWrapping;
        
        
        
        
        
    }
    return _describeLb;
}


- (UIButton *)describeBtn {
    if (!_describeBtn) {
        _describeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_describeBtn];
        [_describeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.right.equalTo(-8);
            make.top.equalTo(self.needLb.mas_bottom).equalTo(5);
            make.bottom.equalTo(-5);
        }];
        _describeBtn.enabled = NO;
        _describeBtn.layer.cornerRadius = 5;
        _describeBtn.clipsToBounds = YES;
        _describeBtn.layer.borderWidth = 1;
        _describeBtn.layer.borderColor = kGrayColor.CGColor;
        _describeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _describeBtn.titleLabel.textColor = kGrayColor;
        _describeBtn.titleLabel.numberOfLines = 0;
        _describeBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }
    return _describeBtn;
}

@end
