//
//  HZCommentViewController.m
//  dddd
//
//  Created by NSX443 on 16/11/9.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCommentViewController.h"
#import "HZCommentCell.h"
#import "HZIsShowCell.h"
#import "HZIsShowView.h"

#import "HZEmptyCell.h"

#import "HZMyEvaluateViewModel.h"

@interface HZCommentViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic) UITableView *tableView;

@property(nonatomic) NSInteger showNumber;

@property(nonatomic) HZIsShowView *isShowView;

@property(nonatomic) HZMyEvaluateViewModel *myEvaluateVM;

@property(nonatomic) UIView *backgroundView;


@end

@implementation HZCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBA(235, 235, 241, 1.0);
    
    UIView *headView = [UIView new];
    headView.size = CGSizeMake(kScreenW, 1);
    _tableView.tableHeaderView = headView;
    
    

    
    
    
    [self tableView];
    [self backgroundView];
    
    [self isShowView];
    
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.myEvaluateVM getMyEvaluateModelWithVMRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            if (!error) {
                [_tableView reloadData];
                
            }
            [_tableView.mj_header endRefreshing];
        }];
    }];
    [_tableView.mj_header beginRefreshing];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [self.myEvaluateVM getMyEvaluateModelWithVMRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
           if (!error) {
               [_tableView reloadData];
           }
           [self.tableView.mj_footer endRefreshing];
           if (self.myEvaluateVM.myEvaluateModel.content.count == 0) {
               [self.view showWarning:@"没有更多订单信息了"];
           }
       }];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark method

#pragma mark delete
- (void)switchClick:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"是");
        _tableView.hidden = NO;
        _backgroundView.hidden = YES;
        
    } else {
        NSLog(@"否");
        _tableView.hidden = YES;
        _backgroundView.hidden = NO;
    }
    [_tableView reloadData];
}



#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_myEvaluateVM.rowNumber) {
        return _myEvaluateVM.rowNumber;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_myEvaluateVM.rowNumber) {
        HZCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
        
        cell.nameLb.text = [_myEvaluateVM getNameWithIndex:indexPath.section];
        cell.contentLb.text = [_myEvaluateVM getEvaluateReasonWithIndex:indexPath.section];
        cell.timeLb.text = [_myEvaluateVM getEvaluateTimeWithIndex:indexPath.section];
        // [cell.starView setStarProgress:[self.myEvaluateVM getSynthesizeScoreWithIndex:indexPath.section] / 5.0];
        cell.starRatingView.value = [self.myEvaluateVM getSynthesizeScoreWithIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
   HZEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
    cell.orderLb.text = @"暂无评论";
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_myEvaluateVM.rowNumber) {
        return 100;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
    //return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
       return 6;
    //return 1;
}




#pragma mark -懒加栽

- (HZIsShowView *)isShowView {
    if (!_isShowView) {
        _isShowView = [HZIsShowView new];
        [self.view addSubview:_isShowView];
        [_isShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(44);
        }];
        _isShowView.backgroundColor = [UIColor whiteColor];
        
        [_isShowView.commentSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _isShowView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.edges.equalTo(0);
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(46);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZCommentCell class] forCellReuseIdentifier:@"commentCell"];
        [_tableView registerClass:[HZIsShowCell class] forCellReuseIdentifier:@"showCell"];
        [_tableView registerClass:[HZEmptyCell class] forCellReuseIdentifier:@"emptyCell"];
        
    }
    return _tableView;
}



- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        [self.view addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(150);
            make.size.equalTo(CGSizeMake(150, 150));
        }];
        //_backgroundView.backgroundColor = [UIColor redColor];
        
        
        UIImageView *img = [UIImageView new];
        [_backgroundView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.centerX.equalTo(0);
            make.size.equalTo(CGSizeMake(80, 80));
        }];
        img.image = [UIImage imageNamed:@"暂无订单"];
        UILabel *orderLb = [UILabel new];
        [_backgroundView addSubview:orderLb];
        [orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(img.mas_bottom).equalTo(8);
            
        }];
        orderLb.font = [UIFont systemFontOfSize:18];
        orderLb.textColor = kGrayColor;
        orderLb.text = @"暂无评论";
        
        
        
    }
    _backgroundView.hidden = YES;
    return _backgroundView;
}




- (HZMyEvaluateViewModel *)myEvaluateVM {
    if (!_myEvaluateVM) {
        _myEvaluateVM = [HZMyEvaluateViewModel new];
    }
    return _myEvaluateVM;
}














@end
