//
//  HZIntegralViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIntegralViewController.h"
#import "HZIntegralPageVc.h"
#import "HZDayIntegralCell.h"



@interface HZIntegralViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) HZIntegralViewModel *interalVM;

@property(nonatomic) UITableView *tableView;

@end

@implementation HZIntegralViewController

- (instancetype)initWithIntegralType:(IntegralType)integralType {
    if (self = [super init]) {
        self.integralTYpe = integralType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.interalVM getIntegralAFWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
        }];
    }];
    
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [self.interalVM getIntegralAFWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
           if (error) {
               NSLog(@"%@", error);
           } else {
               [_tableView reloadData];
           }
           [_tableView.mj_footer endRefreshing];
           if (!self.interalVM.ingegralModel.list.count) {
               [self.view showWarning:@"没有更多积分信息了"];
           }
       }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interalVM.number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZDayIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"integralCell" forIndexPath:indexPath];
    cell.nameLb.text = [self.interalVM getChangeTypeWithIndex:indexPath.row];
    cell.timeLb.text = [self.interalVM getCreateDateWithIndex:indexPath.row];
    cell.integralNumberLb.text = [NSString stringWithFormat:@"+%ld", [self.interalVM getIntegralNumberWithIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}






#pragma mark -懒加栽 




- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZDayIntegralCell class] forCellReuseIdentifier:@"integralCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (HZIntegralViewModel *)interalVM {
    if (!_interalVM) {
        _interalVM = [[HZIntegralViewModel alloc] initWithIntegralType:self.integralTYpe];
    }
    return _interalVM;
}










@end
