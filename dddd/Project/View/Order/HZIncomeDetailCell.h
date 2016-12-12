//
//  HZIncomeDetailCell.h
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZIncomeDetailCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier count:(NSInteger)count;

@property(nonatomic) NSArray<UILabel *> *labelArr;
@property(nonatomic) NSInteger count;

@end
