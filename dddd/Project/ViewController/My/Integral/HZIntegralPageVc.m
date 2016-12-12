//
//  HZIntegralPageVc.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIntegralPageVc.h"
#import "HZIntegralViewController.h"

#import "STAlertView.h"

@interface HZIntegralPageVc ()

@property(nonatomic) HZIntegralViewModel *interalVM;

@property(nonatomic) NSString *integralRuleStr;


@end

@implementation HZIntegralPageVc


- (instancetype)init {
    if (self = [super init]) {
        
        self.title = @"积分";
        
        UIButton *rultBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [rultBtn setTitle:@"积分规则" forState:UIControlStateNormal];
        [rultBtn addTarget:self action:@selector(ruleClick:) forControlEvents:UIControlEventTouchUpInside];
        rultBtn.frame = CGRectMake(0, 0, 80, 20);
        UIBarButtonItem *ruleBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rultBtn];
        //ruleBarBtn.title = @"积分规则";
        self.navigationItem.rightBarButtonItem = ruleBarBtn;
        
        
    }
    return self;
}

- (void)ruleClick:(UIButton *)sender {

    [self.interalVM getIntegralRuleWithCompletionHandler:^(NSError *error) {
        if (!error) {
            self.integralRuleStr = [_interalVM getIntegralRule];
            NSLog(@"1111%@", _integralRuleStr);
        }
        
        NSArray *buttons = nil;
        buttons = @[@"知道了"];
        STAlertView *alert = [[STAlertView alloc] initWithTitle:@"积分规则"
                                                          image:nil
                                                        message:_integralRuleStr
                                                   buttonTitles:buttons];
        
        alert.hideWhenTapOutside = YES;
        
        [alert setDidShowHandler:^{
            NSLog(@"显示了");
        }];
        [alert setDidHideHandler:^{
            NSLog(@"消失了");
        }];
        [alert show:YES];
        
        
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    [self.interalVM getIntegralAFWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
        if (!error) {
            self.integralNumberLb.text = [NSString stringWithFormat:@"%ld", [self.interalVM getIntegralReserve]];
        }
        
    }];
    
    
    [self label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSArray<NSString *> *)titles {
    return @[@"全部", @"获得", @"使用"];
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    HZIntegralViewController *integralVC = [[HZIntegralViewController alloc] initWithIntegralType:index];
    return integralVC;
}



- (UIColor *)titleColorSelected {
    return kRGBA(37, 108, 255, 1.0);
}

- (UIColor *)titleColorNormal {
    return [UIColor grayColor];
}

- (WMMenuViewStyle)menuViewStyle {
    return WMMenuViewStyleLine;
}


- (UIColor *)menuBGColor {
    return [UIColor whiteColor];
}

- (CGFloat)menuHeight {
    return 35;
}

- (CGFloat)progressHeight {
    return 3;
}

- (CGRect)viewFrame {
    return CGRectMake(0, 200, kScreenW, kScreenH - 200);
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

- (UIView *)integralNumberView {
    if (!_integralNumberView) {
        _integralNumberView = [UIView new];
        [self.bigView addSubview:_integralNumberView];
        [_integralNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(160, 160));
            
        }];
        _integralNumberView.backgroundColor = kRGBA(43, 111, 254, 1.0);
        _integralNumberView.layer.cornerRadius = 80;
        _integralNumberView.clipsToBounds = YES;
        _integralNumberView.layer.borderWidth = 2;
        _integralNumberView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _integralNumberView;
}





- (UILabel *)integralNumberLb {
    if (!_integralNumberLb) {
        _integralNumberLb = [UILabel new];
        [self.integralNumberView addSubview:_integralNumberLb];
        [_integralNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(50);
            
        }];
        _integralNumberLb.font = [UIFont systemFontOfSize:35];
        _integralNumberLb.textColor = [UIColor whiteColor];
        _integralNumberLb.text = @"150";
    }
    return _integralNumberLb;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        [self.integralNumberView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.integralNumberLb.mas_bottom).equalTo(8);
        }];
        _label.font = [UIFont systemFontOfSize:18];
        _label.textColor = [UIColor whiteColor];
        _label.text = @"个积分";
    }
    return _label;
}


- (HZIntegralViewModel *)interalVM {
    if (!_interalVM) {
        _interalVM = [HZIntegralViewModel new];
    }
    return _interalVM;
}

@end
