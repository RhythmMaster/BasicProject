//
//  HZTimeTableNetManager.m
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableNetManager.h"

@implementation HZTimeTableNetManager

+ (id)getServiceTimeViewWithData:(NSString *)data completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kServiceTimeViewPath];
    NSDictionary *parameters = @{@"date": data};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZTimeTableViewModel parseJSON:jsonObj], error);
    }];
}


+ (id)getMedicServiceTimeWithDate:(NSString *)date timePoint:(NSString *)timePoint completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kServiceTimePath];
    NSDictionary *parameters = @{@"date": date, @"timePoint": timePoint};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


@end
