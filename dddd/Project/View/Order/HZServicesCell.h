//
//  HZServicesCell.h
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZOrderDetailView.h"

@interface HZServicesCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier count:(NSInteger)count;

@property(nonatomic) NSArray<HZOrderDetailView *> *labelArr;
@property(nonatomic) NSInteger count;

@end
