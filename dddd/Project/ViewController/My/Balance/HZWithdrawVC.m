//
//  HZWithdrawVC.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWithdrawVC.h"

@interface HZWithdrawVC ()<UITextFieldDelegate>


@property(nonatomic) UIView *backView;


@property(nonatomic) UIView *zhifuView;

@property(nonatomic) UILabel *zhifuNameLb;

@property(nonatomic) UIButton *accountBtn;





@property(nonatomic) UIView *WithdrawView;

@property(nonatomic) UILabel *moneyLb;

@property(nonatomic) UITextField *numberTF;



@property(nonatomic) UIView *balanceView;

@property(nonatomic) UILabel *balanceLb;

@property(nonatomic) UIButton *withdrawBtn;

@property(nonatomic) UILabel *timeLB;

@property(nonatomic) UIButton *sureBtn;

@end

@implementation HZWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(242, 242, 242, 1.0);
    self.title = @"余额提现";
    
    
    
    
    
    [self accountBtn];
    [self numberTF];
    [self withdrawBtn];
    [self sureBtn];
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark delete
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_numberTF resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    textField.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -懒加栽
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(16);
            make.right.equalTo(-16);
            make.height.equalTo(200);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIView *)zhifuView {
    
    if (!_zhifuView) {
        _zhifuView = [UIView new];
        [self.backView addSubview:_zhifuView];
        [_zhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(50);
        }];
        _zhifuView.backgroundColor = kRGBA(250, 250, 250, 1.0);
    }
    return _zhifuView;
}

- (UILabel *)zhifuNameLb {
    if (!_zhifuNameLb) {
        _zhifuNameLb = [UILabel new];
        [self.zhifuView addSubview:_zhifuNameLb];
        [_zhifuNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            
        }];
        _zhifuNameLb.font = [UIFont systemFontOfSize:20];
        _zhifuNameLb.text = @"到支付宝";
    }
    return _zhifuNameLb;
}

- (UIButton *)accountBtn {
    if (!_accountBtn) {
        _accountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.zhifuView addSubview:_accountBtn];
        [_accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.zhifuNameLb.mas_right).equalTo(24);
            make.centerY.equalTo(0);
        }];
        _accountBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_accountBtn setTitle:@"123456788" forState:UIControlStateNormal];
        [_accountBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _accountBtn;
}


- (UIView *)WithdrawView {
    if (!_WithdrawView) {
        _WithdrawView = [UIView new];
        [self.backView addSubview:_WithdrawView];
        [_WithdrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.zhifuView.mas_bottom);
            make.height.equalTo(100);
        }];
        
    }
    return _WithdrawView;
}

- (UILabel *)moneyLb {
    if (!_moneyLb) {
        _moneyLb = [UILabel new];
        [self.WithdrawView addSubview:_moneyLb];
        [_moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(14);
        }];
        _moneyLb.font = [UIFont systemFontOfSize:20];
        _moneyLb.text = @"提现金额";
    }
    return _moneyLb;
}

- (UITextField *)numberTF {
    if (!_numberTF) {
        _numberTF = [UITextField new];
        [self.WithdrawView addSubview:_numberTF];
        [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(45);
            make.right.equalTo(0);
            make.top.equalTo(self.moneyLb.mas_bottom).equalTo(10);
            make.height.equalTo(50);
        }];
        _numberTF.delegate = self;
        
        UILabel *qianLb = [UILabel new];
        [self.WithdrawView addSubview:qianLb];
        [qianLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(15);
            make.centerY.equalTo(_numberTF.mas_centerY);
            
        }];
        qianLb.font = [UIFont systemFontOfSize:30];
        qianLb.text = @"¥";
        
        
    }
    return _numberTF;
}

- (UIView *)balanceView {
    if (!_balanceView) {
        _balanceView = [UIView new];
        [self.backView addSubview:_balanceView];
        [_balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.WithdrawView.mas_bottom);
        }];
        UIView *lineView = [UIView new];
        [self.backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(_balanceView.mas_top);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kGrayColor;
    }
    return _balanceView;
}

- (UILabel *)balanceLb {
    if (!_balanceLb) {
        _balanceLb = [UILabel new];
        [self.balanceView addSubview:_balanceLb];
        [_balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            
        }];
        _balanceLb.textColor = kGrayColor;
        _balanceLb.text = @"零钱余额340,";
    }
    return _balanceLb;
}

- (UIButton *)withdrawBtn {
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.balanceView addSubview:_withdrawBtn];
        [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.balanceLb.mas_right).equalTo(8);
            make.centerY.equalTo(0);
        }];
        [_withdrawBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _withdrawBtn;
}


- (UILabel *)timeLB {
    if (!_timeLB) {
        _timeLB = [UILabel new];
        [self.view addSubview:_timeLB];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.backView.mas_bottom).equalTo(12);
        }];
        _timeLB.textColor = kGrayColor;
        _timeLB.text = @"2小时内到账";
    }
    return _timeLB;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(4);
            make.right.equalTo(-4);
            make.top.equalTo(self.timeLB.mas_bottom).equalTo(12);
            make.height.equalTo(50);
        }];
        _sureBtn.backgroundColor = kRGBA(42, 108, 245, 1.0);
        _sureBtn.layer.cornerRadius = 4;
        _sureBtn.clipsToBounds = YES;
        [_sureBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureBtn;
}








@end
