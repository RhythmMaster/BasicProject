//
//  HZRechargeVC.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZRechargeVC.h"

@interface HZRechargeVC ()<UITextFieldDelegate>


@property(nonatomic) UIView *zhifuView;

@property(nonatomic) UILabel *zhifuLb;

@property(nonatomic) UIButton *accountBtn;

@property(nonatomic) UILabel *limitLb;



@property(nonatomic) UIView *sumView;

@property(nonatomic) UILabel *sumLb;

@property(nonatomic) UITextField *sumTF;



@property(nonatomic) UIButton *nextBtn;

@end

@implementation HZRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(242, 242, 242, 1.0);
    self.title = @"余额充值";
    
    [self limitLb];
    [self sumLb];
    [self sumTF];
    
    [self nextBtn];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [_sumTF resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    textField.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}











- (UIView *)zhifuView {
    if (!_zhifuView) {
        _zhifuView = [UIView new];
        [self.view addSubview:_zhifuView];
        [_zhifuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(8);
            make.height.equalTo(70);
        }];
        _zhifuView.backgroundColor = [UIColor whiteColor];
    }
    return _zhifuView;
}

- (UILabel *)zhifuLb {
    if (!_zhifuLb) {
        _zhifuLb = [UILabel new];
        [self.zhifuView addSubview:_zhifuLb];
        [_zhifuLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(10);
            
        }];
        _zhifuLb.font = [UIFont systemFontOfSize:18];
        _zhifuLb.text = @"支付宝";
    }
    return _zhifuLb;
}
- (UIButton *)accountBtn {
    if (!_accountBtn) {
        _accountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.zhifuView addSubview:_accountBtn];
        [_accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.zhifuLb.mas_centerY);
            make.left.equalTo(self.zhifuLb.mas_right).equalTo(25);
            
        }];
        _accountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_accountBtn setTitle:@"1213243435" forState:UIControlStateNormal];
        [_accountBtn setTitleColor:kRGBA(50, 71, 122, 1.0) forState:UIControlStateNormal];
    }
    return _accountBtn;
}

- (UILabel *)limitLb {
    if (!_limitLb) {
        _limitLb = [UILabel new];
        [self.zhifuView addSubview:_limitLb];
        [_limitLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accountBtn.mas_left);
            make.top.equalTo(self.accountBtn.mas_bottom).equalTo(6);
        }];
        _limitLb.textColor = kGrayColor;
        _limitLb.font = [UIFont systemFontOfSize:16];
        _limitLb.text = @"单日交易限额:30000.00";
    }
    return _limitLb;
}


- (UIView *)sumView {
    if (!_sumView) {
        _sumView = [UIView new];
        [self.view addSubview:_sumView];
        [_sumView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.zhifuView.mas_bottom);
            make.height.equalTo(45);
        }];
        
        _sumView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [UIView new];
        [self.view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(_sumView.mas_top);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kGrayColor;
        
    }
    return _sumView;
}

- (UILabel *)sumLb {
    if (!_sumLb) {
        _sumLb = [UILabel new];
        [self.sumView addSubview:_sumLb];
        [_sumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        _sumLb.font = [UIFont systemFontOfSize:18];
        _sumLb.text = @"金额(元)";
    }
    return _sumLb;
}

- (UITextField *)sumTF {
    if (!_sumTF) {
        _sumTF = [UITextField new];
        [self.sumView addSubview:_sumTF];
        [_sumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(0);
            make.left.equalTo(self.sumLb.mas_right).equalTo(5);
            
            make.height.equalTo(50);
            
        }];
        _sumTF.delegate = self;
        
    }
    return _sumTF;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.right.equalTo(-8);
            make.top.equalTo(self.sumView.mas_bottom).equalTo(20);
            make.height.equalTo(50);
        }];
        _nextBtn.layer.cornerRadius = 4;
        _nextBtn.clipsToBounds = YES;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = kRGBA(146, 171, 215, 1.0);
    }
    return _nextBtn;
}









@end
