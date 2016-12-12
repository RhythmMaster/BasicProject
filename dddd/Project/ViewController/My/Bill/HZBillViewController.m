//
//  HZBillViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZBillViewController.h"
#import "HZBillNumberView.h"
#import "HZBillQueryBtn.h"

@interface HZBillViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) UIView *topBigView;

@property(nonatomic) HZBillNumberView *leftView;

@property(nonatomic) HZBillNumberView *rightView;

@property(nonatomic) UITableView *tableView;


@property(nonatomic) UIView *headerView;

@property(nonatomic) UIButton *timeBtn;



@end

@implementation HZBillViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self rightView];
    [self tableView];
    
    
    //去空白线
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.preservesSuperviewLayoutMargins = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"billCell" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    view.frame = CGRectMake(0, 0, kScreenW, 0);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}







#pragma mark -懒加栽
- (UIView *)topBigView {
    if (!_topBigView) {
        _topBigView = [UIView new];
        [self.view addSubview:_topBigView];
        [_topBigView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(60);
        }];
        _topBigView.backgroundColor = [UIColor whiteColor];
        
        
        
        UIView *lineView = [UIView new];
        [_topBigView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.width.equalTo(1);
            make.height.equalTo(50);
        }];
        lineView.backgroundColor = kGrayColor;
        
        
    }
    
    return _topBigView;
}


- (HZBillNumberView *)leftView {
    if (!_leftView) {
        _leftView = [HZBillNumberView new];
        [self.topBigView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(kScreenW * 0.5);
        }];
        _leftView.incomeNumberLb.text = @"¥1555";
        _leftView.nameLb.text = @"上月收入";
    }
    return _leftView;
}


- (HZBillNumberView *)rightView {
    if (!_rightView) {
        _rightView = [HZBillNumberView new];
        [self.topBigView addSubview:_rightView];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(0);
            make.left.equalTo(self.leftView.mas_right);
        }];
        _rightView.incomeNumberLb.text = @"¥1555";
        _rightView.nameLb.text = @"累计总收入";
    }
    return _rightView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.topBigView.mas_bottom);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"billCell"];
    }
    return _tableView;
}


- (UIView *)headerView {
    if (!_headerView) {
        
    }
    return _headerView;
}



@end
