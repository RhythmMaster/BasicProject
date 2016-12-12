//
//  HZTimeTableVC.m
//  dddd
//
//  Created by NSX443 on 16/11/10.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableVC.h"
#import "HZTimeTableBtn.h"
#import "HZTimeTableView.h"
#import "HZTimeTableBtn.h"
#import "HZTimeTableCell.h"

@interface HZTimeTableVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>


@property(nonatomic) UICollectionView *collectionView;

@property(nonatomic) UIScrollView *scrollView;

@property(nonatomic) UIView *collectionBackView;

@property(nonatomic) CGFloat collectionWidth;


@property(nonatomic) HZTimeTableViewViewModel *tableViewVM;

@property(nonatomic) BOOL isEdit;

@property(nonatomic) HZTimeTableBtn *isSelectedBtn;


@end
static NSString * CellIdentifier = @"UICollectionViewCell";
@implementation HZTimeTableVC

- (instancetype)init {
    if (self = [super init]) {
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    HZisClickBtn *rightBtn = [HZisClickBtn buttonWithType:UIButtonTypeCustom];
    [rightView addSubview:rightBtn];
    rightBtn.frame = CGRectMake(0, 0, 34, 34);
    rightBtn.tag = 400;
    _isEdit = NO;
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.isClicked = NO;
    [rightBtn addTarget:self action:@selector(isEditClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    [self.tableViewVM getTimeTableWithDate:dateString completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [self.collectionView reloadData];
        }
    }];
    
    
    self.view.backgroundColor = kRGBA(234, 234, 234, 1.0);
    [self collectionView];
    
    [self scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark method
- (void)isEditClick:(HZisClickBtn *)sender {
    sender.isClicked = !sender.isClicked;
    if (sender.isClicked == YES) {
        [sender setTitle:@"保存" forState:UIControlStateNormal];
        _isEdit = YES;
    } else {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        
        
        NSString *timePoint;
        for (int i = 0; i < 13; i++) {
            HZisClickBtn *btn = (HZisClickBtn *)[self.view viewWithTag:i + 200];
            if (btn.isFree == YES) {
                if (timePoint == nil) {
                    timePoint = btn.titleLabel.text;
                } else {
                timePoint = [NSString stringWithFormat:@"%@,%@", timePoint, btn.titleLabel.text];
                    
                }
            }
            
        }
        NSLog(@"%ld", self.isSelectedBtn.tag);
        NSLog(@"%@", timePoint);
        NSString *date = self.isSelectedBtn.dateStr;
        NSLog(@"%@", date);
        
        
        [HZTimeTableNetManager getMedicServiceTimeWithDate:date timePoint:timePoint completionHandler:^(id model, NSError *error) {
            if (error) {
                NSLog(@"11111111%@", error);
            } else {
                NSString *msg = [model objectForKey:@"MSG"];
                [self.view showWarning:msg];
            }
        }];
        
        
        
        _isEdit = NO;

        
        
    }
}

- (NSString *)getWeekWithNowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:nowDate];
//    NSInteger year=[comps year];
//    NSInteger week = [comps weekday];
//    NSInteger month = [comps month];
//    NSInteger day = [comps day];
//    NSInteger hour = [comps hour];
//    NSInteger min = [comps minute];
//    NSInteger sec = [comps second];
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    
    return [arrWeek objectAtIndex:[comps weekday] - 1];
}

- (void)setBtn {
    //CGFloat width = (kScreenW -5 * 10) / 4;
    CGFloat viewWidth = kScreenW / 4;
    //HZTimeTableBtn *lastBtn = nil;
    UIView *lastVeiw = nil;
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDate* theDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [dateFormatter1 setDateFormat:@"MM/dd"];
    
    
    

    for (int i = 0; i < 14; i++) {
        
        UIView *tableView= [UIView new];
        [_scrollView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(viewWidth);
            make.height.equalTo(88);
            make.centerY.equalTo(0);
            make.top.equalTo(0);
            if (i == 0) {
                make.left.equalTo(1);
            } else {
                make.left.equalTo(lastVeiw.mas_right).equalTo(0);
            }
        }];
        
        lastVeiw = tableView;
        
        HZTimeTableBtn *tableBtn = [HZTimeTableBtn buttonWithType:UIButtonTypeCustom];
        [tableView addSubview:tableBtn];
        [tableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(0);
            make.size.equalTo(CGSizeMake(80, 55));
            
        }];
        if (i == 0) {
            tableBtn.layer.borderWidth = 0.5;
            tableBtn.layer.borderColor = kGrayColor.CGColor;
            tableBtn.layer.cornerRadius = 25;
            tableBtn.clipsToBounds = YES;
            tableBtn.backgroundColor = [UIColor blueColor];
            tableBtn.dayLb.textColor = [UIColor whiteColor];
            self.isSelectedBtn = tableBtn;
        }
        
        
        
        if(i!=0)
        {
            NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
            
            theDate = [currentDate initWithTimeIntervalSinceNow: +oneDay * i];
            
        }
        else
        {
            theDate = currentDate;
        }
        
        
        NSString *dateStr = [dateFormatter1 stringFromDate:theDate];
        
        tableBtn.dataLb.text = dateStr;
        if (i == 0) {
            tableBtn.dayLb.text = @"今天";
        } else {
            tableBtn.dayLb.text = [self getWeekWithNowDate:theDate];
        }
        NSString *dateString = [dateFormatter stringFromDate:theDate];
        tableBtn.dateStr = dateString;
        tableBtn.tag = i + 100;
        [tableBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
}


- (void)btnClick:(HZTimeTableBtn *)sender {

    self.isSelectedBtn = sender;
    NSLog(@"%ld", sender.tag);
    for (int i = 0; i < 14; i++) {
        HZTimeTableBtn *btn = (HZTimeTableBtn *)[self.view viewWithTag:i + 100];
        btn.layer.borderWidth = 0;
        btn.backgroundColor = [UIColor whiteColor];
        btn.dayLb.textColor = [UIColor blackColor];
        if (sender.tag == btn.tag) {
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = kGrayColor.CGColor;
            btn.layer.cornerRadius = 25;
            btn.clipsToBounds = YES;
            btn.backgroundColor = [UIColor blueColor];
            btn.dayLb.textColor = [UIColor whiteColor];
            
        }
        
        
    }
    
    NSString *date = sender.dateStr;
    [self.tableViewVM getTimeTableWithDate:date completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [self.collectionView reloadData];
        }
    }];
    
    
}
- (void)timeBtn:(HZisClickBtn *)sender {
    
    if (_isEdit) {
        if ([self.tableViewVM getIsEnalbleWithIndex:sender.tag - 200]) {
            NSLog(@"%ld", sender.tag);
            
            for (int i = 0; i < 13; i++) {
                UIButton *btn = (UIButton *)[self.view viewWithTag:i + 200];
                if (sender.tag == btn.tag) {
                    if ([self.tableViewVM getIsSelectedWithIndex: sender.tag - 200] == YES) {
                        if (sender.isClicked == NO) {
                            sender.backgroundColor = [UIColor whiteColor];
                            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            sender.isClicked = YES;
                            sender.isFree = NO;
                        } else {
                            sender.backgroundColor = [UIColor blueColor];
                            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            sender.isFree = YES;
                            sender.isClicked = NO;
                        }
                    } else {
                        if (sender.isClicked == NO) {
                            sender.backgroundColor = [UIColor blueColor];
                            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            sender.isClicked = YES;
                            sender.isFree = YES;
                        } else {
                            sender.backgroundColor = [UIColor whiteColor];
                            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            sender.isFree = NO;
                            sender.isClicked = NO;
                        }
                    }
                    return;
                }
            }
        }
        
    } else {
        [self.view showWarning:@"请选择编辑模式"];
    }
    
    NSLog(@"点这个没用");

}


#pragma mark delete
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 13;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    HZisClickBtn *btn = [HZisClickBtn buttonWithType:UIButtonTypeCustom];
    [cell.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(_collectionWidth, _collectionWidth));
    }];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = kGrayColor.CGColor;
    btn.layer.cornerRadius = _collectionWidth * 0.5;
    btn.clipsToBounds = YES;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:[self.tableViewVM getTimeWithIndex:indexPath.row] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    NSLog(@"%@", [self.tableViewVM getTimeWithIndex:indexPath.row]);
    btn.tag = indexPath.row + 200;
    btn.isClicked = NO;
    btn.isFree = NO;
    if ([self.tableViewVM getIsEnalbleWithIndex:indexPath.row]) {
        if ([self.tableViewVM getIsSelectedWithIndex:indexPath.row]) {
            btn.backgroundColor = [UIColor blueColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.isFree = YES;
        }
       // btn.backgroundColor = [UIColor blueColor];
    }
    [btn addTarget:self action:@selector(timeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:btn];
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _collectionWidth = (kScreenW - 3*8 - 5*16 - 16) / 4;
    return CGSizeMake(_collectionWidth, _collectionWidth);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}





#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
//    
//    for (int i = 0; i < 13; i++) {
//        cell.backgroundColor = [UIColor whiteColor];
//        if (indexPath.row == i) {
//            cell.backgroundColor = [UIColor greenColor];
//        }
//        //[_collectionView reloadData];
//    }
//    
    UILabel *label = (UILabel *)[self.view viewWithTag:indexPath.row + 200];
    label.backgroundColor = [UIColor blueColor];
    
    
    NSLog(@"row=======%ld",indexPath.row);
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        
        return footerView;
    }
    
    return nil;
}



#pragma mark -懒加栽
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];;
        //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenW - 16, kScreenH - 88 - 8) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        [self.collectionBackView addSubview:self.collectionView];
        
    }
    return _collectionView;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 88)];
        [self.view addSubview:_scrollView];
        
        [self setBtn];
        
        //设置上下左右多出来看
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //想要展示的内容的大小
        _scrollView.contentSize = CGSizeMake(4 * kScreenW, 88);
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        //        UIView *lineView = [UIView new];
        //        lineView.frame = CGRectMake(0, 88, kScreenW, 1);
        //        lineView.backgroundColor = kGrayColor;
        //        [self.view addSubview:lineView];
        
    }
    return _scrollView;
}


- (UIView *)collectionBackView {
    if (!_collectionBackView) {
        _collectionBackView = [UIView new];
        [self.view addSubview:_collectionBackView];
        [_collectionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(100);
            make.left.equalTo(8);
            make.right.bottom.equalTo(-8);
            
        }];
        _collectionBackView.backgroundColor = [UIColor whiteColor];
        
        _collectionBackView.layer.cornerRadius = 10;
        _collectionBackView.clipsToBounds = YES;
        
        
        
        UIView *timeView = [UIView new];
        [_collectionBackView addSubview:timeView];
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(40);
        }];
        
        
        UIImageView *clockImg = [UIImageView new];
        [timeView addSubview:clockImg];
        [clockImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(8);
        }];
        clockImg.image = [UIImage imageNamed:@"10"];
        
        UILabel *timeLb = [UILabel new];
        [timeView addSubview:timeLb];
        [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(clockImg.mas_right).equalTo(10);
        }];
        timeLb.text = @"时间";
        timeLb.font = [UIFont systemFontOfSize:14];
        
        
        UIView *lineView = [UIView new];
        [_collectionBackView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(40);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = kGrayColor;
        
        
    }
    return _collectionBackView;
}

- (HZTimeTableViewViewModel *)tableViewVM {
    if (!_tableViewVM) {
        _tableViewVM = [HZTimeTableViewViewModel new];
    }
    return _tableViewVM;
}







@end
