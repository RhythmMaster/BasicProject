//
//  HZIDCardVc.m
//  dddd
//
//  Created by NSX443 on 16/11/14.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIDCardVc.h"
#import "HZIDCardCell.h"

@interface HZIDCardVc ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) UITableView *tableView;
@end

@implementation HZIDCardVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"身份证上传";
    
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
        HZIDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"certificateCell" forIndexPath:indexPath];
        
        
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
    label.text = @"身份证";
    label.font = [UIFont systemFontOfSize:18];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [view addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(kScreenW * 0.6, 40));
        }];
        submitBtn.backgroundColor = kBlueColor;
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitBtn.layer.cornerRadius = 20;
        submitBtn.clipsToBounds = YES;
        return view;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return 300;
    } else {
        
        CGFloat height = 2 * 170 + 15;
        
        
        return height;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 60;
    }
    return 1;
}



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
        [_tableView registerClass:[HZIDCardCell class] forCellReuseIdentifier:@"certificateCell"];
    }
    return _tableView;
}

@end
