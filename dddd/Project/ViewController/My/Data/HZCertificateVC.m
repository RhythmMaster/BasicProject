//
//  HZCertificateVC.m
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCertificateVC.h"
#import "HZCertificateCell.h"

@interface HZCertificateVC ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) NSInteger addBtnNumber;

@property(nonatomic) UITableView *tableView;

@property(nonatomic) UIButton *editBtn;

@property(nonatomic) BOOL deleteBtnState;


@end

@implementation HZCertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(242, 242, 242, 1.0);
    
    _addBtnNumber = 0;
    _deleteBtnState = NO;
    
    [self tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HZCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"certificateCell" forIndexPath:indexPath];
        [cell.addCertificateBtn addTarget:self action:@selector(addCertificate:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        cell.deleteBtnState = _deleteBtnState;
        cell.addBtnNumber = _addBtnNumber;
        [cell addBtnUI];
        
        
        
        
        
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
        UILabel *label = [UILabel new];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        label.text = @"示例";
        label.font = [UIFont systemFontOfSize:18];
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    UILabel *label = [UILabel new];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(0);
    }];
    label.text = @"证书";
    label.font = [UIFont systemFontOfSize:18];
    _editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(0);
        
    }];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _editBtn.backgroundColor = kBlueColor;
    if (_deleteBtnState) {
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [_editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _editBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    _editBtn.layer.cornerRadius = 12;
    _editBtn.clipsToBounds = YES;
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return 300;
    } else {
        
        CGFloat height = 130 + _addBtnNumber * 170;
        
        
        return height;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

#pragma mark method
- (void)editClick:(UIButton *)sender {
    NSLog(@"%d", _deleteBtnState);
    _deleteBtnState = !_deleteBtnState;
    NSLog(@"%d", _deleteBtnState);
    [self.tableView reloadData];
}

- (void)addCertificate:(UIButton *)sender {
    NSLog(@"点了");
    
    _addBtnNumber ++;
    
    [self.tableView reloadData];
    
    NSLog(@"%ld", _addBtnNumber);
    
}

- (void)deleteClick:(UIButton *)sender {
    
    _addBtnNumber --;
    if (_addBtnNumber <= 0) {
        _addBtnNumber = 0;
    }
    [self.tableView reloadData];
    
}




#pragma mark -懒加栽


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZCertificateCell class] forCellReuseIdentifier:@"certificateCell"];
    }
    return _tableView;
}









@end
