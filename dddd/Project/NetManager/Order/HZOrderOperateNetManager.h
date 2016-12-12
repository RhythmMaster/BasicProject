//
//  HZOrderOperateNetManager.h
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface HZOrderOperateNetManager : NSObject
//确认接单
+ (id)getOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void(^)(id model, NSError *error))completionHandler;
//待拒绝订单
+ (id)getWaitRefuseorOrderWithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;
//拒绝订单
+ (id)getRefuseOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY refuseReason:(NSString *)refuseReason refuseType:(NSString *)refuseType completionHandler:(void(^)(id model, NSError *error))completionHandler;

//开始服务
+ (id)getStartServiceOrderWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void(^)(id model, NSError *error))completionHandler;
//待取消订单
+ (id)getWaitCancelOrderWithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;
//取消订单
+ (id)getCancelOrderOperationWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY refuseReason:(NSString *)refuseReason refuseType:(NSString *)refuseType completionHandler:(void(^)(id model, NSError *error))completionHandler;
//完成服务
+ (id)getFinishOrderWithId:(NSString *)ID address:(NSString *)address addressXY:(NSString *)addressXY completionHandler:(void(^)(id model, NSError *error))completionHandler;
//带评价
+ (id)getToEvaluateOrderWithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;
//订单评价
+ (id)getEvaluateOrderWithId:(NSString *)ID synthesizeScore:(NSString *)synthesizeScore evaluateReason:(NSString *)evaluateReason completionHandler:(void(^)(id model, NSError *error))completionHandler;
//删除订单
+ (id)getOrderOperationWithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
