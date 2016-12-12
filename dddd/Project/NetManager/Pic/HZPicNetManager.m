//
//  HZPicNetManager.m
//  dddd
//
//  Created by tang on 16/11/30.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPicNetManager.h"

@implementation HZPicNetManager

+ (id)getCertificatesViewCompletionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kHeadChangePath];
    return [self POST:path parameters:nil downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
