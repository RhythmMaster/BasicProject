//
//  HZTimeTableViewModel.h
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZTimeTableViewContentModel;

@interface HZTimeTableViewModel : NSObject

@property(nonatomic) NSString *allCount;
@property(nonatomic) NSArray<HZTimeTableViewContentModel *> *content;
@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger retype;
@property(nonatomic) BOOL state;

@end

@interface HZTimeTableViewContentModel : NSObject

@property(nonatomic) BOOL isEnable;
@property(nonatomic) BOOL isSelected;
@property(nonatomic) NSString *time;

@end
