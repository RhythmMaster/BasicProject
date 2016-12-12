//
//  HZMyCashchangeNM.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyCashchangeNM.h"

@implementation HZMyCashchangeNM


+ (id)getMyCashchangeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kmyCashchangePath];
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZMyCashchange parseJSON:jsonObj], error);
    }];
}


@end
