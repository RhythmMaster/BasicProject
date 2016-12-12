//
//  HZOrderViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderViewController.h"
#import "HZPatientCell.h"
#import "HZStatusCell.h"
#import "HZIsOrderCell.h"
#import "HZOrderNetManager.h"
#import "HZOrderViewModel.h"

#import "HZEmptyCell.h"

#import "HZOrderDetailVC.h"


#import "HZWaitRefuseorViewController.h"
#import "HZWaitcancelorderViewController.h"
#import "HZToEvaluateOrderViewController.h"

@interface HZOrderViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) UITableView *tableView;
@property(nonatomic) HZOrderViewModel *orderViewModel;
@property(nonatomic) NSInteger orderStatusCode;



//地图定位

@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressXY;
@end

@implementation HZOrderViewController

- (instancetype)initWithOrderType:(OrderType)type {
    if (self = [super init]) {
        
        _orderType = type;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    [self getCurrentLocation];
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self.orderViewModel getContentWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            
            if (error) {
                NSLog(@"%@", error);
            } else {
                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
            
        }];
        
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    UIView *headerView = [UIView new];
    headerView.size = CGSizeMake(kScreenW, 1);
    _tableView.tableHeaderView = headerView;
    
    
    
    
    
    
    
    //线左靠边
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method 
- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [self.view showWarning:@"定位失败"];
        }else{
            //[self.view showWarning:@"定位成功"];
            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            self.address = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
        }
    } onViewController:self];
    
}

#pragma mark method call
- (void)callClick:(UIButton *)sender {
    NSLog(@"打电话 : %ld", [_orderViewModel getTelWithRow:sender.tag - 700]);
    NSInteger tel = [_orderViewModel getTelWithRow:sender.tag - 700];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:callAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark method  接单,拒单
- (void)leftBtnClick:(UIButton *)sender {
    
    NSLog(@"%ld", [_orderViewModel getOrderStatusCodeWithRow:sender.tag - 200]);
   
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 200] == 2) {
        NSLog(@"拒绝接单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否拒单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认拒单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitRefuseorViewController *waitRefuseorVC = [[HZWaitRefuseorViewController alloc] initWithOrderId:[_orderViewModel getIdWithRow:sender.tag - 200]];
            [self.navigationController pushViewController:waitRefuseorVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 200] == 3) {
        NSLog(@"取消订单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitcancelorderViewController *waitCancelVC = [[HZWaitcancelorderViewController alloc] initWithOrderId:[_orderViewModel getIdWithRow:sender.tag - 200]];
            [self.navigationController pushViewController:waitCancelVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 200] == 6) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:[_orderViewModel getIdWithRow:sender.tag - 200]];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
}
- (void)rightBtnClick:(UIButton *)sender {
    NSLog(@"%ld", [_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100]);
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 2) {
        NSLog(@"确认接单");
        //[_orderViewModel getIdWithRow:sender.tag - 100]
        NSLog(@"%@, %@, %@", _address, _addressXY, [_orderViewModel getIdWithRow:sender.tag - 100]);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            
        
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否接单" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"接单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getOrderOperationWithId:[_orderViewModel getIdWithRow:sender.tag - 100] address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error);
                    } else {
                        [_tableView.mj_header beginRefreshing];
                        [self.view showWarning:[model objectForKey:@"MSG"]];
                    }
                }];

                
            }];
                
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
            }];
                
            [alertVC addAction:sureAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
                
            
        }
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 3) {
        NSLog(@"开始服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, [_orderViewModel getIdWithRow:sender.tag - 100]);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否开始服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"开始服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getStartServiceOrderWithId:[_orderViewModel getIdWithRow:sender.tag - 100] address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error);
                    } else {
                        [_tableView.mj_header beginRefreshing];
                        [self.view showWarning:[model objectForKey:@"MSG"]];
                    }
                }];

                
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertVC addAction:sureAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
        }
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 4) {
        NSLog(@"完成服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, [_orderViewModel getIdWithRow:sender.tag - 100]);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否完成服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"完成服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getFinishOrderWithId:[_orderViewModel getIdWithRow:sender.tag - 100] address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error);
                    } else {
                        [_tableView.mj_header beginRefreshing];
                        [self.view showWarning:[model objectForKey:@"MSG"]];
                    }
                }];
                
                
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertVC addAction:sureAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
        }

        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 5) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:[_orderViewModel getIdWithRow:sender.tag - 100]];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 6) {
        NSLog(@"删除订单");
        
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:[_orderViewModel getIdWithRow:sender.tag - 100] completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    [_tableView.mj_header beginRefreshing];
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                }
            }];

            
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVC addAction:sureAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 7) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:[_orderViewModel getIdWithRow:sender.tag - 100] completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    [_tableView.mj_header beginRefreshing];
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                }
            }];
            
            
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVC addAction:sureAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    if ([_orderViewModel getOrderStatusCodeWithRow:sender.tag - 100] == 8) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:[_orderViewModel getIdWithRow:sender.tag - 100] completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    [_tableView.mj_header beginRefreshing];
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                }
            }];
            
            
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVC addAction:sureAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
}

#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%ld", [self.orderViewModel rowNumber]);
    if ([self.orderViewModel rowNumber]) {
        return [self.orderViewModel rowNumber];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.orderViewModel rowNumber]) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.orderViewModel rowNumber]) {
        
        
        if (indexPath.row == 0) {
            HZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.statusLb.text = [NSString stringWithFormat:@"%@", [_orderViewModel getOrderStatusNameWithRow:indexPath.section]];
            cell.diseaseLb.text = [NSString stringWithFormat:@"%@(%@)", [_orderViewModel getItemNameWithRow:indexPath.section], [_orderViewModel getItemClassifyNameWithRow:indexPath.section]];
            
            
            return cell;
        } else if (indexPath.row == 1) {
            HZPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
            
            cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", [_orderViewModel getPersonNameWithRow:indexPath.section], [_orderViewModel getSexWithRow:indexPath.section], [_orderViewModel getAgeWithRow:indexPath.section]];
            cell.projectLb.text = [NSString stringWithFormat:@"服务项目: %@", [_orderViewModel getOrderServicesWithRow:indexPath.section]];
            cell.timeLb.text = [NSString stringWithFormat:@"服务时间: %@", [_orderViewModel getAppointmentTimeWithRow:indexPath.section]];
            cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", [_orderViewModel getNameWithRow:indexPath.section], [_orderViewModel getTelWithRow:indexPath.section]];
            cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", [_orderViewModel getAddressInfoWithRow:indexPath.section]];
            cell.orderTimeLb.text = [NSString stringWithFormat:@"下订单时间: %@", [_orderViewModel getCreateTimeWithRow:indexPath.section]];
            cell.callBtn.tag = indexPath.section + 700;
            [cell.callBtn addTarget:self action:@selector(callClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        } else {
            HZIsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.incomeNumberLb.text = [NSString stringWithFormat:@"¥ %@", [_orderViewModel getOrderRevenueWithRow:indexPath.section]];
            self.orderStatusCode = [_orderViewModel getOrderStatusCodeWithRow:indexPath.section];
            cell.isServiceBtn.tag = indexPath.section + 100 ;
            cell.cancleBtn.tag = indexPath.section + 200;
            
            
            [cell.cancleBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.isServiceBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 2) {
                [cell.cancleBtn setTitle:@"拒绝接单" forState:UIControlStateNormal];
                [cell.cancleBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.cancleBtn.hidden = NO;
                [cell.isServiceBtn setTitle:@"确认接单" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
                
                
            } else if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 3) {
                [cell.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                cell.cancleBtn.hidden = NO;
                [cell.isServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
            }
            else if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 4) {
                cell.cancleBtn.hidden = YES;
                [cell.isServiceBtn setTitle:@"完成服务" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
            }
            else if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 5) {
                cell.cancleBtn.hidden = YES;
                [cell.isServiceBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
            }
            else if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 6) {
                [cell.cancleBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                cell.cancleBtn.hidden = NO;
                [cell.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
                
            }
            else if ([_orderViewModel getOrderStatusCodeWithRow:indexPath.section] == 7) {
                cell.cancleBtn.hidden = YES;
                [cell.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
                
            }
            else {
                cell.cancleBtn.hidden = YES;
                [cell.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                cell.isServiceBtn.hidden = NO;
                
            }
            
            
            
            return cell;
        }
    }
    
    HZEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderViewModel.rowNumber) {
        if (indexPath.row == 1) {
            return 120;
        } else {
            return 40;
        }
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        
            HZOrderDetailVC *dataVC = [[HZOrderDetailVC alloc] initWithID:[self.orderViewModel getIdWithRow:indexPath.section]];
            NSLog(@"aaaaaaaaaaa%@", [self.orderViewModel getIdWithRow:indexPath.section]);
            dataVC.ID = [self.orderViewModel getIdWithRow:indexPath.section];
            [self.navigationController pushViewController:dataVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        
       
        
    }
}




//让线左靠边
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
        [_tableView registerClass:[HZStatusCell class] forCellReuseIdentifier:@"statusCell"];
        [_tableView registerClass:[HZPatientCell class] forCellReuseIdentifier:@"patientCell"];
        [_tableView registerClass:[HZIsOrderCell class] forCellReuseIdentifier:@"orderCell"];
        [_tableView registerClass:[HZEmptyCell class] forCellReuseIdentifier:@"emptyCell"];
    }
    return _tableView;
}

- (HZOrderViewModel *)orderViewModel {
    if (!_orderViewModel) {
        _orderViewModel = [[HZOrderViewModel alloc] initWithOrderType:self.orderType];
    }
    return _orderViewModel;
}



@end
