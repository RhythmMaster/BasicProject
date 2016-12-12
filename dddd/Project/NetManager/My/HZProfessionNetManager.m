//
//  HZProfessionNetManager.m
//  dddd
//
//  Created by tang on 16/11/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZProfessionNetManager.h"

@implementation HZProfessionNetManager



+ (id)getMedicPostCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMedicPostPath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
       !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

+ (id)getSelectMedicPostWithID:(NSString *)ID completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kSelectMedicPostPath];
    NSDictionary *parameters = @{@"id": ID};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}







@end
