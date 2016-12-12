//
//  HZPersonalCenterNM.h
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZPersonalCenterModel.h"

@interface HZPersonalCenterNM : NSObject

//个人中心
+ (id)getPersonalCenterCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
+ (id)getPersonal11CenterCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
//签到
+ (id)getSignCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

//个人资料
+ (id)getPersonInfoCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
+ (id)getPersonInfo11CompletionHandler:(void (^)(id model, NSError * error))completionHandler;
//保存
+ (id)SavePersonInfoWithName:(NSString *)name sex:(NSString *)sex birthday:(NSString *)birthday address:(NSString *)address addressInfo:(NSString *)addreeeInfo serviceArea:(NSString *)serviceArea medicPostId:(NSString *)medicPostId goodAtField:(NSString *)goodAtField idCard:(NSString *)idCard alipay:(NSString *)alipay CompletionHandler:(void(^)(id model, NSError *error))completionHandler;


@end
