//
//  HZOrderModel.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderModel.h"

@implementation HZOrderModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allcount": @"ALLCOUNT",
             @"msg": @"MSG",
             @"content": @"CONTENT",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZOrderContentModel class]};
}

@end


@implementation HZOrderContentModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"addressInfo": @"address_info",
             @"age": @"age",
             @"appointmentTime": @"appointment_time",
             @"birthday": @"birthday",
             @"createTime": @"create_time",
             @"evaluateTime": @"evaluateTime",
             @"ID": @"id",
             @"isEvaluate": @"isEvaluate",
             @"itemClassifyName": @"item_classify_name",
             @"itemId": @"item_id",
             @"itemName": @"item_name",
             @"name": @"name",
             @"orderRevenue": @"orderRevenue",
             @"orderServices": @"orderServices",
             @"orderMoney": @"order_money",
             @"orderStatus": @"order_status",
             @"orderStatusCode": @"order_statusCode",
             @"orderStatusName": @"order_statusName",
             @"personName": @"person_name",
             @"sex": @"sex",
             @"tel": @"tel"};
}

@end