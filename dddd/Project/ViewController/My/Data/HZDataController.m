//
//  HZDataController.m
//  dddd
//
//  Created by tang on 16/11/25.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZDataController.h"
#import "HZDataCell.h"
#import "HZIconCell.h"
#import "HZCertificateVC.h"
#import "HZIDCardVc.h"
#import "HZPersonalCenterNM.h"

@interface HZDataController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic) UITableView *tableView;

@property(nonatomic) NSString *personName;

@property(nonatomic) NSString *personSex;

@property(nonatomic) NSString *personBirthday;

@property(nonatomic) NSString *personAddress;

@property(nonatomic) NSString *personAddressInfo;

@property(nonatomic) NSString *personServiceArea;

@property(nonatomic) NSString *personMedicPostId;

@property(nonatomic) NSString *personGoodAtField;

@property(nonatomic) NSString *personIdCard;

@property(nonatomic) NSString *personAlipay;

@property(nonatomic) NSString *professionID;

@end

@implementation HZDataController

- (instancetype)init {
    if (self = [super init]) {
        
        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick:)];
        self.navigationItem.rightBarButtonItem = saveBtn;
        
    }
    return self;
}

#pragma mark method
- (void)saveClick:(UIBarButtonItem *)sender {
    NSLog(@"点了保存");
    NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@", _personName, _personSex, _personBirthday, _personAddress, _personAddressInfo, _personServiceArea, _professionID, _personGoodAtField, _personIdCard, _personAlipay);
    [HZPersonalCenterNM SavePersonInfoWithName:_personName sex:_personSex birthday:_personBirthday address:_personAddress addressInfo:_personAddressInfo serviceArea:_personServiceArea medicPostId:_professionID goodAtField:_personGoodAtField idCard:_personIdCard alipay:_personAlipay CompletionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            NSLog(@"%@", model);
            NSLog(@"%@", [model objectForKey:@"MSG"]);
        }
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 14;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HZIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        
//        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
        
        static NSString *cellIndentifier = @"dataCell";
        HZDataCell *cell = [tableView cellForRowAtIndexPath:indexPath];
         // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (cell == nil) {
            cell = [[HZDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section;
        if (indexPath.section == 1) {
            cell.nameLb.text = @"姓名";
            //cell.rightTF.text = _personModel.name;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _personName = cell.rightTF.text;
        }
        if (indexPath.section == 2) {
            cell.nameLb.text = @"性别";
            //cell.rightTF.text = _personModel.sex;
            cell.rightTF.placeholder = @"请选择您的性别";
            cell.rightTF.enabled = NO;
//            if (_pickDic.count > 0) {
//                cell.rightTF.text = self.pickDic[0][@"title"];
//            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _personSex = cell.rightTF.text;
        }
        if (indexPath.section == 3) {
            cell.nameLb.text = @"出生年月";
            //cell.rightTF.text = _personModel.birthday;
            cell.rightTF.placeholder = @"请选择您的出生年月";
            cell.rightTF.enabled = NO;
//            if (_pickDic.count > 1) {
//                cell.rightTF.text = self.pickDic[1][@"title"];
//            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _personBirthday = cell.rightTF.text;
        }
        if (indexPath.section == 4) {
            cell.nameLb.text = @"地区";
            //cell.rightTF.text = _personModel.address;
            cell.rightTF.placeholder = @"请选择您的地址";
            cell.rightTF.enabled = NO;
//            if (_pickDic.count > 2) {
//                cell.rightTF.text = self.pickDic[2][@"title"];
//            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _personAddress = cell.rightTF.text;
        }
        if (indexPath.section == 5) {
            cell.nameLb.text = @"详细地址";
            //cell.rightTF.text = _personModel.addressInfo;
            cell.rightTF.placeholder = @"请填写您的详细地址";
            _personAddressInfo = cell.rightTF.text;
        }
        if (indexPath.section == 6) {
            cell.nameLb.text = @"服务地区";
            //cell.rightTF.text = _personModel.serviceArea;
            cell.rightTF.placeholder = @"请填写您的服务区域(非必选)";
            _personServiceArea = cell.rightTF.text;
        }
        if (indexPath.section == 7) {
            cell.nameLb.text = @"所属医院";
            //_sex = cell.nameLb.text;
            cell.rightTF.placeholder = @"请填写您所属的医院";
            
        }
        if (indexPath.section == 8) {
            cell.nameLb.text = @"所属科室";
            //_sex = cell.nameLb.text;
            
            cell.rightTF.placeholder = @"请填写您所属的科室";
            
        }
        if (indexPath.section == 9) {
            cell.nameLb.text = @"职称";
            //cell.rightTF.text = _personModel.medicPostName;
            cell.rightTF.placeholder = @"请填写您的职称";
//            if (_pickDic.count > 3) {
//                cell.rightTF.text = self.pickDic[3][@"title"];
//            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.rightTF.enabled = NO;
            //_medicPostId = cell.nameLb.text;
        }
        if (indexPath.section == 10) {
            cell.nameLb.text = @"从业经验与擅长";
            //cell.rightTF.text = _personModel.goodAtField;
            cell.rightTF.placeholder = @"请填写您的从业经验与擅长";
            _personGoodAtField = cell.rightTF.text;
        }
        if (indexPath.section == 11) {
            cell.nameLb.text = @"证书";
            cell.rightTF.enabled = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.section == 12) {
            cell.nameLb.text = @"身份证";
            //cell.rightTF.text = _personModel.idCard;
            cell.rightTF.enabled = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _personIdCard = cell.rightTF.text;
        }
        if (indexPath.section == 13) {
            cell.nameLb.text = @"支付宝账户";
            //cell.rightTF.text = _personModel.alipay;
            cell.rightTF.placeholder = @"请添加您的支付宝账号";
            _personAlipay = cell.rightTF.text;
        }
        
        return cell;
    

    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6;
}

#pragma mark delete 键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView endEditing:YES];
}







#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZIconCell class] forCellReuseIdentifier:@"iconCell"];
//        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"dataCell"];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}







@end
