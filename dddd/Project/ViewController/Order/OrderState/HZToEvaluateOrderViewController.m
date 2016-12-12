//
//  HZToEvaluateOrderViewController.m
//  dddd
//
//  Created by tang on 16/11/28.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZToEvaluateOrderViewController.h"
#import "JSTextView.h"

@interface HZToEvaluateOrderViewController ()<UITextViewDelegate>

@property(nonatomic) UIView *topView;

@property(nonatomic) UIImageView *headImg;
@property(nonatomic) UILabel *nameLb;
@property(nonatomic) UILabel *addressLb;
@property(nonatomic) UILabel *gradeLb;
@property(nonatomic) ZJD_StarEvaluateView *starView;

@property(nonatomic) JSTextView *textView;

@property(nonatomic) NSInteger starIndex;


@property(nonatomic) UIButton *canelBtn;
@property(nonatomic) UIButton *submitBtn;


@end

@implementation HZToEvaluateOrderViewController

- (instancetype)initWithOrderId:(NSString *)orderID {
    if (self = [super init]) {
        self.orderID = orderID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBA(234, 234, 234, 1.0);
    
    [HZOrderOperateNetManager getToEvaluateOrderWithId:_orderID completionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        _nameLb.text = [[model objectForKey:@"CONTENT"] objectForKey:@"name"];
        _addressLb.text = [[model objectForKey:@"CONTENT"] objectForKey:@"addressInfo"];
    }];
    
    [self starView];
    [self gradeLb];
    [self addressLb];
    [self textView];
    [self canelBtn];
    [self submitBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete textView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)cancelClick:(UIButton *)sender {
    NSLog(@"取消");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitGradeClick:(UIButton *)sender {
    NSLog(@"提交");
    NSLog(@"%@, %@", _textView.text, [NSString stringWithFormat:@"%ld", _starIndex]);
    if (_textView.text == nil) {
        [self.view showWarning:@"请填写对患者的评价"];
        return;
    }
    [self.view showBusyHUD];
    [HZOrderOperateNetManager getEvaluateOrderWithId:_orderID synthesizeScore:[NSString stringWithFormat:@"%ld", _starIndex] evaluateReason:_textView.text completionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", [model objectForKey:@"MSG"]);
            [self.view showWarning:[model objectForKey:@"MSG"]];
            if ([[model objectForKey:@"MSG"] isEqualToString:@"成功"]) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"评价成功!是否返回订单页" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    //[self.navigationController popViewControllerAnimated:YES];
                }];
                           
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];

                [alertVC addAction:sureAction];
                [alertVC addAction:cancelAction];
                [self presentViewController:alertVC animated:YES completion:nil];
            
        }
        }
    }];
   
}

#pragma  mark lazy
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(140);
        }];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        [self.topView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(10);
            make.size.equalTo(CGSizeMake(80, 80));
        }];
        _headImg.backgroundColor = [UIColor orangeColor];
        _headImg.layer.cornerRadius = 40;
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}
- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        [self.topView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).equalTo(10);
            make.top.equalTo(12);
        }];
        _nameLb.font = [UIFont systemFontOfSize:22];
        _nameLb.textColor = kBlueColor;
    }
    return _nameLb;
}
- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb = [UILabel new];
        [self.topView addSubview:_addressLb];
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLb.mas_left).equalTo(0);
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(10);
        }];
        _addressLb.font = [UIFont systemFontOfSize:16];
        _addressLb.textColor = [UIColor lightGrayColor];
    }
    return _addressLb;
}

- (UILabel *)gradeLb {
    if (!_gradeLb) {
        _gradeLb = [UILabel new];
        [self.topView addSubview:_gradeLb];
        [_gradeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headImg.mas_centerX);
            make.top.equalTo(self.headImg.mas_bottom).equalTo(10);
        }];
        _gradeLb.font = [UIFont systemFontOfSize:22];
        _gradeLb.text = @"评分:";
       
    }
    return _gradeLb;
}
- (ZJD_StarEvaluateView *)starView {
    if (!_starView) {
        CGFloat starWidth = 25.f;
        CGFloat space = 5.f;
        _starView = [[ZJD_StarEvaluateView alloc] initWithFrame:CGRectMake(90, 90, 150, 44) starIndex:1 starWidth:starWidth space:space defaultImage:nil lightImage:nil isCanTap:YES];
        [self.topView addSubview:_starView];
        
        _starView.starEvaluateBlock = ^(ZJD_StarEvaluateView * starView, NSInteger starIndex){
  
            _starIndex = starIndex;
            
        };
    }
    return _starView;
}

- (JSTextView *)textView {
    if (!_textView) {
        _textView = [JSTextView new];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(self.topView.mas_bottom).equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(300);
        }];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.placeholder = @"写下您的服务体会,评价超过20个字有机会获得积分~~";
        _textView.layer.cornerRadius = 8;
        _textView.clipsToBounds = YES;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = kGrayColor.CGColor;
    }
    return _textView;
}

- (UIButton *)canelBtn {
    if (!_canelBtn) {
        _canelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_canelBtn];
        [_canelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).equalTo(10);
            make.left.equalTo(40);
            make.size.equalTo(CGSizeMake(150, 50));
        }];
        _canelBtn.backgroundColor = [UIColor grayColor];
        _canelBtn.layer.cornerRadius = 25;
        _canelBtn.clipsToBounds = YES;
        [_canelBtn setTitle:@"取消评价" forState:UIControlStateNormal];
        [_canelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _canelBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_canelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _canelBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).equalTo(10);
            make.right.equalTo(-40);
            make.size.equalTo(CGSizeMake(150, 50));
        }];
        _submitBtn.backgroundColor = [UIColor blueColor];
        _submitBtn.layer.cornerRadius = 25;
        _submitBtn.clipsToBounds = YES;
        [_submitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_submitBtn addTarget:self action:@selector(submitGradeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
