//
//  HZTimeTableNetManager.h
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZTimeTableViewModel.h"

@interface HZTimeTableNetManager : NSObject

+ (id)getServiceTimeViewWithData:(NSString *)data completionHandler:(void(^)(id model, NSError *error))completionHandler;

+ (id)getMedicServiceTimeWithDate:(NSString *)date timePoint:(NSString *)timePoint completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
