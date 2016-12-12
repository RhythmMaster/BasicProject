//
//  HZMyEvaluateModel.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyEvaluateModel.h"

@implementation HZMyEvaluateModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allCount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZMyEvaluateContentModel class]};
}
@end
@implementation HZMyEvaluateContentModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"evaluateReason": @"evaluate_reason",
             @"evaluateTime": @"evaluate_time",
             @"ID": @"id",
             @"medicID": @"medic_id",
             @"nickName": @"nickname",
             @"orderId": @"order_id",
             @"synthesizeScore": @"synthesize_score"};
}

@end
