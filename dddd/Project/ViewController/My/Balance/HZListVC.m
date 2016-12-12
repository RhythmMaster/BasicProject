//
//  HZListVC.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZListVC.h"
#import "HZListCell.h"
#import "HZMyCashchangeNM.h"

@interface HZListVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) UITableView *tableView;



@end

@implementation HZListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableView];
    self.title = @"余额明细";
    
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [HZMyCashchangeNM getMyCashchangeWithPage:@"0" rows:@"0" completionHandler:^(HZMyCashchange *model, NSError *error) {
            
            NSLog(@"%@", model.msg);
            NSLog(@"%@", model.content[0]);
        }];
        [_tableView.mj_header endRefreshing];
    }];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        [_tableView registerClass:[HZListCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}











@end
