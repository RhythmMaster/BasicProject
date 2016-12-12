//
//  HZSuggestNetManager.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZSuggestNetManager.h"

@implementation HZSuggestNetManager

+ (id)getSuggestWithFeedbackReason:(NSString *)feedbackReason completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kAdvicefeedbackPath];
    NSDictionary *parameters = @{@"feedbackReason": feedbackReason};
    
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler(jsonObj, error);
    }];
}

@end
