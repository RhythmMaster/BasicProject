//
//  HZSetVC.m
//  dddd
//
//  Created by NSX443 on 16/11/11.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZSetVC.h"
#import "HZGetCodeNM.h"
#import "LoginViewController.h"

@interface HZSetVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) UITableView *tableView;

@property(nonatomic) UIButton *backAccountBtn;
@end

@implementation HZSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBA(234, 234, 234, 1.0);
    
    [self tableView];
    [self backAccountBtn];
    self.title = @"更多";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method
- (void)logout:(UIButton *)sender {
    NSLog(@"点了账号退出");
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"提示" message:@"请确认是否退出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.view showBusyHUD];
        [HZGetCodeNM logoutCompletionHandler:^(id model, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSLog(@"%@", model);
            }
            
            if ([model objectForKey:@"STATE"]) {
                [self.view hideBusyHUD];
                [self.view showWarning:@"退出成功"];
                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [app showHomeViewController];
            } else {
                [self.view hideBusyHUD];
                [self.view showWarning:@"退出失败"];
            }
            
            
            
        }];
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    [alertController addAction:logoutAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}



#pragma mark delete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改密码";
        cell.imageView.image = [UIImage imageNamed:@"xiugaimima"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"服务条款";
        cell.imageView.image = [UIImage imageNamed:@"service-1"];
    } else {
        cell.textLabel.text = @"版本更新";
        cell.imageView.image = [UIImage imageNamed:@"banben"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}





#pragma mark -懒加栽
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(0);
            make.height.equalTo(130);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


- (UIButton *)backAccountBtn {
    if (!_backAccountBtn) {
        _backAccountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_backAccountBtn];
        [_backAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.bottom.equalTo(-58);
            make.height.equalTo(44);
        }];
        [_backAccountBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_backAccountBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _backAccountBtn.backgroundColor = [UIColor whiteColor];
        [_backAccountBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backAccountBtn;
}




@end
