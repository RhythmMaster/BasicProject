//
//  HZTimeTableViewViewModel.h
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZTimeTableNetManager.h"

@interface HZTimeTableViewViewModel : NSObject

- (void)getTimeTableWithDate:(NSString *)date completionHandler:(void(^)(NSError *error))completionHandler;

@property(nonatomic) HZTimeTableViewModel *timeTableViewModel;
@property(nonatomic) NSArray<HZTimeTableViewContentModel *> *timeViewContent;
@property(nonatomic) NSInteger number;

- (HZTimeTableViewContentModel *)getTimeTableViewContentMoelWithInex:(NSInteger)index;
- (BOOL)getIsEnalbleWithIndex:(NSInteger)index;
- (BOOL)getIsSelectedWithIndex:(NSInteger)index;
- (NSString *)getTimeWithIndex:(NSInteger)index;



@end
