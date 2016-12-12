//
//  HZMyViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyViewController.h"
#import "HZPersonalCell.h"
#import "HZQueryCell.h"
#import "HZRightLbCell.h"
#import "HZCommentViewController.h"
#import "HZSuggestViewController.h"
#import "HZShareViewController.h"
#import "HZIntegralViewController.h"
#import "HZIntegralPageVc.h"
#import "HZBillViewController.h"
#import "HZTimeTableVC.h"
#import "HZSetVC.h"
#import "HZBalanceVC.h"
#import "HZDataVC.h"
#import "HZDataController.h"
#import "HZPersonalCenterNM.h"

@interface HZMyViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) UITableView *tableView;



@property(nonatomic) HZPersonalCenterModel *personModel;




@property(nonatomic) UIButton *iconImg;

@property(nonatomic) UILabel *nameLb;

@property(nonatomic) UILabel *jobLb;

@property(nonatomic) UIButton *isSign;

@property(nonatomic) UILabel *cashReserveLb;

@property(nonatomic) UILabel *integralReserveLb;

@property(nonatomic) UILabel *serviceHotlineLb;

@end

@implementation HZMyViewController

#pragma mark init
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册观察者,观察签到状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChange1:) name:@"stateChange1" object:nil];
    
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenW, 1);
    self.tableView.tableFooterView = headerView;
    
    //观察数据用
//    [HZPersonalCenterNM getPersonInfo11CompletionHandler:^(id model, NSError *error) {
//        NSLog(@"%@", model);
//    }];
    
    [HZPersonalCenterNM getPersonalCenterCompletionHandler:^(HZPersonalCenterModel *model, NSError *error) {
        self.personModel = model;
        
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%ld", _personModel.integralReserve);
            _nameLb.text = _personModel.name;
            
            if (_personModel.medicPostName.length == 0) {
                _jobLb.text = @"暂无";
            } else {
                _jobLb.text = [NSString stringWithFormat:@"(%@)", _personModel.medicPostName];
            }
            
            _cashReserveLb.text = [NSString stringWithFormat:@"余额: %@", _personModel.cashReserve];
            _integralReserveLb.text = [NSString stringWithFormat:@"%ld", _personModel.integralReserve];
            _serviceHotlineLb.text = [NSString stringWithFormat:@"%ld", _personModel.serviceHotline];
            
            if (_personModel.isSign) {
                [_isSign setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
            } else {
                [_isSign setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
            }
        }
        
        
    }];
    
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [HZPersonalCenterNM getPersonalCenterCompletionHandler:^(HZPersonalCenterModel *model, NSError *error) {
            self.personModel = model;
            
            if (error) {
                NSLog(@"%@", error);
            } else {
                
                NSLog(@"%@", model.msg);
                
                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
            
        }];
        
        
    }];
    
    
    //[_tableView.mj_header beginRefreshing];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark method 


//观察消息
- (void)stateChange1:(id)sender {
    NSLog(@"i am back");
    
    BOOL state = [[sender valueForKey:@"userInfo"] valueForKey:@"STATE"];
    if (state) {
        [_isSign setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
    } else {
        [_isSign setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
    }
}


- (void)clickBtn: (UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    
    if (sender.tag == 1) {
        
        UIBarButtonItem *nullBtn = [[UIBarButtonItem alloc] init];
        nullBtn.title = @"";
        self.hidesBottomBarWhenPushed = YES;
        HZIntegralPageVc *integarlVC = [HZIntegralPageVc new];
        [self.navigationController pushViewController:integarlVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
    if (sender.tag == 2) {
        UIBarButtonItem *nullBtn = [[UIBarButtonItem alloc] init];
        nullBtn.title = @"";
        self.hidesBottomBarWhenPushed = YES;
        
        self.hidesBottomBarWhenPushed = NO;
    }
    if (sender.tag == 3) {
        UIBarButtonItem *nullBtn = [[UIBarButtonItem alloc] init];
        nullBtn.title = @"";
        self.hidesBottomBarWhenPushed = YES;
        HZTimeTableVC *integarlVC = [HZTimeTableVC new];
        [self.navigationController pushViewController:integarlVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)signClick:(UIButton *)sender {
    
    
    
    
    [HZPersonalCenterNM getSignCompletionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            if ([model objectForKey:@"STATE"]) {
                //创建消息对象
                NSNotification *notice = [NSNotification notificationWithName:@"stateChange" object:nil userInfo:@{@"STATE":[model objectForKey:@"STATE"]}];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [self.view showWarning:[model objectForKey:@"MSG"]];
                [_isSign setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
                
            }
        }
    }];
}


#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 4) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HZPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.iconBtn setImage:[UIImage imageNamed:@"minr"] forState:UIControlStateNormal];
        
        //设置
        self.iconImg = cell.iconBtn;
        self.nameLb = cell.nameLb;
        self.jobLb = cell.jobLb;
        self.isSign = cell.signImg;
        
        cell.signImg.tag = indexPath.section;
        
        [cell.signImg addTarget:self action:@selector(signClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_personModel.name.length == 0) {
            cell.nameLb.text = @"暂无";
        } else {
            cell.nameLb.text = _personModel.name;
        }
        if (_personModel.medicPostName.length == 0) {
            cell.jobLb.text = @"暂无";
        } else {
            cell.jobLb.text = [NSString stringWithFormat:@"(%@)", _personModel.medicPostName];
        }
        
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [NSString stringWithFormat:@"余额: %@", _personModel.cashReserve];
            
            self.cashReserveLb = cell.textLabel;
            
            
            return cell;
        } else {
            HZQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            
            
            cell.leftThreeSetBtn.tag = indexPath.row;
            cell.rightThreeSetBtn.tag = indexPath.row + 2;
            if (cell.leftThreeSetBtn.tag == 1) {
                cell.leftThreeSetBtn.iconImg.image = [UIImage imageNamed:@"jifen"];
                cell.leftThreeSetBtn.titleLb.text = @"我的积分";
                cell.leftThreeSetBtn.detailLb.text = [NSString stringWithFormat:@"%ld", _personModel.integralReserve];
                
                self.integralReserveLb = cell.leftThreeSetBtn.detailLb;
                
            } else {
                cell.leftThreeSetBtn.iconImg.image = [UIImage imageNamed:@"jifen"];
                cell.leftThreeSetBtn.titleLb.text = @"我的账单";
                cell.leftThreeSetBtn.detailLb.text = @"查看我的账单";
            }
            if (cell.rightThreeSetBtn.tag == 4) {
                
            } else {
                cell.rightThreeSetBtn.iconImg.image = [UIImage imageNamed:@"jifen"];
                cell.rightThreeSetBtn.titleLb.text = @"我的排班表";
                cell.rightThreeSetBtn.detailLb.text = @"查看我的排班表";
            }
            
            
            
            [cell.leftThreeSetBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightThreeSetBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            return cell;
        }
        
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        HZRightLbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
        cell.rightLb.text = [NSString stringWithFormat:@"%ld", _personModel.serviceHotline];
        cell.textLabel.text = @"客服热线";
        
        self.serviceHotlineLb = cell.rightLb;
        
        cell.imageView.image = [UIImage imageNamed:@"kefu"];
        
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"jzpeople"];
            cell.textLabel.text = @"我的评价";
        } else {
            cell.imageView.image = [UIImage imageNamed:@"setting1"];
            cell.textLabel.text = @"服务设置";
        }
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"yijian"];
        cell.textLabel.text = @"意见反馈";
    }
    if (indexPath.section == 4) {
        cell.imageView.image = [UIImage imageNamed:@"img_aboutus"];
        cell.textLabel.text = @"关于我们";
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.height * 0.18;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return self.view.height * 0.08;
        } else {
            return self.view.height * 0.12;
        }
    }
    
    return self.view.height * 0.08;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        self.hidesBottomBarWhenPushed = YES;
        HZDataVC *dataVC = [HZDataVC new];
        [self.navigationController pushViewController:dataVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.hidesBottomBarWhenPushed = YES;
            HZBalanceVC *balanceVC = [HZBalanceVC new];
            balanceVC.cashchange = [_personModel.cashReserve integerValue];
            [self.navigationController pushViewController:balanceVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.hidesBottomBarWhenPushed = YES;
            HZCommentViewController *commentVC = [HZCommentViewController new];
            [self.navigationController pushViewController:commentVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else {
            
            self.hidesBottomBarWhenPushed = YES;
            HZSetVC *setVC = [HZSetVC new];
            [self.navigationController pushViewController:setVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            self.hidesBottomBarWhenPushed = YES;
            HZSuggestViewController *suggestVC = [HZSuggestViewController new];
            [self.navigationController pushViewController:suggestVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 1) {
            NSInteger tel =  _personModel.serviceHotline;
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleActionSheet)];
            UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:callAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];

            
        }
    }
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[HZRightLbCell class] forCellReuseIdentifier:@"rightCell"];
        [_tableView registerClass:[HZPersonalCell class] forCellReuseIdentifier:@"personalCell"];
        [_tableView registerClass:[HZQueryCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _tableView;
}







@end
