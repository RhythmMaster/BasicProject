//
//  HZServicesCell.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZServicesCell.h"

@implementation HZServicesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier count:(NSInteger)count {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.count = count;
        [self labelArr];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (NSArray<HZOrderDetailView *> *)labelArr {
    NSLog(@"%ld", _count);
    if (!_labelArr) {
        _labelArr = [NSArray new];
        NSMutableArray *tmpArr = [NSMutableArray new];
        HZOrderDetailView *lastView = nil;
        for (int i = 0; i < 10; i++) {
            HZOrderDetailView *serviceView = [HZOrderDetailView new];
            [self.contentView addSubview:serviceView];
            [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(0);
                make.height.equalTo(32);
                if (i == 0) {
                    make.top.equalTo(0);
                } else {
                    make.top.equalTo(lastView.mas_bottom).equalTo(0);
                }
                
            }];
            
            lastView = serviceView;
            [tmpArr addObject:serviceView];
            
        }
        _labelArr = tmpArr.copy;
    }
    return _labelArr;
}



@end
