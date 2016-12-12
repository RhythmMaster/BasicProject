//
//  HZCertificateCell.m
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCertificateCell.h"

@implementation HZCertificateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self twoLb];
        [self addCertificateBtn];
        
        
        
        
        
        
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
        _oneLb.text = @"1. 上传您的证书的正面清晰照";
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
    
    
    
    if (_lastAddBtnNumber == _addBtnNumber) {//不变
        
        for (int i = 0; i < _addBtnNumber; i++) {
            _deleteBtn = self.deleteBtnArr[i];
            _deleteBtn.hidden = !_deleteBtnState;
        }
        
        
    } else if(_lastAddBtnNumber < _addBtnNumber) {//增加
        if (_addBtnNumber > 1) {
            
            _addBtn = [HZaddBtn buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:_addBtn];
            [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                
                make.top.equalTo(_lastBtn.mas_bottom).equalTo(10);
                
                make.right.equalTo(-20);
                make.height.equalTo(160);
            }];
            
            _addBtnArr[_addBtnNumber - 1] = _addBtn;
            
        }
        if (_addBtnNumber == 1) {
            _addBtn = [HZaddBtn buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:_addBtn];
            [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(20);
                
                make.top.equalTo(self.twoLb.mas_bottom).equalTo(15);
                
                make.right.equalTo(-20);
                make.height.equalTo(160);
            }];
        }
        self.addBtn.tag = _addBtnNumber + 200;
        self.addBtnArr[_addBtnNumber - 1] = _addBtn;
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addBtn addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(0);
            make.size.equalTo(CGSizeMake(20, 20));
            
        }];
        [_deleteBtn setImage:[UIImage imageNamed:@"delector"] forState:UIControlStateNormal];
        _deleteBtn.tag = _addBtnNumber + 100;
        _deleteBtn.hidden = !_deleteBtnState;
        self.deleteBtnArr[_addBtnNumber - 1] = _deleteBtn;
        
        
        
        
    } else {//删除
        
        //注:bug 不管点击哪个删除按钮,删除的都是从左后一个删除.到时候再改
        
        HZaddBtn *tmpBtn = (HZaddBtn *)self.addBtnArr[_addBtnNumber];
        
        [tmpBtn removeFromSuperview];
        
        
        
    }
    
    
    
    
    
    
    
    
    
    _addBtn.layer.cornerRadius = 4;
    _addBtn.clipsToBounds = YES;
    _addBtn.backgroundColor = kRGBA(223, 236, 254, 1.0);
    
    _addBtn.layer.borderWidth = 1;
    _addBtn.layer.borderColor = kBlueColor.CGColor;
    
    _lastBtn = _addBtn;
    _lastAddBtnNumber = _addBtnNumber;
    
    
    
}






- (UIButton *)addCertificateBtn {
    if (!_addCertificateBtn) {
        _addCertificateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_addCertificateBtn];
        [_addCertificateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-15);
            make.height.equalTo(40);
            make.centerX.equalTo(0);
            make.width.equalTo(kScreenW * 0.6);
        }];
        _addCertificateBtn.layer.cornerRadius = 20;
        _addCertificateBtn.clipsToBounds = YES;
        _addCertificateBtn.backgroundColor = kBlueColor;
        [_addCertificateBtn setTitle:@"添加证书" forState:UIControlStateNormal];
        [_addCertificateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _addCertificateBtn;
}

- (NSMutableArray<UIButton *> *)addBtnArr {
    if (!_addBtnArr) {
        _addBtnArr = [NSMutableArray new];
    }
    return _addBtnArr;
}
- (NSMutableArray<UIButton *> *)deleteBtnArr {
    if (!_deleteBtnArr) {
        _deleteBtnArr = [NSMutableArray new];
    }
    return _deleteBtnArr;
}


@end
