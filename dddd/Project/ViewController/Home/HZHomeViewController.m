//
//  HZHomeViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/8.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZHomeViewController.h"
#import "HZHomeTopCell.h"
#import "HZHomeTopTwoCell.h"
#import "HZStatusCell.h"
#import "HZPatientCell.h"
#import "HZIsOrderCell.h"
#import "HZMessageViewController.h"
#import "HZMsgNetManager.h"
#import "HZTopView.h"
#import "HZTopTwoView.h"
#import "HZPersonalCenterNM.h"
#import "HZOrderDetailVC.h"



#import "HZWaitRefuseorViewController.h"
#import "HZWaitcancelorderViewController.h"
#import "HZToEvaluateOrderViewController.h"

typedef NS_ENUM(NSUInteger, VVMRequestMode){
    VVMRequestModeRefresh,
    VVMRequestModeMore,
};


@interface HZHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

//分页
@property(nonatomic) NSInteger page;
//下拉状态变更判断section数量,防止上拉刷新没有数据.数据被隐藏

@property(nonatomic) BOOL isFooterRefresh;


@property(nonatomic) UITableView *tableView;

@property(nonatomic) UIView *emptyView;


@property(nonatomic) UIView *leftBarView;

@property(nonatomic) UIView *rightBarView;

@property(nonatomic) UIButton *loationBtn;

@property(nonatomic) UIButton *imgBtn;


@property(nonatomic) NSInteger msgNumber;

@property(nonatomic) HZHomeModel *homeModel;

//数组.存放所有刷新的array

@property(nonatomic) NSMutableArray<HZHomeListModel *> *list;


//指向view
@property(nonatomic) UILabel *nameLb;
@property(nonatomic) UIButton *signBtn;

@property(nonatomic) UIImageView *iconImg;

@property(nonatomic) UILabel *topTwoLeftLb;
@property(nonatomic) UILabel *topTwoCenterLb;
@property(nonatomic) UILabel *topTwoRightLb;


//指向cell内view


@property(nonatomic) UILabel *patientNameLb;

@property(nonatomic) UILabel *projectLb;



@property(nonatomic) NSInteger orderNumer;

@property(nonatomic) NSInteger orderStatusCode;





//地图定位

@property(nonatomic) NSString *address;
@property(nonatomic) NSString *addressXY;


@end

@implementation HZHomeViewController

- (instancetype)init {
    if (self = [super init]) {
        
        
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    //[self.tableView.mj_header beginRefreshing];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCurrentLocation];
    
    [self imgBtn];
    //[self initTopUI];
    
    //设置navigation
    [self initNaviUI];
    
    
    
    //普通进入数据自动更新
    [self getAFWithRequestMode:VMRequestModeRefresh];
    
    //手动刷新数据更新
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self getAFWithRequestMode:VMRequestModeRefresh];
        
        
    }];
    
    //脚刷新
    //防止网络慢时候,显示脚部刷新,进入隐藏
    self.tableView.mj_footer.hidden = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getAFWithRequestMode:VMRequestModeMore];
        //判断首次加载数据是否小于服务器小于的数量
        
        
    }];
    
    
    //[_tableView.mj_header beginRefreshing];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChange:) name:@"stateChange" object:nil];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenW, 1);
    
    self.tableView.tableHeaderView = headerView;
    
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

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"stateChange" object:nil];
//}

#pragma mark method call
- (void)homeCallClick:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    NSLog(@"打电话 : %ld", _list[sender.tag - 800].tel);
    NSInteger tel = _list[sender.tag - 800].tel;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否拨打号码: %ld", tel] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld", tel]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:callAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark method

- (void)signClick:(UIButton *)sender {
    
    [HZPersonalCenterNM getSignCompletionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            if ([model objectForKey:@"STATE"]) {
                //创建消息对象
                NSNotification *notice = [NSNotification notificationWithName:@"stateChange1" object:nil userInfo:@{@"STATE":[model objectForKey:@"STATE"]}];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                [self.view showWarning:[model objectForKey:@"MSG"]];
                [_signBtn setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
                
            }
        }
    }];
}



//观察消息
- (void)stateChange:(id)sender {
    NSLog(@"i am back");
    
    BOOL state = [[sender valueForKey:@"userInfo"] valueForKey:@"STATE"];
    if (state) {
        [_signBtn setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
    } else {
        [_signBtn setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
    }
}

- (void)getAFWithRequestMode:(VMRequestMode)requestMode {
    NSInteger tmpPage = 1;
    _isFooterRefresh = 0;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
        _isFooterRefresh = 1;
        
    }
    
    [HZMsgNetManager getHomeWithPage:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"10" completionHandler:^(HZHomeModel *model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            
            /**
             很重要,不用这个数组存储,会导致上啦刷新数据没了
             */
            if (requestMode == VMRequestModeRefresh) {
                //结束刷新
                [self.tableView.mj_header endRefreshing];
                
                [self.list removeAllObjects];
            }
            [self.list addObjectsFromArray:model.list];
            
            //头像
            //NSLog(@"---------%@", _list[0].head);
            
            
            self.homeModel = model;
            _msgNumber = model.msgCount;
            
            //cell内view根据服务器数据更新设置
            _nameLb.text = [NSString stringWithFormat:@"您好,%@", _homeModel.name];
            if (_homeModel.isSign) {
                [_signBtn setImage:[UIImage imageNamed:@"qiandao1"] forState:UIControlStateNormal];
            } else {
                [_signBtn setImage:[UIImage imageNamed:@"qiandao"] forState:UIControlStateNormal];
            }
            _topTwoLeftLb.text = [NSString stringWithFormat:@"%ld", _homeModel.serviceCount];
            _topTwoCenterLb.text = [NSString stringWithFormat:@"%ld", _homeModel.receiveOrderCount];
            _topTwoRightLb.text = [NSString stringWithFormat:@"%ld", _homeModel.caseCount];
            
        }
        if (_msgNumber >=1 ) {
            [_rightBarView.badgeView setBadgeValue:_msgNumber];
            [_rightBarView.badgeView setOutlineWidth:0.0];
            [_rightBarView.badgeView setPosition:MGBadgePositionTopRight];
            [_rightBarView.badgeView setBadgeColor:[UIColor redColor]];
            [_rightBarView.badgeView setTextColor:[UIColor whiteColor]];
            [_rightBarView.badgeView setSize:CGSizeMake(20, 20)];
            
        }
        
        //        if (!_list.count) {
        //            //_tableView.scrollEnabled = NO;
        //            [self emptyView];
        //            _emptyView.hidden = NO;
        //            
        //            
        //        } else {
        //            _emptyView.hidden = YES;
        //            // _tableView.scrollEnabled = YES;
        //        }
        if (requestMode == VMRequestModeMore) {
            [self.tableView.mj_footer endRefreshing];
            if (model.list.count == 0) {
                [self.view showWarning:@"没有更多订单信息了"];
            }
        }
        
        _page = tmpPage;
        [_tableView reloadData];
        
    }];
    
}



- (void) initNaviUI {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:self.leftBarView];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIButton *image = [UIButton buttonWithType:UIButtonTypeSystem];
    [image addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [image setImage:[UIImage imageNamed:@"message_title"] forState:UIControlStateNormal];
    [self.rightBarView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
    
    self.navigationItem.rightBarButtonItem = rightbar;
    
}

- (void) initTopUI {
    HZTopView *topView = [[HZTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
    self.signBtn = topView.signBtn;
    self.nameLb = topView.nameLb;
    [self.view addSubview:topView];
    
    
    
    //横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenW, 1)];
    lineView.backgroundColor = kRGBA(220, 220, 220, 1.0);
    [self.view addSubview:lineView];
    
    HZTopTwoView *topTwoView = [[HZTopTwoView alloc] initWithFrame:CGRectMake(0, 60, kScreenW, 40)];
    self.topTwoLeftLb = topTwoView.leftView.timesLb;
    self.topTwoCenterLb = topTwoView.centerView.timesLb;
    self.topTwoRightLb = topTwoView.rightView.timesLb;
    [self.view addSubview:topTwoView];
}

#pragma mark OrderOperation

- (void)receviveOrderClick:(UIButton *)sender {
    NSLog(@"确认订单");
    NSLog(@"%@, %@, %@", _address, _addressXY, _list[sender.tag - 100 - 1].ID);
    [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1].ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            //普通进入数据自动更新
            [self getAFWithRequestMode:VMRequestModeRefresh];
            [self.view showWarning:[model objectForKey:@"MSG"]];
        }
    }];
    return;
}

- (void)deleteOrderClick:(UIButton *)sender {
    NSLog(@"删除订单");
    NSLog(@"%@", _list[sender.tag - 100 - 1 - self.orderStatusCode].ID);
    [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1 - self.orderStatusCode].ID completionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            //普通进入数据自动更新
            [self getAFWithRequestMode:VMRequestModeRefresh];
            [self.view showWarning:[model objectForKey:@"MSG"]];
        }
    }];
    return;
}




#pragma mark
- (void)getCurrentLocation {
    [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
            [self.view showWarning:@"定位失败"];
        }else{
            [self.view showWarning:@"定位成功"];
            

            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@%@%@ \n ",location.coordinate.latitude, location.coordinate.longitude,  placeMark.locality, placeMark.subLocality, placeMark.name);
            [self.loationBtn setTitle:placeMark.locality forState:UIControlStateNormal];
            self.address = [NSString stringWithFormat:@"%@%@%@", placeMark.locality, placeMark.subLocality, placeMark.name];
            self.addressXY = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
            
            
            //数据持久化
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.address forKey:@"address"];
            [defaults setObject:self.addressXY forKey:@"addressXY"];
            [defaults synchronize];
            
        }
    } onViewController:self];

}

- (void)positionClick:(UIButton *)sender {
   
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否让该应用获取位置信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.view showBusyHUD];
        
        [self getCurrentLocation];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    [alertController addAction:logoutAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
    

    
}

- (void)leftBtnClick:(UIButton *)sender {
    
    NSLog(@"%ld", _list[sender.tag - 200 - 1].orderStatusCode);
    
    if (_list[sender.tag - 200 - 1].orderStatusCode == 2) {
        NSLog(@"拒绝接单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否拒单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"确认拒单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitRefuseorViewController *waitRefuseorVC = [[HZWaitRefuseorViewController alloc] initWithOrderId:_list[sender.tag - 200 - 1].ID];
            [self.navigationController pushViewController:waitRefuseorVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    if (_list[sender.tag - 200 - 1].orderStatusCode == 3) {
        NSLog(@"取消订单");
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.hidesBottomBarWhenPushed = YES;
            HZWaitcancelorderViewController *waitCancelVC = [[HZWaitcancelorderViewController alloc] initWithOrderId:_list[sender.tag - 200 - 1].ID];
            [self.navigationController pushViewController:waitCancelVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [alertController addAction:logoutAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    if (_list[sender.tag - 200 - 1].orderStatusCode == 6) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:_list[sender.tag - 200 - 1].ID];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
}
- (void)rightBtnClick:(UIButton *)sender {
    NSLog(@"%ld", _list[sender.tag - 100 - 1].orderStatusCode);
    if (_list[sender.tag - 100 - 1].orderStatusCode == 2) {
        NSLog(@"确认接单");
        //[_orderViewModel getIdWithRow:sender.tag - 100]
        NSLog(@"%@, %@, %@", _address, _addressXY, _list[sender.tag - 100 - 1].ID);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否接单" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"接单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1].ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
    if (_list[sender.tag - 100 - 1].orderStatusCode == 3) {
        NSLog(@"开始服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, _list[sender.tag - 100 - 1].ID);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否开始服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"开始服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getStartServiceOrderWithId:_list[sender.tag - 100 - 1].ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
    if (_list[sender.tag - 100 - 1].orderStatusCode == 4) {
        NSLog(@"完成服务");
        NSLog(@"%@, %@, %@", _address, _addressXY, _list[sender.tag - 100 - 1].ID);
        if (!_address) {
            [self getCurrentLocation];
        } else {
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否完成服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"完成服务" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [HZOrderOperateNetManager getFinishOrderWithId:_list[sender.tag - 100 - 1].ID address:_address addressXY:_addressXY completionHandler:^(id model, NSError *error) {
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
    if (_list[sender.tag - 100 - 1].orderStatusCode == 5) {
        NSLog(@"评价患者");
        self.hidesBottomBarWhenPushed = YES;
        HZToEvaluateOrderViewController *toEvaluateOrderViewVC = [[HZToEvaluateOrderViewController alloc] initWithOrderId:_list[sender.tag - 100 - 1].ID];
        [self.navigationController pushViewController:toEvaluateOrderViewVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
    if (_list[sender.tag - 100 - 1].orderStatusCode == 6) {
        NSLog(@"删除订单");
        
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1].ID completionHandler:^(id model, NSError *error) {
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
    if (_list[sender.tag - 100 - 1].orderStatusCode == 7) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1].ID completionHandler:^(id model, NSError *error) {
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
    if (_list[sender.tag - 100 - 1].orderStatusCode == 8) {
        NSLog(@"删除订单");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认是否删除订单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [HZOrderOperateNetManager getOrderOperationWithId:_list[sender.tag - 100 - 1].ID completionHandler:^(id model, NSError *error) {
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

- (void)rightClick:(UIButton *)sender {
    //push进去隐藏
    self.hidesBottomBarWhenPushed = YES;
    HZMessageViewController *messageVC = [HZMessageViewController new];
    [self.navigationController pushViewController:messageVC animated:YES];
    //返回显示
    self.hidesBottomBarWhenPushed = NO;
}



#pragma mark delete 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_list.count) {
        return _list.count + 1;
    } else {
        return 2;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (!_list.count) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            HZHomeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTopCell" forIndexPath:indexPath];
            if (_list.count) {
                cell.lineView.hidden = YES;

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //设置
            self.nameLb = cell.nameLb;
            self.signBtn = cell.signBtn;
            self.iconImg = cell.iconImg;
            
            [_signBtn addTarget:self action:@selector(signClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (self.nameLb.text.length == 0) {
                self.nameLb.text = @"您好,未设置";
            }
            
            return cell;
        } else {
            HZHomeTopTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTopTwoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //设置
            self.topTwoLeftLb = cell.leftView.timesLb;
            self.topTwoCenterLb = cell.centerView.timesLb;
            self.topTwoRightLb = cell.rightView.timesLb;
            
            return cell;
        }
    } else {
        if (_list.count) {
            if (indexPath.row == 0) {
                HZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.diseaseLb.text = [NSString stringWithFormat:@"%@(%@)", _list[indexPath.section - 1].itemName, _list[indexPath.section - 1].itemClassifyName];
                cell.statusLb.text = [NSString stringWithFormat:@"%@", _list[indexPath.section - 1].orderStatusName];
                
                return cell;
            } else if (indexPath.row == 1) {
                HZPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell" forIndexPath:indexPath];
                
                //设置
                self.patientNameLb = cell.patientNameLb;
                self.patientNameLb.text = [NSString stringWithFormat:@"就诊人员: %@ %@ %ld", _list[indexPath.section - 1].personName, _list[indexPath.section - 1].sex, _list[indexPath.section - 1].age];
                //self.projectLb = cell.projectLb;
                
                cell.projectLb.text = [NSString stringWithFormat:@"服务项目: %@", _list[indexPath.section - 1].orderServices];
                cell.timeLb.text = [NSString stringWithFormat:@"服务时间: %@", _list[indexPath.section - 1].appointmentTime];
                cell.contactsLb.text = [NSString stringWithFormat:@"联系人员: %@ %ld", _list[indexPath.section - 1].name, _list[indexPath.section - 1].tel];
                cell.addressLb.text = [NSString stringWithFormat:@"服务地址: %@", _list[indexPath.section - 1].addressInfo];
                cell.orderTimeLb.text = [NSString stringWithFormat:@"下订单时间: %@", _list[indexPath.section - 1].createTime];
                cell.callBtn.tag = indexPath.section - 1 + 800;
                [cell.callBtn addTarget:self action:@selector(homeCallClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                return cell;
            } else {
                HZIsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"isOrderCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.incomeNumberLb.text = [NSString stringWithFormat:@"¥ %@", _list[indexPath.section - 1].orderRevenue];
                //设置
                self.orderStatusCode = _list[indexPath.section - 1].orderStatusCode;
                
                cell.isServiceBtn.tag = indexPath.section + 100 ;
                cell.cancleBtn.tag = indexPath.section + 200;
                
                [cell.cancleBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.isServiceBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                if (_list[indexPath.section - 1].orderStatusCode == 2) {
                    [cell.cancleBtn setTitle:@"拒绝接单" forState:UIControlStateNormal];
                    cell.cancleBtn.hidden = NO;
                    [cell.isServiceBtn setTitle:@"确认接单" forState:UIControlStateNormal];
                    cell.isServiceBtn.hidden = NO;
                    
                    
                } else if (_list[indexPath.section - 1].orderStatusCode == 3) {
                    [cell.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    cell.cancleBtn.hidden = NO;
                    [cell.isServiceBtn setTitle:@"开始服务" forState:UIControlStateNormal];
                    cell.isServiceBtn.hidden = NO;
                }
                else if (_list[indexPath.section - 1].orderStatusCode == 4) {
                    cell.cancleBtn.hidden = YES;
                    [cell.isServiceBtn setTitle:@"完成服务" forState:UIControlStateNormal];
                    cell.isServiceBtn.hidden = NO;
                }
                else if (_list[indexPath.section - 1].orderStatusCode == 5) {
                    cell.cancleBtn.hidden = YES;
                    [cell.isServiceBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                    cell.isServiceBtn.hidden = NO;
                }
                else if (_list[indexPath.section - 1].orderStatusCode == 6) {
                    [cell.cancleBtn setTitle:@"评价患者" forState:UIControlStateNormal];
                    cell.cancleBtn.hidden = NO;
                    [cell.isServiceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                    cell.isServiceBtn.hidden = NO;
                   
                }
                else if (_list[indexPath.section - 1].orderStatusCode == 7) {
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
        } else {
            HZEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
            //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            return cell;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        } else {
            return 45;
        }
        
    } else {
        if (!_list.count) {
            return 0;
        }
        if (indexPath.row == 1) {
            return 120;
        } else {
            return 40;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //return 10;
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //return 1;
    if (!_list.count) {
        return 0.001;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section) {
        if (indexPath.row == 1) {
            self.hidesBottomBarWhenPushed = YES;
            HZOrderDetailVC *dataVC = [HZOrderDetailVC new];
            dataVC.ID = _list[indexPath.section - 1].ID;
            [self.navigationController pushViewController:dataVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
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
            //            make.top.equalTo(100);
            //            make.left.right.bottom.equalTo(0);
            
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZHomeTopCell class] forCellReuseIdentifier:@"homeTopCell"];
        [_tableView registerClass:[HZHomeTopTwoCell class] forCellReuseIdentifier:@"homeTopTwoCell"];
        [_tableView registerClass:[HZStatusCell class] forCellReuseIdentifier:@"statusCell"];
        [_tableView registerClass:[HZPatientCell class] forCellReuseIdentifier:@"patientCell"];
        [_tableView registerClass:[HZIsOrderCell class] forCellReuseIdentifier:@"isOrderCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZEmptyCell class] forCellReuseIdentifier:@"emptyCell"];
    }
    
    
    return _tableView;
}


- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [UIView new];
        [_tableView.superview addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(120);
            make.left.right.bottom.equalTo(0);
        }];
        //_emptyView.backgroundColor = [UIColor redColor];
        
        
        UIImageView *img = [UIImageView new];
        [_emptyView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(30);
            make.size.equalTo(CGSizeMake(80, 90));
        }];
        img.image = [UIImage imageNamed:@"暂无订单"];
        
        
        UILabel *orderLb = [UILabel new];
        [_emptyView addSubview:orderLb];
        [orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(img.mas_bottom).equalTo(8);
            
        }];
        orderLb.font = [UIFont systemFontOfSize:18];
        orderLb.textColor = kGrayColor;
        orderLb.text = @"暂无订单";
        
        
    }
    return _emptyView;
}



- (UIView *)leftBarView {
    if (!_leftBarView) {
        _leftBarView = [UIView new];
        _leftBarView.size = CGSizeMake(20, 20);
        
    }
    return _leftBarView;
}

- (UIView *)rightBarView {
    if (!_rightBarView) {
        _rightBarView = [UIView new];
        _rightBarView.size = CGSizeMake(20, 20);
    }
    return _rightBarView;
}


- (UIButton *)loationBtn {
    if (!_loationBtn) {
        _loationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.leftBarView addSubview:_loationBtn];
        [_loationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(-3);
            make.centerY.equalTo(0);
            
        }];
        _loationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loationBtn setTitle:@"定位" forState:UIControlStateNormal];
        [_loationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loationBtn addTarget:self action:@selector(positionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loationBtn;
}

- (UIButton *)imgBtn {
    if (!_imgBtn) {
        _imgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.leftBarView addSubview:_imgBtn];
        [_imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loationBtn.mas_right).equalTo(4);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(12, 5));
        }];
        [_imgBtn setImage:[UIImage imageNamed:@"icon_znsx"] forState:UIControlStateNormal];
    }
    return _loationBtn;
}



- (HZHomeModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [HZHomeModel new];
    }
    return _homeModel;
}



- (NSMutableArray<HZHomeListModel *> *)list {
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}





@end
