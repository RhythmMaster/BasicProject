//
//  HZGetCodeNM.h
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZLoginAndRegisterModel.h"

@interface HZGetCodeNM : NSObject
//获取验证码
+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber completionHandler:(void(^)(id model, NSError *error))completionHandler;
//注册
+ (id)getRandomCodeWithUUID:(NSString *)UUID phoneNumber:(NSString *)phoneNumber codeNumber:(NSString *)codeNumber password:(NSString *)password completionHandler:(void(^)(id model, NSError *error))completionHandler;
//登录
+ (id)getLoginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completionHandler:(void(^)(id model, NSError *error))completionHandler;

+ (id)logoutCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

//忘记密码
+ (id)forgetPasswordWithPhone:(NSString *)phone userPass:(NSString *)userPass randomCode:(NSString *)randomCode completionHandler:(void(^)(id model, NSError *error))completionHandler;


@end
