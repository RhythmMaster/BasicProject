//
//  HZMsgNetManager.m
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMsgNetManager.h"

@implementation HZMsgNetManager

+ (id)getMsgWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyMsgPath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        //!completionHandler ?: completionHandler([HZHomeModel parseJSON:jsonObj], error);
        !completionHandler ?: completionHandler([HZMsgModel parseJSON:jsonObj], error);
    }];
}

+ (id)getHomeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kOrderMsgPath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZHomeModel parseJSON:jsonObj], error);
        //!completionHandler ?: completionHandler(jsonObj, error);
    }];
    
}

@end
