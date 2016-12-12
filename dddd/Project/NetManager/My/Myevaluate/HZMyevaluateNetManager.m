//
//  HZMyevaluateNetManager.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyevaluateNetManager.h"

@implementation HZMyevaluateNetManager

+ (id)getMyevaluateWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyevaluatePath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {

        
       !completionHandler ?: completionHandler([HZMyEvaluateModel parseJSON:jsonObj], error);
    }];
}

@end
