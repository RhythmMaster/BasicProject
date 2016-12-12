//
//  HZSuggestViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZSuggestViewController.h"

@interface HZSuggestViewController ()<UITextViewDelegate>


@property(nonatomic) JSTextView *textView;

@property(nonatomic) UIButton *submitBtn;

@end

@implementation HZSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self textView];
    [self submitBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark delete


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark method
- (void)submitClick: (UIButton *)sender {
    NSLog(@"qqqq%@", _textView.text);
    if (!_textView.text.length) {
        [self.view showWarning:@"不能为空!请填写您的意见"];
        return;
    }
    [self.view showBusyHUD];
    [HZSuggestNetManager getSuggestWithFeedbackReason:_textView.text completionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", model);
            [self.view showWarning:[model objectForKey:@"MSG"]];
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"意见提交%@, 是否返回个人中心", [model objectForKey:@"MSG"]] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:callAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}



#pragma mark -懒加栽

- (UITextView *)textView {
    if (!_textView) {
        _textView = [JSTextView new];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.top.equalTo(30);
            make.height.equalTo(150);
        }];
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.cornerRadius = 8;
        _textView.clipsToBounds = YES;
        _textView.placeholder = @"请输入您的反馈意见,我们将不断改进。。。";
        _textView.placeholderFont = [UIFont systemFontOfSize:14];
        _textView.placeholerColor = kRGBA(205, 205, 205, 0.7);
        
    }
    
    return _textView;
}


- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(-70);
            make.size.equalTo(CGSizeMake(250, 40));
        }];
        [_submitBtn setTitle:@"提交意见" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = kRGBA(41, 105, 238, 1.0);
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.clipsToBounds = YES;
        
        [_submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _submitBtn;
}










@end
