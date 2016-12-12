//
//  LoginViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/7.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoView.h"
#import "RegisterViewController.h"
#import "HZForgetViewController.h"
#import "HZMainTabBarVC.h"
#import "HZGetCodeNM.h"

@interface LoginViewController ()<UITextFieldDelegate>


@property(nonatomic) RegisterViewController *registerVC;

@property (nonatomic) UITextField *tfUserPhone;

@property(nonatomic) UITextField *tfUserPwd;

@property(nonatomic) UIView *UserAndPwdView;

@property(nonatomic) UIView *loginAndOutView;

@property(nonatomic) UIButton *loginBtn;

@property(nonatomic) UIButton *registerBtn;

@property(nonatomic) UIButton *forgetBtn;

@property(nonatomic,assign) CGFloat offSet;


@end

@implementation LoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //增加对键盘的监听,当键盘出现或改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加对键盘的监听,当键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    LogoView *logoView = [LogoView new];
    logoView.frame = CGRectMake(0, 0, kScreenW, kScreenH * 0.45);
    [self.view addSubview:logoView];
    
    [self UserAndPwdView];
    [self loginAndOutView];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (_tfUserPwd == textField) {
        [_tfUserPwd resignFirstResponder];
    } else {
        [_tfUserPhone resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _tfUserPhone) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark method
- (UIImageView *)tfBackImg {
    
    UIImageView *tfBackImg = [UIImageView new];
    tfBackImg.userInteractionEnabled = YES;
    tfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
    return tfBackImg;
}


- (void)moveDownKeyBoard {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)moveUpKeyBoard:(CGFloat)offset{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    NSLog(@"height:%f", height);
    
    
    
    
    
    CGFloat registerBtnY = _loginAndOutView.y + _registerBtn.y;
    NSLog(@"registerBtnY + %f", registerBtnY);
    //registerBtn底部到textFieldY距离
    
    CGFloat registerBottomH = self.view.y - (registerBtnY + _registerBtn.height);
    
    if (height > registerBottomH) {
        _offSet = registerBtnY +  _registerBtn.height - (self.view.height - height);
        [self moveUpKeyBoard:_offSet];
    }
    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.view.frame.origin.y < 0) {
        [self moveDownKeyBoard];
    }
    
    
}

//登录
- (void)loginClick:(UIButton *)sender {
    NSLog(@"点了login.......");
//    HZMainTabBarVC *mainTabVc = [HZMainTabBarVC new];
//    [self.navigationController pushViewController:mainTabVc animated:YES];
//    return;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_tfUserPhone.text forKey:@"phoneText"];
    [defaults synchronize];
    
    NSString *phoneText = _tfUserPhone.text;
    NSString *password = _tfUserPwd.text;
    
    if (![TZLFactory isInvalidPhoneNumber:phoneText]) {
        [self.view showWarning:@"请输入正确手机号码"];
        return;
    }
    if (![TZLFactory isInvalidPassWord:password]) {
        [self.view showWarning:@"请输入正确格式的密码"];
        return;
    }
    
    [self.view showBusyHUD];
    [HZGetCodeNM getLoginWithPhoneNumber:phoneText password:password completionHandler:^(id model, NSError *error) {
        
        NSLog(@"%@", model);
        [self.view showWarning:[model objectForKey:@"MSG"]];
        
        if ([[model objectForKey:@"MSG"] isEqualToString:@"成功"]) {
            HZMainTabBarVC *mainTabVc = [HZMainTabBarVC new];
            [self.navigationController pushViewController:mainTabVc animated:YES];
            //[mainTabVc.view showWarning:[model objectForKey:@"MSG"]];
            return;
        } else {
            return;
        }
        
    }];
    
    
    
    
}


#pragma mark 懒加栽

/** 登录注册模块 */
- (UIView *)UserAndPwdView {
    if (!_UserAndPwdView) {
        
        _UserAndPwdView = [UIView new];
        _UserAndPwdView.frame = CGRectMake(0, kScreenH * 0.45, kScreenW, kScreenH * 0.25);
        [self.view addSubview:_UserAndPwdView];
        
        //用户输入框背景
        UIImageView *userTfBackImg = [self tfBackImg];
        [_UserAndPwdView addSubview:userTfBackImg];
        [userTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(4);
            make.centerX.equalTo(_UserAndPwdView.mas_centerX);
            make.width.equalTo(_UserAndPwdView.mas_width).multipliedBy(0.8);
            make.height.equalTo(_UserAndPwdView.mas_height).multipliedBy(0.25);
        }];
        
        //用户名icon
        UIImageView *userIcon = [UIImageView new];
        userIcon.image = [UIImage imageNamed:@"icon-请输入用户名"];
        [userTfBackImg addSubview:userIcon];
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_UserAndPwdView.width * 0.05, _UserAndPwdView.height * 0.15));
            
        }];
        
        //用户输入框
        [userTfBackImg addSubview:self.tfUserPhone];
        [_tfUserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userIcon.mas_right).equalTo(20);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_UserAndPwdView.width * 0.6, _UserAndPwdView.height * 0.15));
        }];
        
        
        
        //密码输入框背景
        UIImageView *pwdTfBackImg = [self tfBackImg];
        [_UserAndPwdView addSubview:pwdTfBackImg];
        [pwdTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userTfBackImg.mas_bottom).equalTo(15);
            make.centerX.equalTo(_UserAndPwdView.mas_centerX);
            make.width.equalTo(_UserAndPwdView.mas_width).multipliedBy(0.8);
            make.height.equalTo(_UserAndPwdView.mas_height).multipliedBy(0.25);
        }];
        
        //密码icon
        UIImageView *pwdIcon = [UIImageView new];
        pwdIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
        [pwdTfBackImg addSubview:pwdIcon];
        [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_UserAndPwdView.width * 0.05, _UserAndPwdView.height * 0.15));
        }];
        
        //密码输入框
        [pwdTfBackImg addSubview:self.tfUserPwd];
        [_tfUserPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdIcon.mas_right).equalTo(20);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_UserAndPwdView.width * 0.6, _UserAndPwdView.height * 0.15));
        }];
        
        
        //忘记密码
        self.forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:kRGBA(38, 107, 255, 1.0) forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_UserAndPwdView addSubview:_forgetBtn];
        [_forgetBtn bk_addEventHandler:^(id sender) {
            //忘记密码的跳转
            NSLog(@"大哥,点过了..............");
            HZForgetViewController *forgetVC = [HZForgetViewController new];
            [self.navigationController pushViewController:forgetVC animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdTfBackImg.mas_left).equalTo(15);
            make.top.equalTo(pwdTfBackImg.mas_bottom).equalTo(10);
        }];
        
        //线
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kRGBA(38, 107, 255, 10);
        [_UserAndPwdView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_forgetBtn.mas_left);
            make.right.equalTo(_forgetBtn.mas_right);
            make.height.equalTo(1);
            make.top.equalTo(_forgetBtn.mas_bottom).equalTo(-5);
        }];
        
    }
    return _UserAndPwdView;
}


/** 登录注册按钮 */
- (UIView *)loginAndOutView {
    if (!_loginAndOutView) {
        
        _loginAndOutView = [UIView new];
        _loginAndOutView.frame = CGRectMake(0, kScreenH * 0.7, kScreenW, kScreenH * 0.3);
        [self.view addSubview:_loginAndOutView];
        
        //login
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginBtn.layer.cornerRadius = 20;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = kRGBA(38, 107, 255, 1.0);
        [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_loginAndOutView addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_loginAndOutView.mas_top);
            make.centerX.equalTo(_loginAndOutView.mas_centerX);
            make.height.equalTo(_loginAndOutView.mas_height).multipliedBy(0.2);
            make.width.equalTo(_loginAndOutView.mas_width).multipliedBy(0.8);
        }];
        
        //register
        self.registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerBtn.layer.cornerRadius = 20;
        _registerBtn.layer.masksToBounds = YES;
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:kRGBA(38, 107, 255, 1.0) forState:UIControlStateNormal];
        
        [_registerBtn bk_addEventHandler:^(id sender) {
            NSLog(@"点了register");
            _registerVC = [RegisterViewController new];
            WK(weakSelf)
            _registerVC.block = ^(NSString *str) {
                NSLog(@"%@", str);
                weakSelf.tfUserPhone.text = str;
            };
            [self.navigationController pushViewController:_registerVC animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_loginAndOutView addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_loginBtn.mas_bottom).equalTo(15);
            make.centerX.equalTo(_loginBtn.mas_centerX);
            make.height.equalTo(_loginAndOutView.mas_height).multipliedBy(0.1);
            make.width.equalTo(_loginAndOutView.mas_width).multipliedBy(0.8);
        }];
        
    }
    return _loginAndOutView;
}





- (UITextField *)tfUserPhone {
    if (!_tfUserPhone) {
        _tfUserPhone = [[UITextField alloc] init];
        [_tfUserPhone setTextColor:[UIColor whiteColor]];
        [_tfUserPhone.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserPhone.textColor = kBlueColor;
        [_tfUserPhone setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
        _tfUserPhone.font = [UIFont systemFontOfSize:14];
        _tfUserPhone.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPhone.delegate = self;
        [self.view addSubview:_tfUserPhone];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *phone = [defaults valueForKey:@"phoneText"];
        if (phone) {
            _tfUserPhone.text = phone;
        }
        
    }
    return _tfUserPhone;
}

- (UITextField *)tfUserPwd {
    if (!_tfUserPwd) {
        _tfUserPwd = [[UITextField alloc] init];
        _tfUserPwd.font = [UIFont systemFontOfSize:14];
        [_tfUserPwd setTextColor:[UIColor whiteColor]];
        [_tfUserPwd.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserPwd.textColor = kBlueColor;
        _tfUserPwd.placeholder = @"请输入密码";
        _tfUserPwd.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPwd.delegate = self;
        [_tfUserPwd setSecureTextEntry:YES];
        [self.view addSubview:_tfUserPwd];
        
    }
    return _tfUserPwd;
}







@end
