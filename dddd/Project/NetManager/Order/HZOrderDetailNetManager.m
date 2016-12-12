//
//  HZOrderDetailNetManager.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderDetailNetManager.h"

@implementation HZOrderDetailNetManager

+ (id)getOrderDetatilWithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderDetailPath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderDetailModel parseJSON:jsonObj], error);
    }];
}


+ (id)getOrderDetatil11111WithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderDetailPath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


@end
