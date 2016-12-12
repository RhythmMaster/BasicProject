//
//  HZBalanceVC.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZBalanceVC.h"
#import "HZListVC.h"
#import "HZWithdrawVC.h"
#import "HZRechargeVC.h"

@interface HZBalanceVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UIView *bigView;

@property(nonatomic) UILabel *balanceLb;


@property(nonatomic) UIButton *markBtn;

@property(nonatomic) UILabel *numberLb;

@property(nonatomic) UITableView *tableView;





@end

@implementation HZBalanceVC


- (instancetype)init {
    if (self = [super init]) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
        
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.title = @"余额";
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self numberLb];
    [self tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method
- (void)rightClick:(UIBarButtonItem *)sender {
    self.hidesBottomBarWhenPushed = YES;
    HZListVC *listVC = [HZListVC new];
    [self.navigationController pushViewController:listVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}




#pragma mark delete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"moenye"];
    cell.textLabel.text = @"提现";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIBarButtonItem *backIetm = [[UIBarButtonItem alloc] init];
        backIetm.title = @"取消";
        self.navigationItem.backBarButtonItem = backIetm;
        self.hidesBottomBarWhenPushed = YES;
        HZWithdrawVC *balanceVC = [HZWithdrawVC new];
        [self.navigationController pushViewController:balanceVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        UIBarButtonItem *backIetm = [[UIBarButtonItem alloc] init];
        backIetm.title = @"取消";
        self.navigationItem.backBarButtonItem = backIetm;
        self.hidesBottomBarWhenPushed = YES;
        HZRechargeVC *balanceVC = [HZRechargeVC new];
        [self.navigationController pushViewController:balanceVC animated:YES];
    }
}



#pragma mark -懒加栽
- (UIView *)bigView {
    if (!_bigView) {
        _bigView = [UIView new];
        [self.view addSubview:_bigView];
        [_bigView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(200);
        }];
        _bigView.backgroundColor = kRGBA(38, 107, 255, 2.0);
    }
    return _bigView;
}


- (UILabel *)balanceLb {
    if (!_balanceLb) {
        _balanceLb = [UILabel new];
        [self.bigView addSubview:_balanceLb];
        [_balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.top.equalTo(20);
            
        }];
        _balanceLb.font = [UIFont systemFontOfSize:17];
        _balanceLb.textColor = kRGBA(198, 217, 243, 1.0);
        _balanceLb.text = @"余额账户(元)";
    }
    return _balanceLb;
}


- (UIButton *)markBtn {
    if (!_markBtn) {
        _markBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.bigView addSubview:_markBtn];
        [_markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-8);
            make.top.equalTo(self.balanceLb.mas_top);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        _markBtn.layer.cornerRadius = 10;
        _markBtn.clipsToBounds = YES;
        _markBtn.backgroundColor = kRGBA(198, 217, 243, 1.0);
        [_markBtn setTitle:@"?" forState:UIControlStateNormal];
        [_markBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _markBtn;
}


- (UILabel *)numberLb {
    if (!_numberLb) {
        _numberLb = [UILabel new];
        [self.bigView addSubview:_numberLb];
        [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(18);
            make.top.equalTo(self.markBtn.mas_bottom).equalTo(22);
        }];
        _numberLb.textColor = [UIColor whiteColor];
        _numberLb.font = [UIFont systemFontOfSize:60];
        _numberLb.text = [NSString stringWithFormat:@"%.2f", _cashchange];
    }
    return _numberLb;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.bigView.mas_bottom);
            make.height.equalTo(44);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}



@end
