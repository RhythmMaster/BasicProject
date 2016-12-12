//
//  HZOrderDetailVC.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderDetailVC.h"

#import "HZWaitRefuseorViewController.h"
#import "HZWaitcancelorderViewController.h"
#import "HZToEvaluateOrderViewController.h"

#import "HZTextViewCell.h"

@interface HZOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView *tableView;
@property(nonatomic) HZOrderDetailViewModel *orderDetailVM;


@property(nonatomic) UIView *bottomView;
@property(nonatomic) UIButton *cancleBtn;
@property(nonatomic) UIButton *isServiceBtn;

@property(nonatomic) NSInteger orderStatusCode;

//地图定位

@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressXY;



@property(nonatomic) NSString *hourStr;
@property(nonatomic) NSString *minuteStr;
@property(nonatomic) NSString *secodnStr;


@end

@implementation HZOrderDetailVC

- (id)initWithID:(NSString *)ID {
    if (self = [super init]) {
        _ID = ID;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBA(235, 235, 241, 1.0);
    [self tableView];
    
    
    [HZOrderDetailNetManager getOrderDetatil11111WithId:_ID completionHandler:^(id model, NSError *error) {
        
        NSLog(@"%@", model);
        
    }];
    
    
    NSLog(@"=========%@", _ID);
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.orderDetailVM getModelsWithID:_ID completionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [_tableView reloadData];
                
                
                self.orderStatusCode = _orderDetailVM.orderModel.orderStatus;
                NSLog(@"--------1:%ld", self.orderDetailVM.orderModel.orderStatus);
                if (_orderStatusCode == 2) {
                    self.cancleBtn.hidden = NO;
                    self.isServiceBtn.hidden = NO;
                    [self.cancleBtn setTitle:@"拒绝接单" forState:UIControlStateNormal];
                    [self.isServiceBtn setTitle:@"确认接单" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 3) {
                    self.cancleBtn.hidden = NO;
                    self.isServiceBtn.hidden = NO;
                    [self.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [self.isServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 4) {
                    self.cancleBtn.hidden = YES;
                    self.isServiceBtn.hidden = NO;
                    [self.isServiceBtn setTitle:@"完成服务" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 5) {
                    self.cancleBtn.hidden = YES;
                    self.isServiceBtn.hidden = NO;
                    [self.isServiceBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 6) {
                    self.cancleBtn.hidden = NO;
                    self.isServiceBtn.hidden = NO;
                    [self.cancleBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                    [self.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 7) {
                    self.cancleBtn.hidden = YES;
                    self.isServiceBtn.hidden = NO;
                    [self.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                if (_orderStatusCode == 8) {
                    self.cancleBtn.hidden = YES;
                    self.isServiceBtn.hidden = NO;
                    [self.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                
                
//                NSArray *timeArr = [_orderDetailVM.orderModel.countDown componentsSeparatedByString:@":"];
//               
//                _hourStr = timeArr[0];
//                _minuteStr = timeArr[1];
//                _secodnStr = timeArr[2];
//                
                
                
                [_tableView.mj_header endRefreshing];
                
                
                
                
            }
        }];
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    //归档实现 数据持久化
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _address = [defaults objectForKey:@"address"];
    _addressXY = [defaults objectForKey:@"addressXY"];
    
    //让线左靠边
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
#pragma mark method call
- (void)detailCallClick:(UIButton *)sender {
    NSLog(@"打电话 : %ld", _orderDetailVM.orderModel.tel);
    NSInteger tel = _orderDetailVM.orderModel.tel;
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
- (void)detailLeftBtnClick:(UIButton *)sender {
    
    NSLog(@"%ld", _orderDetailVM.orderModel.orderStatus);
    
    if (_orderDetailVM.orderModel.orderStatus == 2) {
        NSLog(@"拒绝接单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否拒单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认拒单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitRefuseorViewController *waitRefuseorVC = [[HZWaitRefuseorViewController alloc] initWithOrderId:_ID];
            [self.navigationController pushViewController:waitRefuseorVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 3) {
        NSLog(@"取消订单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitcancelorderViewController *waitCancelVC = [[HZWaitcancelorderViewController alloc] initWithOrderId:_ID];
            [self.navigationController pushViewController:waitCancelVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 6) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:_ID];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
}
- (void)detailRightBtnClick:(UIButton *)sender {
    NSLog(@"%ld", _orderDetailVM.orderModel.orderStatus);
    if (_orderDetailVM.orderModel.orderStatus == 2) {
        NSLog(@"确认接单");
        //[_orderViewModel getIdWithRow:sender.tag - 100]
        NSLog(@"%@, %@, %@", _address, _addressXY, _ID);
        
            
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否接单" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"接单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getOrderOperationWithId:_ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
            
            
        
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 3) {
        NSLog(@"开始服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, _ID);
        
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否开始服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"开始服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getStartServiceOrderWithId:_ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
            
            
        
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 4) {
        NSLog(@"完成服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, _ID);
        
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否完成服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"完成服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getFinishOrderWithId:_ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
            
            
        
        
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 5) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:_ID];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
    if (_orderDetailVM.orderModel.orderStatus == 6) {
        NSLog(@"删除订单");
        
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_ID completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                    if ([model objectForKey:@"STATE"]) {
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功!请返回首页" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                        
                        
                        [alertVC addAction:sureAction];
                       
                        [self presentViewController:alertVC animated:YES completion:nil];
                        
                    }
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
    if (_orderDetailVM.orderModel.orderStatus == 7) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_ID completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                    
                    if ([model objectForKey:@"STATE"]) {
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功!请返回首页" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                        
                        
                        [alertVC addAction:sureAction];
                        
                        [self presentViewController:alertVC animated:YES completion:nil];
                        
                    }
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
    if (_orderDetailVM.orderModel.orderStatus == 8) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_ID completionHandler:^(id model, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    //普通进入数据自动更新
                    
                    [self.view showWarning:[model objectForKey:@"MSG"]];
                    
                    if ([model objectForKey:@"STATE"]) {
                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功!请返回首页" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                        
                        
                        [alertVC addAction:sureAction];
                        
                        [self presentViewController:alertVC animated:YES completion:nil];
                        
                    }
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
    if (_orderDetailVM.orderModel.orderStatus == 3) {
        return 5;
    }
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_orderDetailVM.orderModel.orderStatus == 2) {
        if (section == 3 || section == 5) {
            return 3;
        }
        if (section == 4) {
            return 2;
        }
        return 1;
    } else if (_orderDetailVM.orderModel.orderStatus == 3) {
        if (section == 2 || section == 4) {
            return 3;
        }
        if (section == 3) {
            return 2;
        }
        return 1;
    } else if (_orderDetailVM.orderModel.orderStatus == 4 || _orderDetailVM.orderModel.orderStatus == 5 || _orderDetailVM.orderModel.orderStatus == 6 ) {
        if (section == 3 || section == 5) {
            return 3;
        }
        if (section == 4) {
            return 2;
        }
        return 1;
    } else {
        if (section == 3 || section == 5) {
            return 3;
        }
        if (section == 4) {
            return 2;
        }
        return 1;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_orderDetailVM.orderModel.orderStatus == 2) {
        
        
        if (indexPath.section == 0) {
            HZCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countDownCell" forIndexPath:indexPath];
            cell.cancelReasonLb.hidden = YES;
            cell.countDownLb.hidden = NO;
            cell.countDownLb.hour = 1;
            cell.countDownLb.minute = 1;
            cell.countDownLb.second = 20;
            
            
            return cell;
        }
        
        if (indexPath.section == 1) {
            HZIndexOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell" forIndexPath:indexPath];
            cell.leftView.topLb.text = self.orderDetailVM.orderModel.orderRevenue;
            cell.rightView.topLb.text = self.orderDetailVM.orderModel.appointmentTime;
            cell.rightView.bottomLb.text = @"预约服务时间";
            return cell;
        }
        if (indexPath.section == 2) {
            HZPatientDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.sex, self.orderDetailVM.orderModel.age];
            cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
            cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
            [cell.callBtn addTarget:self action:@selector(detailCallClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            
            cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
            cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
            cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
            NSLog(@"!!!!!!!!!!!!!!!%@", self.orderDetailVM.orderModel.desc);
            cell.describeLb.text = self.orderDetailVM.orderModel.desc;
            NSLog(@"!!!!!!!!!!!!!!!%@", cell.describeLb.text);
            //设置行距
            if (cell.describeLb.text.length > 0) {
                cell.describeLb.hidden = NO;
                [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
            } else {
                cell.describeLb.hidden = YES;
            }
            
            return cell;
        }
        
        if (indexPath.section == 3) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"收入详情";
                [cell.rightBtn setTitle:@"管理细则" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:3];
                }
                //测试
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"项目服务费: ¥%@", self.orderDetailVM.orderModel.platformServicePrice], [NSString stringWithFormat:@"其他材料费: ¥%ld", self.orderDetailVM.orderModel.itemServiceCase], [NSString stringWithFormat:@"平台技术费: ¥%@", self.orderDetailVM.orderModel.itemCase]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZRightIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
                cell.incomeNumberLb.text = self.orderDetailVM.orderModel.orderRevenue;
                return cell;
            }
            
            
        }
        
        if (indexPath.section == 4) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单信息";
                [cell.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:7];
                }
                cell.count = 2;
                NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime]];
                for (int i = 0; i < 2; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            
        }
        
        
        if (indexPath.section == 5) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单详情";
                cell.rightBtn.hidden = YES;
                return cell;
            }
            if (indexPath.row == 1) {
                HZServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
                NSLog(@"%ld", self.orderDetailVM.numberRow);
                for (int i = 0; i < self.orderDetailVM.numberRow; i++) {
                    cell.labelArr[i].titleLb.text = self.orderDetailVM.listModel[i].name;
                    cell.labelArr[i].unitCostLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].price];
                    cell.labelArr[i].numberLb.text = [NSString stringWithFormat:@"x%ld", self.orderDetailVM.listModel[i].quantity];
                    cell.labelArr[i].totalLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].smallCount];
                    cell.labelArr[i].hidden = NO;
                }
                for (NSInteger i = self.orderDetailVM.numberRow; i < 10; i++) {
                    cell.labelArr[i].hidden = YES;
                }
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalCell" forIndexPath:indexPath];
                cell.leftLb.text = [NSString stringWithFormat:@"合计: ¥%.2f", (CGFloat)self.orderDetailVM.orderModel.orderMoney];
                cell.leftLb.text = [NSString stringWithFormat:@"实付: ¥%@", self.orderDetailVM.orderModel.payMoney];
                return cell;
            }
            
            
        }
        
    }
    
    if (_orderDetailVM.orderModel.orderStatus == 3) {
        
        if (indexPath.section == 0) {
            HZIndexOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell" forIndexPath:indexPath];
            cell.leftView.topLb.text = self.orderDetailVM.orderModel.orderRevenue;
            cell.rightView.topLb.text = self.orderDetailVM.orderModel.appointmentTime;
            cell.rightView.bottomLb.text = @"预约服务时间";
            return cell;
        }
        if (indexPath.section == 1) {
            HZPatientDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.sex, self.orderDetailVM.orderModel.age];
            cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
            cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
            [cell.callBtn addTarget:self action:@selector(detailCallClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            
            cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
            cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
            cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
            NSLog(@"!!!!!!!!!!!!!!!%@", self.orderDetailVM.orderModel.desc);
            cell.describeLb.text = self.orderDetailVM.orderModel.desc;
            NSLog(@"!!!!!!!!!!!!!!!%@", cell.describeLb.text);
            //设置行距
            if (cell.describeLb.text.length > 0) {
                cell.describeLb.hidden = NO;
                [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
            } else {
                cell.describeLb.hidden = YES;
            }
            
            return cell;
        }
        
        if (indexPath.section == 2) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"收入详情";
                [cell.rightBtn setTitle:@"管理细则" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:3];
                }
                //测试
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"项目服务费: ¥%@", self.orderDetailVM.orderModel.platformServicePrice], [NSString stringWithFormat:@"其他材料费: ¥%ld", self.orderDetailVM.orderModel.itemServiceCase], [NSString stringWithFormat:@"平台技术费: ¥%@", self.orderDetailVM.orderModel.itemCase]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZRightIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
                cell.incomeNumberLb.text = self.orderDetailVM.orderModel.orderRevenue;
                return cell;
            }
            
            
        }
        
        if (indexPath.section == 3) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单信息";
                [cell.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:7];
                }
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime], [NSString stringWithFormat:@"接单时间: %@", self.orderDetailVM.orderModel.receiveTime]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            
        }
        
        
        if (indexPath.section == 4) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单详情";
                cell.rightBtn.hidden = YES;
                return cell;
            }
            if (indexPath.row == 1) {
                HZServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
                NSLog(@"%ld", self.orderDetailVM.numberRow);
                for (int i = 0; i < self.orderDetailVM.numberRow; i++) {
                    cell.labelArr[i].titleLb.text = self.orderDetailVM.listModel[i].name;
                    cell.labelArr[i].unitCostLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].price];
                    cell.labelArr[i].numberLb.text = [NSString stringWithFormat:@"x%ld", self.orderDetailVM.listModel[i].quantity];
                    cell.labelArr[i].totalLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].smallCount];
                    cell.labelArr[i].hidden = NO;
                }
                for (NSInteger i = self.orderDetailVM.numberRow; i < 10; i++) {
                    cell.labelArr[i].hidden = YES;
                }
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalCell" forIndexPath:indexPath];
                cell.leftLb.text = [NSString stringWithFormat:@"合计: ¥%.2f", (CGFloat)self.orderDetailVM.orderModel.orderMoney];
                cell.leftLb.text = [NSString stringWithFormat:@"实付: ¥%@", self.orderDetailVM.orderModel.payMoney];
                return cell;
            }
            
            
        }
        
    }
    
    
    if (_orderDetailVM.orderModel.orderStatus == 4 || _orderDetailVM.orderModel.orderStatus == 5 || _orderDetailVM.orderModel.orderStatus == 6) {
        
        if (indexPath.section == 0) {
            HZIndexOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell" forIndexPath:indexPath];
            cell.leftView.topLb.text = self.orderDetailVM.orderModel.orderRevenue;
            cell.rightView.topLb.text = self.orderDetailVM.orderModel.appointmentTime;
            cell.rightView.bottomLb.text = @"预约服务时间";
            return cell;
        }
        if (indexPath.section == 1) {
            HZPatientDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.sex, self.orderDetailVM.orderModel.age];
            cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
            cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
            [cell.callBtn addTarget:self action:@selector(detailCallClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            
            cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
            cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
            cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
            NSLog(@"!!!!!!!!!!!!!!!%@", self.orderDetailVM.orderModel.desc);
            cell.describeLb.text = self.orderDetailVM.orderModel.desc;
            NSLog(@"!!!!!!!!!!!!!!!%@", cell.describeLb.text);
            //设置行距
            if (cell.describeLb.text.length > 0) {
                cell.describeLb.hidden = NO;
                [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
            } else {
                cell.describeLb.hidden = YES;
            }
            
            return cell;
        }
        
        if (indexPath.section == 2) {
            HZTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textViewCell" forIndexPath:indexPath];
            cell.textView.hidden = YES;
            return cell;
        }
        
        if (indexPath.section == 3) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"收入详情";
                [cell.rightBtn setTitle:@"管理细则" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:3];
                }
                //测试
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"项目服务费: ¥%@", self.orderDetailVM.orderModel.platformServicePrice], [NSString stringWithFormat:@"其他材料费: ¥%ld", self.orderDetailVM.orderModel.itemServiceCase], [NSString stringWithFormat:@"平台技术费: ¥%@", self.orderDetailVM.orderModel.itemCase]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZRightIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
                cell.incomeNumberLb.text = self.orderDetailVM.orderModel.orderRevenue;
                return cell;
            }
            
            
        }
        
        if (indexPath.section == 4) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单信息";
                [cell.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:7];
                }
                if (_orderDetailVM.orderModel.orderStatus == 4) {
                    cell.count = 4;
                    NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime], [NSString stringWithFormat:@"接单时间: %@", self.orderDetailVM.orderModel.receiveTime], [NSString stringWithFormat:@"开始服务时间: %@", self.orderDetailVM.orderModel.serviceTime]];
                    for (int i = 0; i < 4; i++) {
                        cell.labelArr[i].text = arr[i];
                    }
                }
                if (_orderDetailVM.orderModel.orderStatus == 5) {
                    cell.count = 5;
                    NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime], [NSString stringWithFormat:@"接单时间: %@", self.orderDetailVM.orderModel.receiveTime], [NSString stringWithFormat:@"开始服务时间: %@", self.orderDetailVM.orderModel.serviceTime], [NSString stringWithFormat:@"完成服务时间: %@", self.orderDetailVM.orderModel.finishServiceTime]];
                    for (int i = 0; i < 5; i++) {
                        cell.labelArr[i].text = arr[i];
                    }
                }
                if (_orderDetailVM.orderModel.orderStatus == 6) {
                    cell.count = 7;
                    NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime], [NSString stringWithFormat:@"接单时间: %@", self.orderDetailVM.orderModel.receiveTime], [NSString stringWithFormat:@"开始服务时间: %@", self.orderDetailVM.orderModel.serviceTime], [NSString stringWithFormat:@"完成服务时间: %@", self.orderDetailVM.orderModel.finishServiceTime], [NSString stringWithFormat:@"评价用户时间: %@", self.orderDetailVM.orderModel.evaluateTime], [NSString stringWithFormat:@"用户确认时间: %@", self.orderDetailVM.orderModel.patientConfirmTime]];
                    for (int i = 0; i < 7; i++) {
                        cell.labelArr[i].text = arr[i];
                    }
                }
                
                return cell;
                
            }
            
        }
        
        
        if (indexPath.section == 5) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单详情";
                cell.rightBtn.hidden = YES;
                return cell;
            }
            if (indexPath.row == 1) {
                HZServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
                NSLog(@"%ld", self.orderDetailVM.numberRow);
                for (int i = 0; i < self.orderDetailVM.numberRow; i++) {
                    cell.labelArr[i].titleLb.text = self.orderDetailVM.listModel[i].name;
                    cell.labelArr[i].unitCostLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].price];
                    cell.labelArr[i].numberLb.text = [NSString stringWithFormat:@"x%ld", self.orderDetailVM.listModel[i].quantity];
                    cell.labelArr[i].totalLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].smallCount];
                    cell.labelArr[i].hidden = NO;
                }
                for (NSInteger i = self.orderDetailVM.numberRow; i < 10; i++) {
                    cell.labelArr[i].hidden = YES;
                }
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalCell" forIndexPath:indexPath];
                cell.leftLb.text = [NSString stringWithFormat:@"合计: ¥%.2f", (CGFloat)self.orderDetailVM.orderModel.orderMoney];
                cell.leftLb.text = [NSString stringWithFormat:@"实付: ¥%@", self.orderDetailVM.orderModel.payMoney];
                return cell;
            }
            
            
        }
        
    }
    
    
    if (_orderDetailVM.orderModel.orderStatus == 7 || _orderDetailVM.orderModel.orderStatus == 8) {
        
        if (indexPath.section == 0) {
            HZCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countDownCell" forIndexPath:indexPath];
            cell.countDownTitleLb.text = @"医护已取消: ";
            cell.countDownLb.hidden = YES;
            cell.cancelReasonLb.hidden = NO;
            cell.cancelReasonLb.text = @"任性";
            
            
            return cell;
        }

        
        if (indexPath.section == 1) {
            HZIndexOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell" forIndexPath:indexPath];
            cell.leftView.topLb.text = self.orderDetailVM.orderModel.orderRevenue;
            cell.rightView.topLb.text = self.orderDetailVM.orderModel.appointmentTime;
            cell.rightView.bottomLb.text = @"预约服务时间";
            return cell;
        }
        if (indexPath.section == 2) {
            HZPatientDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.sex, self.orderDetailVM.orderModel.age];
            cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
            cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
            [cell.callBtn addTarget:self action:@selector(detailCallClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
            
            cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
            cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
            cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
            NSLog(@"!!!!!!!!!!!!!!!%@", self.orderDetailVM.orderModel.desc);
            cell.describeLb.text = self.orderDetailVM.orderModel.desc;
            NSLog(@"!!!!!!!!!!!!!!!%@", cell.describeLb.text);
            //设置行距
            if (cell.describeLb.text.length > 0) {
                cell.describeLb.hidden = NO;
                [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
            } else {
                cell.describeLb.hidden = YES;
            }
            
            return cell;
        }
        
        if (indexPath.section == 3) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"收入详情";
                [cell.rightBtn setTitle:@"管理细则" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:3];
                }
                //测试
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"项目服务费: ¥%@", self.orderDetailVM.orderModel.platformServicePrice], [NSString stringWithFormat:@"其他材料费: ¥%ld", self.orderDetailVM.orderModel.itemServiceCase], [NSString stringWithFormat:@"平台技术费: ¥%@", self.orderDetailVM.orderModel.itemCase]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZRightIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
                cell.incomeNumberLb.text = self.orderDetailVM.orderModel.orderRevenue;
                return cell;
            }
            
            
        }
        
        if (indexPath.section == 4) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单信息";
                [cell.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
                return cell;
            }
            if (indexPath.row == 1) {
                HZIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
                if (!cell) {
                    cell = [[HZIncomeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomeCell" count:7];
                }
                cell.count = 3;
                NSArray *arr = @[[NSString stringWithFormat:@"订单号: %ld", self.orderDetailVM.orderModel.orderCode], [NSString stringWithFormat:@"下单时间: %@", self.orderDetailVM.orderModel.createTime], [NSString stringWithFormat:@"取消时间: %@", self.orderDetailVM.orderModel.receiveTime]];
                for (int i = 0; i < 3; i++) {
                    cell.labelArr[i].text = arr[i];
                }
                
                
                return cell;
                
            }
            
        }
        
        
        if (indexPath.section == 5) {
            if (!indexPath.row) {
                HZLbAndBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.leftLb.text = @"订单详情";
                cell.rightBtn.hidden = YES;
                return cell;
            }
            if (indexPath.row == 1) {
                HZServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCell" forIndexPath:indexPath];
                NSLog(@"%ld", self.orderDetailVM.numberRow);
                for (int i = 0; i < self.orderDetailVM.numberRow; i++) {
                    cell.labelArr[i].titleLb.text = self.orderDetailVM.listModel[i].name;
                    cell.labelArr[i].unitCostLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].price];
                    cell.labelArr[i].numberLb.text = [NSString stringWithFormat:@"x%ld", self.orderDetailVM.listModel[i].quantity];
                    cell.labelArr[i].totalLb.text = [NSString stringWithFormat:@"¥%ld", self.orderDetailVM.listModel[i].smallCount];
                    cell.labelArr[i].hidden = NO;
                }
                for (NSInteger i = self.orderDetailVM.numberRow; i < 10; i++) {
                    cell.labelArr[i].hidden = YES;
                }
                
                return cell;
                
            }
            if (indexPath.row == 2) {
                HZTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"totalCell" forIndexPath:indexPath];
                cell.leftLb.text = [NSString stringWithFormat:@"合计: ¥%.2f", (CGFloat)self.orderDetailVM.orderModel.orderMoney];
                cell.leftLb.text = [NSString stringWithFormat:@"实付: ¥%@", self.orderDetailVM.orderModel.payMoney];
                return cell;
            }
            
            
        }
        
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_orderDetailVM.orderModel.orderStatus == 2 || _orderDetailVM.orderModel.orderStatus == 7 || _orderDetailVM.orderModel.orderStatus == 8) {
        
        if (indexPath.section == 1) {
            return 48;
        }
        if (indexPath.section == 2) {
            return [tableView fd_heightForCellWithIdentifier:@"patientCell" configuration:^(HZPatientDetailCell * cell) {
                [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
                cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.personSex, self.orderDetailVM.orderModel.age];
                cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
                cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
                
                cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
                cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
                cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
                cell.describeLb.text = self.orderDetailVM.orderModel.desc;
                //设置行距
                if (cell.describeLb.text.length > 0) {
                    [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
                } else {
                    cell.describeLb.hidden = YES;
                }
            }];
        }
        
        if (indexPath.section == 3) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return 3 * 14 + 2 * 8 + 2 * 2;
            }
        }
        
        if (indexPath.section == 4) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                if (_orderDetailVM.orderModel.orderStatus == 2) {
                    return 2 * 14 + 2 * 8 + 6 * 4;
                } else {
                    return 3 * 14 + 2 * 8 + 6 * 4;
                }
            }
        }
        if (indexPath.section == 5) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return self.orderDetailVM.numberRow * 33;
            }
        }
        return 44;

        
    } else if (_orderDetailVM.orderModel.orderStatus == 3){
        
        if (indexPath.section == 0) {
            return 48;
        }
        if (indexPath.section == 1) {
            return [tableView fd_heightForCellWithIdentifier:@"patientCell" configuration:^(HZPatientDetailCell * cell) {
                [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
                cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.personSex, self.orderDetailVM.orderModel.age];
                cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
                cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
                
                cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
                cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
                cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
                cell.describeLb.text = self.orderDetailVM.orderModel.desc;
                //设置行距
                if (cell.describeLb.text.length > 0) {
                    [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
                } else {
                    cell.describeLb.hidden = YES;
                }
            }];
        }
        
        if (indexPath.section == 2) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return 3 * 14 + 2 * 8 + 2 * 2;
            }
        }
        
        if (indexPath.section == 3) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                
                return 3 * 14 + 2 * 8 + 6 * 4;
                
            }
        }
        if (indexPath.section == 4) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return self.orderDetailVM.numberRow * 33;
            }
        }
        return 44;
        
    } else {
        
        if (indexPath.section == 0) {
            return 48;
        }
        if (indexPath.section == 1) {
            return [tableView fd_heightForCellWithIdentifier:@"patientCell" configuration:^(HZPatientDetailCell * cell) {
                [cell.iconImg sd_setImageWithURL:self.orderDetailVM.orderModel.head.tzl_URL];
                cell.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", self.orderDetailVM.orderModel.personName, self.orderDetailVM.orderModel.personSex, self.orderDetailVM.orderModel.age];
                cell.projectLb.text = [NSString stringWithFormat:@"身份证号码: %@", self.orderDetailVM.orderModel.idCard];
                cell.timeLb.text = [NSString stringWithFormat:@"医保卡号: %@", self.orderDetailVM.orderModel.medicareCard];
                
                cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", self.orderDetailVM.orderModel.name, self.orderDetailVM.orderModel.tel];
                cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", self.orderDetailVM.orderModel.addressInfo];
                cell.orderTimeLb.text = [NSString stringWithFormat:@"褥疮等级: %@", self.orderDetailVM.orderModel.itemClassifyName];
                cell.describeLb.text = self.orderDetailVM.orderModel.desc;
                //设置行距
                if (cell.describeLb.text.length > 0) {
                    [UILabel changeLineSpaceForLabel:cell.describeLb WithSpace:5.0];
                } else {
                    cell.describeLb.hidden = YES;
                }
            }];
        }
        
        if (indexPath.section == 2) {
            return 38;
        }
        
        if (indexPath.section == 3) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return 3 * 14 + 2 * 8 + 2 * 2;
            }
        }
        
        if (indexPath.section == 4) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                if (_orderDetailVM.orderModel.orderStatus == 4) {
                    return 4 * 14 + 2 * 8 + 6 * 4;
                }
                if (_orderDetailVM.orderModel.orderStatus == 5) {
                    return 5 * 14 + 2 * 8 + 6 * 4;
                }
                if (_orderDetailVM.orderModel.orderStatus == 6) {
                    return 7 * 14 + 2 * 8 + 6 * 4;
                }
            }
        }
        if (indexPath.section == 5) {
            if (indexPath.row != 1) {
                return 40;
            } else {
                return self.orderDetailVM.numberRow * 33;
            }
        }
        return 44;
        
    }
    
    
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
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








- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.bottom.equalTo(-40);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZIndexOrderCell class] forCellReuseIdentifier:@"indexCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZPatientDetailCell class] forCellReuseIdentifier:@"patientCell"];
        [_tableView registerClass:[HZLbAndBtnCell class] forCellReuseIdentifier:@"statusCell"];
        [_tableView registerClass:[HZRightIncomeCell class] forCellReuseIdentifier:@"rightCell"];
        [_tableView registerClass:[HZTotalCell class] forCellReuseIdentifier:@"totalCell"];
        [_tableView registerClass:[HZCountDownCell class] forCellReuseIdentifier:@"countDownCell"];
        [_tableView registerClass:[HZServicesCell class] forCellReuseIdentifier:@"serviceCell"];
        [_tableView registerClass:[HZTextViewCell class] forCellReuseIdentifier:@"textViewCell"];
        
    }
    return _tableView;
}


- (HZOrderDetailViewModel *)orderDetailVM {
    if (!_orderDetailVM) {
        _orderDetailVM = [HZOrderDetailViewModel new];
    }
    return _orderDetailVM;
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(40);
        }];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = kGrayColor.CGColor;
    }
    return _bottomView;
}

- (UIButton *)isServiceBtn {
    if (!_isServiceBtn) {
        _isServiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.bottomView addSubview:_isServiceBtn];
        [_isServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        _isServiceBtn.layer.borderColor = kRGBA(100, 143, 255, 1.0).CGColor;
        _isServiceBtn.layer.borderWidth = 1;
        [_isServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
        _isServiceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _isServiceBtn.layer.cornerRadius = 3;
        _isServiceBtn.clipsToBounds = YES;
        
        //让文字不靠边
        _isServiceBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
        
        [_isServiceBtn addTarget:self action:@selector(detailRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _isServiceBtn;
}


- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.bottomView addSubview:_cancleBtn];
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.isServiceBtn.mas_left).equalTo(-12);
            make.centerY.equalTo(0);
        }];
        _cancleBtn.layer.borderColor = kRGBA(88, 88, 88, 1.0).CGColor;
        _cancleBtn.layer.borderWidth = 1;
        _cancleBtn.layer.cornerRadius = 3;
        _cancleBtn.clipsToBounds = YES;
        [_cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_cancleBtn setTitleColor:kRGBA(88, 88, 88, 1.0) forState:UIControlStateNormal];
        
        _cancleBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
        [_isServiceBtn addTarget:self action:@selector(detailLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancleBtn;
}



@end
