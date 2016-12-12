//
//  HZOrderOperateNetManager.m
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderOperateNetManager.h"

@implementation HZOrderOperateNetManager

+ (id)getFinishOrderWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kFinishorderPath];
    NSDictionary *parameters = @{@"address": address, @"addressXY": addressXY, @"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


+ (id)getStartServiceOrderWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kStartservicePath];
    NSDictionary *parameters = @{@"address": address, @"addressXY": addressXY, @"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}


+ (id)getOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kReceiveorderPath];
    NSDictionary *parameters = @{@"address": address, @"addressXY": addressXY, @"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getWaitRefuseorOrderWithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kWaitRefusePath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];

}


+ (id)getOrderOperationWithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kDeleteOrderPath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getRefuseOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY refuseReason:(NSString *)refuseReason refuseType:(NSString *)refuseType completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kRefuseorderPath];
    NSDictionary *parameters = @{@"address": address, @"addressXY": addressXY, @"orderId": ID, @"refuseReason": refuseReason, @"refuseType": refuseType};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getWaitCancelOrderWithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kWaitCancelPath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getCancelOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY refuseReason:(NSString *)refuseReason refuseType:(NSString *)refuseType completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kCancelorderPath];
    NSDictionary *parameters = @{@"address": address, @"addressXY": addressXY, @"orderId": ID, @"refuseReason": refuseReason, @"refuseType": refuseType};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];

}

+ (id)getToEvaluateOrderWithId:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kToEvaluateOrderPath];
    NSDictionary *parameters = @{@"orderId": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getEvaluateOrderWithId:(NSString *)ID synthesizeScore:(NSString *)synthesizeScore evaluateReason:(NSString *)evaluateReason completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kEvaluateOrderPath];
    NSDictionary *parameters = @{@"orderId": ID, @"synthesizeScore": synthesizeScore, @"evaluateReason": evaluateReason};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
