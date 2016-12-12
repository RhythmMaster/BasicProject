//
//  HZPersonalCenterNM.m
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPersonalCenterNM.h"

@implementation HZPersonalCenterNM

+ (id)getPersonalCenterCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kPersonalCenterPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZPersonalCenterModel parseJSON:jsonObj], error);
    }];
}
+ (id)getPersonal11CenterCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kPersonalCenterPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getSignCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kSignPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}



+ (id)getPersonInfoCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, KPersonalInfoPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZPersonalCenterModel parseJSON:jsonObj], error);
    }];
}
+ (id)getPersonInfo11CompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, KPersonalInfoPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)SavePersonInfoWithName:(NSString *)name sex:(NSString *)sex birthday:(NSString *)birthday address:(NSString *)address addressInfo:(NSString *)addreeeInfo serviceArea:(NSString *)serviceArea medicPostId:(NSString *)medicPostId goodAtField:(NSString *)goodAtField idCard:(NSString *)idCard alipay:(NSString *)alipay CompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kPersonalInfoSavePath];
    NSDictionary *parameters = @{@"name": name, @"sex": sex, @"birthday": birthday, @"address": address, @"addressInfo": addreeeInfo, @"serviceArea": serviceArea, @"medicPostId": medicPostId, @"goodAtField": goodAtField, @"idcard": idCard, @"alipay": alipay};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}




@end
