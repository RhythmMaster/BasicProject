//
//  HZWaitRefuseorViewController.m
//  dddd
//
//  Created by tang on 16/11/26.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZWaitRefuseorViewController.h"
#import "JSTextView.h"


@interface HZWaitRefuseorViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) HZCustomLabel *infoLb;

@property(nonatomic) id model;

@property(nonatomic) UITableView *tableView;

@property(nonatomic) NSString *refuseorID;
@property(nonatomic) NSString *refuserReason;

@property(nonatomic) JSTextView *textView;

@property(nonatomic) UIButton *refuseBtnSubmit;

@property(nonatomic,assign) CGFloat offSet;


@end

@implementation HZWaitRefuseorViewController

- (instancetype)initWithOrderId:(NSString *)orderID {
    if (self = [super init]) {
        self.orderID = orderID;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    [self infoLb];
    [self refuseBtnSubmit];
    [HZOrderOperateNetManager getWaitRefuseorOrderWithId:self.orderID completionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        self.model = model;
        NSLog(@"%@", [[[model objectForKey:@"CONTENT"] objectForKey:@"INFO"] objectForKey:@"refuseMsg"]);
        _infoLb.text = [[[model objectForKey:@"CONTENT"] objectForKey:@"INFO"] objectForKey:@"refuseMsg"];
        [UILabel changeLineSpaceForLabel:_infoLb WithSpace:5.0];
        
        [_tableView reloadData];
    }];
   

//    //增加对键盘的监听,当键盘出现或改变
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    //增加对键盘的监听,当键盘退出
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method 
- (void)refuseClick:(UIButton *)sender {
    NSLog(@"提交");
    //归档实现 数据持久化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [defaults objectForKey:@"address"];
    NSString *addressXY = [defaults objectForKey:@"addressXY"];
    NSLog(@"%@, %@", addressXY, address);
    NSLog(@"%@, %@", _refuserReason, _refuseorID);
    
    if (_orderID == nil) {
        [self.view showWarning:@"请选择拒绝原因"];
        return;
    }
    
    if (_refuserReason == nil) {
        [self.view showWarning:@"请选择拒绝原因"];
        return;
    }
    
    [HZOrderOperateNetManager getRefuseOrderOperationWithId:_orderID address:address addressXY:addressXY refuseReason:_refuserReason refuseType:_refuseorID completionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", model);
            [self.view showWarning:[model objectForKey:@"MSG"]];
            
            if ([[model objectForKey:@"MSG"] isEqualToString:@"成功"]) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"拒绝成功!是否返回订单页" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //[self.navigationController popViewControllerAnimated:YES];
                    [self.navigationController popToRootViewControllerAnimated:YES];
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


////当键盘出现或改变时调用
//- (void)keyboardWillShow:(NSNotification *)aNotification
//{
//    //获取键盘的高度
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    CGFloat height = keyboardRect.size.height;
//    NSLog(@"height:%f", height);
//
//    CGFloat refuseBtnSubmitY = _refuseBtnSubmit.y + _refuseBtnSubmit.y;
//    NSLog(@"refuseBtnSubmitY + %f", refuseBtnSubmitY);
//    //registerBtn底部到textFieldY距离
//    
//    CGFloat refuseBtnSubmitH = self.view.y - refuseBtnSubmitY;
//    
//    if (height > refuseBtnSubmitH) {
//        _offSet = height - refuseBtnSubmitH;
//        [self moveUpKeyBoard:_offSet];
//    }
//    
//    
//}
//
////当键退出时调用
//- (void)keyboardWillHide:(NSNotification *)aNotification
//{
//    if (self.view.frame.origin.y < 0) {
//        [self moveDownKeyBoard];
//    }
//    
//    
//}
//
//- (void)moveDownKeyBoard {
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"moveDownKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
//}
//
//- (void)moveUpKeyBoard:(CGFloat)offset{
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"moveUpKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
//    
//}
#pragma mark delete textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//键盘收回触发
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //回归原处
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

#pragma mark delete tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"++++++++++++%ld", ((NSArray *)[[self.model objectForKey:@"CONTENT"] objectForKey:@"LIST"]).count);
    return ((NSArray *)[[self.model objectForKey:@"CONTENT"] objectForKey:@"LIST"]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZRefuseorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.contentLb.text = [[[self.model objectForKey:@"CONTENT"] objectForKey:@"LIST"][indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HZRefuseorListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *cellBackView = [[UIView alloc] initWithFrame:cell.frame];
    UIView *lineView = [UIView new];
    [cellBackView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
        
    }];
    lineView.backgroundColor = kRGBA(234, 234, 234, 1.0);

    cell.selectedBackgroundView = cellBackView;
    cell.listLb.layer.borderColor = [UIColor blueColor].CGColor;
    
    _refuseorID = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    if (indexPath.row == ((NSArray *)[[self.model objectForKey:@"CONTENT"] objectForKey:@"LIST"]).count - 1) {
        _refuserReason = self.textView.text;
    } else {
    _refuserReason = cell.contentLb.text;
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    HZRefuseorListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.listLb.layer.borderColor = kGrayColor.CGColor;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma  mark lazy
- (HZCustomLabel *)infoLb {
    if (!_infoLb) {
        _infoLb = [HZCustomLabel new];
        [self.view addSubview:_infoLb];
        [_infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.top.equalTo(20);
            make.height.equalTo(160);
        }];
        _infoLb.numberOfLines = 0;
        _infoLb.backgroundColor = kRGBA(220, 233, 253, 1.0);
        _infoLb.layer.cornerRadius = 6;
        _infoLb.clipsToBounds = YES;
        _infoLb.font = [UIFont systemFontOfSize:13];
        _infoLb.textInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
    }
    return _infoLb;
}





- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoLb.mas_bottom).equalTo(20);
            make.left.right.equalTo(0);
            make.height.equalTo(120);
        }];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZRefuseorListCell class] forCellReuseIdentifier:@"listCell"];
    }
    return _tableView;
}


- (JSTextView *)textView {
    if (!_textView) {
        _textView = [JSTextView new];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.top.equalTo(self.tableView.mas_bottom).equalTo(10);
            make.height.equalTo(80);
        }];
        _textView.placeholder = @"请输入原因";
        _textView.placeholderFont = [UIFont systemFontOfSize:14];
        _textView.placeholerColor = kRGBA(234, 234, 234, 0.6);
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.cornerRadius = 8;
        _textView.clipsToBounds = YES;
    }
    return _textView;
}
- (UIButton *)refuseBtnSubmit {
    if (!_refuseBtnSubmit) {
        _refuseBtnSubmit = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_refuseBtnSubmit];
        [_refuseBtnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).equalTo(15);
            make.centerX.equalTo(0);
            make.size.equalTo(CGSizeMake(200, 50));
        }];
        _refuseBtnSubmit.backgroundColor = kBlueColor;
        _refuseBtnSubmit.layer.cornerRadius = 25;
        _refuseBtnSubmit.clipsToBounds = YES;
        [_refuseBtnSubmit setTitle:@"确认取消" forState:UIControlStateNormal];
        [_refuseBtnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refuseBtnSubmit.titleLabel.font = [UIFont systemFontOfSize:18];
        _refuseBtnSubmit.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        
        [_refuseBtnSubmit addTarget:self action:@selector(refuseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refuseBtnSubmit;
}

@end
