//
//  RegisterViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/7.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate>


@property(nonatomic) NSInteger timerCount;
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic) UIView *registerView;

@property (nonatomic) UITextField *tfUserPhone;

@property (nonatomic,strong)UIButton *selectButton;

@property(nonatomic) NSString *UUID;


@property(nonatomic) UIButton *getCodeBtn;

@property(nonatomic) UITextField *tfUserPwd;

@property(nonatomic) UITextField *tfUserCode;

@property(nonatomic) UIView *BackView;

@property(nonatomic) UIView *btnView;

@property(nonatomic) UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LogoView *logoView = [LogoView new];
    logoView.frame = CGRectMake(0, 0, kScreenW, kScreenH * 0.45);
    [self.view addSubview:logoView];
    
    _UUID = [[NSUUID UUID] UUIDString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.UUID forKey:@"uuid"];
    [defaults synchronize];
    
    
    [self registerView];
    [self BackView];
    [self btnView];
    
    
    //增加对键盘的监听,当键盘出现或改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加对键盘的监听,当键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark delete
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (_tfUserPwd == textField) {
        [_tfUserPwd resignFirstResponder];
    } else if (_tfUserPhone) {
        [_tfUserPhone resignFirstResponder];
    } else {
        [_tfUserCode resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _tfUserPhone || textField == _tfUserCode) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark method

- (void)phone:(phoneBlock)block {
    self.block = block;
}





- (UIImageView *)tfBackImg {
    
    UIImageView *tfBackImg = [UIImageView new];
    tfBackImg.userInteractionEnabled = YES;
    tfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
    return tfBackImg;
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)selectbuttonClick:(UIButton *)sender {
    
    _selectButton.selected = !_selectButton.selected;
    if (_selectButton.selected == YES) {
        _registerBtn.enabled = YES;
    }else
    {
        _registerBtn.enabled = NO;
        
    }
    
}


//获取验证码
- (void)getCodeClick:(UIButton *)sender {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *uuid = [defaults valueForKey:@"uuid"];
    
    NSString *phoneText = _tfUserPhone.text;
    
    if (![TZLFactory isInvalidPhoneNumber:phoneText]) {
        [self.view showWarning:@"请输入正确手机号码"];
        return;
    } else {
        _timerCount = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        [sender setEnabled:false];
        
    }
    [HZGetCodeNM getRandomCodeWithUUID:_UUID phoneNumber:phoneText completionHandler:^(id model, NSError *error) {
        
        NSLog(@"%@", model);
        NSDictionary *resultDic = model;
        [self.view showWarning:[resultDic objectForKey:@"MSG"]];
        
    }];
    
    
}
//注册
- (void)registerClick:(UIButton *)sender {
    
    
    NSString *phoneText = _tfUserPhone.text;
    NSString *randomCode = _tfUserCode.text;
    NSString *password = _tfUserPwd.text;
    
    if (![TZLFactory isInvalidPhoneNumber:phoneText]) {
        [self.view showWarning:@"请输入正确手机号码"];
        return;
    }
    if (![TZLFactory isInvalidRegisterCode:randomCode]) {
        [self.view showWarning:@"请输入正确验证码"];
        return;
    }
    if (![TZLFactory isInvalidPassWord:password]) {
        [self.view showWarning:@"请输入正确格式的密码"];
        return;
    }
    
    
    
    
    if (_selectButton.selected == YES) {
        
        [HZGetCodeNM getRandomCodeWithUUID:_UUID phoneNumber:phoneText codeNumber:randomCode password:password completionHandler:^(id model, NSError *error) {
            
            NSLog(@"%@", model);
            NSDictionary *resultDic = model;
            [self.view showWarning:[resultDic objectForKey:@"MSG"]];
            if ([[resultDic objectForKey:@"MSG"] isEqualToString:@"成功"]) {
                
                
                if (self.block != nil) {
                    self.block(_tfUserPhone.text);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
        }];
        
        
    } else {
        [self.view showWarning:@"请同意用户协议"];
        return;
    }
    
    
    
}




- (void)timerFireMethod:(UIButton *)sender {
    
    _timerCount--;
    if(_timerCount == 0){
        [_timer invalidate];
        _timer = nil;
        [_getCodeBtn setEnabled:true];
        //   [_getcodeButton setBackgroundColor:baseTheamColor];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        
        NSString *title=[NSString stringWithFormat:@"%ldS重发",_timerCount];
        [_getCodeBtn setTitle:title forState:UIControlStateNormal];
    }
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
    
    
    
    
    
    CGFloat registerBtnY = _btnView.y + _registerBtn.y;
    NSLog(@"registerBtnY + %f", registerBtnY);
    //registerBtn底部到textFieldY距离
    
    CGFloat registerBottomH = self.view.y - (registerBtnY + _registerBtn.height);
    
    if (height > registerBottomH) {
        CGFloat offSet = registerBtnY +  _registerBtn.height - (self.view.height - height);
        [self moveUpKeyBoard:offSet];
    }
    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.view.frame.origin.y < 0) {
        [self moveDownKeyBoard];
    }
    
    
}



#pragma mark -懒加栽
- (UIView *)registerView {
    if (!_registerView) {
        _registerView = [UIView new];
        _registerView.frame = CGRectMake(0, kScreenH * 0.45, kScreenW, kScreenH * 0.25);
        [self.view addSubview:_registerView];
        
        //用户输入框背景
        UIImageView *userTfBackImg = [self tfBackImg];
        [_registerView addSubview:userTfBackImg];
        [userTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.8);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        //用户名icon
        UIImageView *userIcon = [UIImageView new];
        userIcon.image = [UIImage imageNamed:@"icon-请输入用户名"];
        [userTfBackImg addSubview:userIcon];
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
            
        }];
        
        //用户输入框
        [userTfBackImg addSubview:self.tfUserPhone];
        [_tfUserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userIcon.mas_right).equalTo(20);
            make.centerY.equalTo(userTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.6, _registerView.height * 0.15));
        }];
        
        
        
        //验证码输入框背景
        UIImageView *CodeTfBackImg = [UIImageView new];
        CodeTfBackImg.userInteractionEnabled = YES;
        CodeTfBackImg.image = [UIImage imageNamed:@"bg_edittext_login2"];
        [_registerView addSubview:CodeTfBackImg];
        [CodeTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userTfBackImg.mas_bottom).equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.8);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        //密码icon
        UIImageView *pwdIcon = [UIImageView new];
        pwdIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
        [CodeTfBackImg addSubview:pwdIcon];
        [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(CodeTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
        }];
        
        //密码输入框
        [CodeTfBackImg addSubview:self.tfUserCode];
        [_tfUserCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdIcon.mas_right).equalTo(20);
            make.centerY.equalTo(CodeTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.4, _registerView.height * 0.15));
        }];
        
        
        //获取验证码
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [CodeTfBackImg addSubview:_getCodeBtn];
        [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(CodeTfBackImg.mas_centerY);
        }];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_getCodeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //密码
        //背景框
        UIImageView *pwdTfBackImg = [UIImageView new];
        pwdTfBackImg.userInteractionEnabled = YES;
        pwdTfBackImg.image = [UIImage imageNamed:@"bg_edittext_login"];
        [_registerView addSubview:pwdTfBackImg];
        [pwdTfBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CodeTfBackImg.mas_bottom).equalTo(15);
            make.centerX.equalTo(_registerView.mas_centerX);
            make.width.equalTo(_registerView.mas_width).multipliedBy(0.8);
            make.height.equalTo(_registerView.mas_height).multipliedBy(0.25);
        }];
        
        //密码icon
        UIImageView *psdIcon = [UIImageView new];
        psdIcon.image = [UIImage imageNamed:@"icon-请输入密码"];
        [pwdTfBackImg addSubview:psdIcon];
        [psdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.05, _registerView.height * 0.15));
        }];
        //密码输入框
        [pwdTfBackImg addSubview:self.tfUserPwd];
        [_tfUserPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pwdIcon.mas_right).equalTo(20);
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.size.equalTo(CGSizeMake(_registerView.width * 0.8, _registerView.height * 0.15));
        }];
        
        
        
        
        UIButton *isSeeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [isSeeBtn setImage:[UIImage imageNamed:@"icon_pw_see"] forState:UIControlStateNormal];
        [pwdTfBackImg addSubview:isSeeBtn];
        [isSeeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pwdTfBackImg.mas_centerY);
            make.right.equalTo(-8);
        }];
        [isSeeBtn bk_addEventHandler:^(id sender) {
            _tfUserPwd.secureTextEntry = !_tfUserPwd.secureTextEntry;
        } forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _registerView;
}



//back
- (UIView *)BackView {
    if (!_BackView) {
        _BackView = [UIView new];
        [self.view addSubview:_BackView];
        _BackView.frame = CGRectMake(0, 0, kScreenW, kScreenH * 0.1);
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [imgBtn setImage:[UIImage imageNamed:@"icon-蓝色返回"] forState:UIControlStateNormal];
        [_BackView addSubview:imgBtn];
        [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_BackView.mas_centerY);
            make.size.equalTo(CGSizeMake(_BackView.height * 0.5, _BackView.height * 0.5));
        }];
        [imgBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setTitle:@"登录" forState:UIControlStateNormal];
        [backBtn setTitleColor:kRGBA(38, 107, 255, 1.0) forState:UIControlStateNormal];
        [_BackView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_BackView.mas_centerY);
            make.left.equalTo(imgBtn.mas_right).equalTo(-5);
            
        }];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _BackView;
}


- (UIView *)btnView {
    if (!_btnView) {
        _btnView = [UIView new];
        _btnView.frame = CGRectMake(0, kScreenH * 0.7, kScreenW, kScreenH * 0.3);
        [self.view addSubview:_btnView];
        
        
        //        //同意
        //        UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //        [agreeBtn setImage:[UIImage imageNamed:@"ture_selector"] forState:UIControlStateNormal];
        //        [_btnView addSubview:agreeBtn];
        //        [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(15);
        //            make.left.equalTo(60);
        //            
        //        }];
        //        
        //        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //        [titleBtn setTitle:@"同意《用户服务协议》" forState:UIControlStateNormal];
        //        titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        //        [_btnView addSubview:titleBtn];
        //        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(agreeBtn.mas_right).equalTo(5);
        //            make.centerY.equalTo(agreeBtn.mas_centerY);
        //        }];
        
        
        _selectButton = [[UIButton alloc] init];
        _selectButton.selected = NO;
        [_selectButton setImage:[UIImage imageNamed:@"复选框未选中-0"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"复选框选中"]  forState:UIControlStateSelected];
        [_selectButton setTitle:@"同意《用户服务协议》" forState:UIControlStateNormal];
        [_selectButton setTitleColor:kRGBA(38, 107, 255, 1.0) forState:UIControlStateNormal];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_selectButton addTarget:self action:@selector(selectbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(15);
            make.left.equalTo(60);
            
        }];
        
        
        
        //注册按钮
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = kRGBA(38, 107, 255, 1.0);
        _registerBtn.layer.cornerRadius = 20;
        _registerBtn.layer.masksToBounds = YES;
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn bk_addEventHandler:^(id sender) {
            NSLog(@"点了register");
            
        } forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectButton.mas_bottom).equalTo(15);
            make.centerX.equalTo(0);
            make.height.equalTo(_btnView.mas_height).multipliedBy(0.2);
            make.width.equalTo(_btnView.mas_width).multipliedBy(0.8);
        }];
        
        
    }
    return _btnView;
}




- (UITextField *)tfUserPhone {
    if (!_tfUserPhone) {
        _tfUserPhone = [[UITextField alloc] init];
        [_tfUserPhone setTextColor:[UIColor whiteColor]];
        [_tfUserPhone.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        [_tfUserPhone setPlaceholder:[NSString stringWithFormat:@"请输入手机号"]];
        _tfUserPhone.font = [UIFont systemFontOfSize:14];
        _tfUserPhone.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPhone.textColor = kBlueColor;
        _tfUserPhone.delegate = self;
        [self.view addSubview:_tfUserPhone];
    }
    return _tfUserPhone;
}

- (UITextField *)tfUserCode {
    if (!_tfUserCode) {
        _tfUserCode = [[UITextField alloc] init];
        _tfUserCode.font = [UIFont systemFontOfSize:14];
        [_tfUserCode setTextColor:[UIColor whiteColor]];
        [_tfUserCode.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserCode.placeholder = @"请输入验证码";
        _tfUserCode.textColor = kBlueColor;
        _tfUserCode.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserCode.delegate = self;
        [self.view addSubview:_tfUserCode];
        
    }
    return _tfUserCode;
}

- (UITextField *)tfUserPwd {
    if (!_tfUserPwd) {
        _tfUserPwd = [[UITextField alloc] init];
        _tfUserPwd.font = [UIFont systemFontOfSize:14];
        [_tfUserPwd setTextColor:[UIColor whiteColor]];
        [_tfUserPwd.placeholder setValue:kRGBA(38, 107, 255, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _tfUserPwd.placeholder = @"请输入密码(6-20位,字母和数字组合)";
        _tfUserPwd.textColor = kBlueColor;
        [_tfUserPwd setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        _tfUserPwd.clearButtonMode = UITextFieldViewModeAlways;
        _tfUserPwd.delegate = self;
        
        [self.view addSubview:_tfUserPwd];
        
    }
    return _tfUserPwd;
}









@end
