//
//  HZIntegralNetManager.m
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIntegralNetManager.h"

@implementation HZIntegralNetManager

+ (id)getMyIntegralWithIntegralType:(IntegralType)integralType page:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = nil;
    switch (integralType) {
        case IntegralTypeAll:
             path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyintegralPath];
            break;
        case IntegralTypeOn:
            path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyintegraladdPath];
            break;
        case IntegralTypeOver:
            path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyintegraloutPath];
            break;
       
    }
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZIntegralModel parseJSON:jsonObj], error);
    }];
}
+ (id)getIntegrationRuleWithCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kIntegrationRulePath];
    return [self POST:path parameters:nil
     downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
     }];
}


@end
