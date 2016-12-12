//
//  HZGenderPickerView.h
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HZProfessionViewModel.h"

@protocol HZGenderPickerDelegate <NSObject>
@optional;
- (void)PickerSelectIndexTitle:(NSString *)title ID:(NSString *)ID;

@end

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    GenderArray,
    DeteArray,
    AddressArray,
    ProfessionArray,
    weightArray,
    HeightArray
};

@interface HZGenderPickerView : UIView

@property(nonatomic) UILabel *selectedLb;
@property(nonatomic, assign) id<HZGenderPickerDelegate> delegate;
@property (nonatomic, strong) NSArray *customArr1;
@property (nonatomic, strong) NSArray *customArr2;
@property (nonatomic, assign) ARRAYTYPE arrayType;
@end
