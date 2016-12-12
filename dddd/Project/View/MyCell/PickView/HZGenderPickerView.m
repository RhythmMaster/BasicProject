//
//  HZGenderPickerView.m
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZGenderPickerView.h"

@interface HZGenderPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    NSArray *provinceArr,*cityArr,*areaArr;
    NSArray *yijiArr, *erjiArr;
    
}



@property(nonatomic) UIView *pickerBackView;
@property(nonatomic) UIButton *cancleBtn;
@property(nonatomic) UIButton *sureBtn;
@property(nonatomic) UIPickerView *pickerView;
@property(nonatomic) NSMutableArray *array;
@property(nonatomic) UILabel *label;


@property(nonatomic) HZProfessionViewModel *professionVM;


@end

@implementation HZGenderPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self array];
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        self.backgroundColor = kRGBA(51, 51, 51, 0.8);
        
        self.pickerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH, kScreenW, 260 * hScale)];
        self.pickerBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerBackView];
        
        [self showPickerViewAnimation];
        
        //取消
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.pickerBackView addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(15);
            make.width.equalTo(30);
            make.height.equalTo(44);
        }];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancleBtn setTitleColor:kRGBA(0, 122, 255, 1) forState:UIControlStateNormal];
        //完成
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.pickerBackView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(0);
            make.right.equalTo(-15);
            make.width.equalTo(30);
            make.height.equalTo(44);
            
        }];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.sureBtn setTitleColor:kRGBA(0, 122, 255, 1) forState:UIControlStateNormal];
        
        //选择titi
        self.selectedLb = [UILabel new];
        [self.pickerBackView addSubview:self.selectedLb];
        [self.selectedLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.pickerBackView.mas_centerX);
            make.centerY.equalTo(self.sureBtn.mas_centerY);
            
        }];
        self.selectedLb.font = [UIFont systemFontOfSize:15];
        self.selectedLb.textAlignment = NSTextAlignmentCenter;
        
        //线
        UIView *line = [UIView new];
        [self.pickerBackView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.cancleBtn.mas_bottom);
            make.left.equalTo(0);
            make.width.equalTo(kScreenW);
            make.height.equalTo(0.5);
            
        }];
        line.backgroundColor = kRGBA(224, 224, 224, 1);
        
        
        
        //选择器
        self.pickerView = [UIPickerView new];
        [self.pickerBackView addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
            
        }];
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        
    }
    return self;
}

- (void)setCustomArr1:(NSArray *)customArr1 {
    _customArr1 = customArr1;
    [self.array addObject:customArr1];
}
- (void)setCustomArr2:(NSArray *)customArr2 {
    _customArr2 = customArr2;
    [self.array addObject:customArr2];
}

- (void)setArrayType:(ARRAYTYPE)arrayType
{
    _arrayType = arrayType;
    switch (arrayType) {
        case GenderArray:
        {
            self.selectedLb.text = @"选择性别";
            [self.array addObject:@[@"男",@"女"]];
        }
            break;
            
        case DeteArray:
        {
            self.selectedLb.text = @"选择出生年月";
            [self creatDate];
        }
            break;
        case AddressArray:
        {
            self.selectedLb.text = @"请选择地址";
            [self createAddress];
        }
            break;
        case ProfessionArray:
        {
            self.selectedLb.text = @"请选择职业";
            [self createProfession];
           

        }
            break;
        case HeightArray:
        {
            self.selectedLb.text = @"选择身高";
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 100; i <= 250; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [arr addObject:str];
            }
            [self.array addObject:(NSArray *)arr];
        }
            break;
        case weightArray:
        {
            self.selectedLb.text = @"选择体重";
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 30; i <= 200; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%d",i];
                [arr addObject:str];
            }
            [self.array addObject:(NSArray *)arr];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)creatDate {
    
    
    NSMutableArray *yearArray = [[NSMutableArray alloc] init];
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.array addObject:yearArray];
    
    NSMutableArray *monthArray = [[NSMutableArray alloc]init];
    for (int i = 1; i < 13; i ++) {
        
        [monthArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.array addObject:monthArray];
    
    NSMutableArray *daysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i < 32; i ++) {
        
        [daysArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.array addObject:daysArray];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    NSString *currentYear = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [self.pickerView selectRow:[yearArray indexOfObject:currentYear]+81*50 inComponent:0 animated:YES];
    
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    [self.pickerView selectRow:[monthArray indexOfObject:currentMonth]+12*50 inComponent:1 animated:YES];
    
//    [formatter setDateFormat:@"dd"];
//    NSString *currentDay = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
//    [self.pickerView selectRow:[daysArray indexOfObject:currentDay]+31*50 inComponent:2 animated:YES];
    
}

- (void)createAddress {
    NSLog(@"--------createAddress");
    provinceArr = [NSArray new];
    cityArr = [NSArray new];
    areaArr = [NSArray new];
    provinceArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cityArr = [[provinceArr objectAtIndex:0] objectForKey:@"cities"];
    areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
   
}

- (void)createProfession {
    [self.professionVM getProfessionWithCompletionHandler:^(NSError *error) {
        if (!error) {
            [self.pickerView reloadComponent:0];
        }
        [self createSelectedProfession];
    }];
    
}

- (void)createSelectedProfession {
    NSString *ID = [self.professionVM getIDWithIndex:0];
    [self.professionVM getSelectedWithID:ID completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            
            [self.pickerView reloadComponent:1];
        }
    }];

}



- (void)cancelBtnClick{
    NSString *fullStr = [NSString string];
    [self.delegate PickerSelectIndexTitle:fullStr ID:nil];
    [self hidePickerViewAnimation];
    
}

- (void)completeBtnClick{
    
    NSString *fullStr = [NSString string];
    if (self.arrayType == 3) {
        fullStr = [self.professionVM getSelectNameWithIndex:[self.pickerView selectedRowInComponent:1]];
        NSString *ID = [self.professionVM getSelectedIDWithIndex:[self.pickerView selectedRowInComponent:1]];
        NSLog(@"%@, %@", [self.professionVM getSelectedIDWithIndex:[self.pickerView selectedRowInComponent:1]], [self.professionVM getSelectNameWithIndex:[self.pickerView selectedRowInComponent:1]]);
        [self.delegate PickerSelectIndexTitle:fullStr ID:ID];
        [self hidePickerViewAnimation];
        return;
    }
    if (self.arrayType == AddressArray) {
        NSString *provenceStr = [[provinceArr objectAtIndex:[self.pickerView selectedRowInComponent:0]] objectForKey:@"state"];
        NSLog(@"%@", provenceStr);
        fullStr = [fullStr stringByAppendingString:provenceStr];
        NSString *cityStr = [[cityArr objectAtIndex:[self.pickerView selectedRowInComponent:1]] objectForKey:@"city"];
         NSLog(@"%@", cityStr);
        fullStr = [fullStr stringByAppendingString:cityStr];
        NSString *areaStr = [areaArr objectAtIndex:[self.pickerView selectedRowInComponent:2]];
        fullStr = [fullStr stringByAppendingString:areaStr];
        NSLog(@"%@", areaStr);
    }
    for (int i = 0; i < self.array.count; i++) {
        
        NSArray *arr = [self.array objectAtIndex:i];
        
        
        if (self.arrayType == DeteArray) {
            
            NSString *str = [arr objectAtIndex:[self.pickerView selectedRowInComponent:i]% arr.count];
            if (i != 2) {
                fullStr = [fullStr stringByAppendingString:str];
                fullStr = [fullStr stringByAppendingString:@"-"];
            } else {
                fullStr = [fullStr stringByAppendingString:str];
            }
            
        }else{
            
            NSString *str = [arr objectAtIndex:[self.pickerView selectedRowInComponent:i]];
            fullStr = [fullStr stringByAppendingString:str];
        }
        
        
    }
    NSLog(@"%@", fullStr);
    [self.delegate PickerSelectIndexTitle:fullStr ID:nil];
    
    [self hidePickerViewAnimation];
    
}


//显示动画
- (void)showPickerViewAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.pickerBackView.frame;
        frame.origin.y = kScreenH - 260 * hScale;
        self.pickerBackView.frame = frame;
    }];
}
//隐藏动画
- (void)hidePickerViewAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.pickerBackView.frame;
        frame.origin.y = kScreenH;
        self.pickerBackView.frame = frame;
    } completion:^(BOOL finished) {
        [self.pickerBackView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSString *fullStr = [NSString string];
    [self.delegate PickerSelectIndexTitle:fullStr ID:nil];
    [self hidePickerViewAnimation];
    
}
#pragma mark delete
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_arrayType == 3) {
        return 2;
    }
    if (_arrayType == 2) {
        return 3;
    }
    return self.array.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.arrayType == 3) {
        if (component == 0) {
            return 2;
        } else {
            return self.professionVM.number;
        }
    }
    if (self.arrayType == AddressArray){
        if (component == 0) {
            return [provinceArr count];
        } else if (component == 1) {
            return [cityArr count];
        } else {
            return [areaArr count];
        }
        
    } else {
        NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
        if (self.arrayType == DeteArray) {
            
            return arr.count*100;
            
        } else {
            return arr.count;
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    _label=[[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    if (_arrayType == DeteArray) {
        _label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
        if (component == 0) {
            _label.text = [NSString stringWithFormat:@"%@年", [self pickerView:pickerView titleForRow:row forComponent:component]];
        } else if (component == 1) {
            _label.text = [NSString stringWithFormat:@"%@月", [self pickerView:pickerView titleForRow:row forComponent:component]];
        } else {
            _label.text = [NSString stringWithFormat:@"%@日", [self pickerView:pickerView titleForRow:row forComponent:component]];
        }
        
    } else {
        _label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    
    return _label;
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_arrayType == ProfessionArray) {
        
        if (component == 0) {
            NSString *name = [[[self.professionVM.yijiModel objectForKey:@"CONTENT"] objectAtIndex:row] objectForKey:@"name"];
            
            return name;
        } else if (component == 1) {
            
            return [[[self.professionVM.selectedModel objectForKey:@"CONTENT"] objectAtIndex:row] objectForKey:@"name"];
        }
        return nil;
        
    } else if (_arrayType == AddressArray) {
        
        if (component == 0) {
            return [[provinceArr objectAtIndex:row] objectForKey:@"state"];
        } else if (component == 1) {
            return [[cityArr objectAtIndex:row] objectForKey:@"city"];
        } else {
            return [areaArr objectAtIndex:row];
        }
        
    } else {
        NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
        return [arr objectAtIndex:row % arr.count];
    }
    
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.arrayType == DeteArray || self.arrayType == AddressArray) {
        
        return 70;
        
    }else{
        
        return 110;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (_arrayType == AddressArray) {
        
        if (component==0) {
            
            cityArr = [[provinceArr objectAtIndex:row] objectForKey:@"cities"];
            
            [pickerView selectRow:0 inComponent:1 animated:NO];
            
            [self.pickerView reloadComponent:1];
            
            if ([cityArr count]!=0) {
                
                areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
                
                [pickerView selectRow:0 inComponent:2 animated:NO];
                
                [self.pickerView reloadComponent:2];
                
                
                
            }
            
        }
        
        else if (component==1) {
            
            areaArr = [[cityArr objectAtIndex:row] objectForKey:@"areas"];
            
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            [self.pickerView reloadComponent:2];
            
        }
        
    }
    if (_arrayType == 3) {
        if (component == 0) {
            NSString *ID = [self.professionVM getIDWithIndex:row];
            [self.professionVM getSelectedWithID:ID completionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    [pickerView selectRow:0 inComponent:1 animated:NO];
                    
                    [self.pickerView reloadComponent:1];

                }
            }];
        }
    }
    
    
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray new];
    }
    return _array;
}

- (HZProfessionViewModel *)professionVM {
    if (!_professionVM) {
        _professionVM = [HZProfessionViewModel new];
    }
    return _professionVM;
}

@end
