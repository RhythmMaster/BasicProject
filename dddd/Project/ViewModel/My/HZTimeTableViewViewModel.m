//
//  HZTimeTableViewViewModel.m
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableViewViewModel.h"

@implementation HZTimeTableViewViewModel

- (NSArray<HZTimeTableViewContentModel *> *)timeViewContent {
    if (!_timeViewContent) {
        _timeViewContent = [NSArray new];
    }
    return _timeViewContent;
}

- (void)getTimeTableWithDate:(NSString *)date completionHandler:(void (^)(NSError *))completionHandler {
    [HZTimeTableNetManager getServiceTimeViewWithData:date completionHandler:^(HZTimeTableViewModel *model, NSError *error) {
        if (!error) {
            self.timeViewContent = model.content;
            self.timeTableViewModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (HZTimeTableViewContentModel *)getTimeTableViewContentMoelWithInex:(NSInteger)index {
    return self.timeTableViewModel.content[index];
}


- (BOOL)getIsEnalbleWithIndex:(NSInteger)index {
    //return self.timeViewContent[index].isEnable;
    return [self getTimeTableViewContentMoelWithInex:index].isEnable;
}

- (BOOL)getIsSelectedWithIndex:(NSInteger)index {
    //return self.timeViewContent[index].isSelected;
    return [self getTimeTableViewContentMoelWithInex:index].isSelected;
}
- (NSString *)getTimeWithIndex:(NSInteger)index {
   // return self.timeViewContent[index].time;
    return [self getTimeTableViewContentMoelWithInex:index].time;
}

@end
