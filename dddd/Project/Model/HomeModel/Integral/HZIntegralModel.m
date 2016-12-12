//
//  HZIntegralModel.m
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIntegralModel.h"

@implementation HZIntegralModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allCount": @"ALLCOUNT ",
             @"integralReserve": @"CONTENT.INFO.integralReserve",
             @"list": @"CONTENT.LIST",
             @"msg": @"MSG",
             @"reType": @"RETTYPE",
             @"state": @"STATE",};
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{@"list": [HZIntegralListModel class]};
}

@end

@implementation HZIntegralListModel
+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"changeType": @"change_type",
             @"createTime": @"create_date",
             @"integralNumber": @"integral_number"};
}


@end
