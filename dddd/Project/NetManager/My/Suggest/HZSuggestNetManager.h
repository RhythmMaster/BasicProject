//
//  HZSuggestNetManager.h
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZSuggestNetManager : NSObject

+ (id)getSuggestWithFeedbackReason:(NSString *)feedbackReason completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
