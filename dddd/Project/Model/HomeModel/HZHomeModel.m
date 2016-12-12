//
//  HZHomeModel.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZHomeModel.h"

@implementation HZHomeModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allcount": @"ALLCOUNT",
             @"caseCount": @"CONTENT.INFO.caseCount",
             @"head": @"CONTENT.INFO.head",
             @"isSign": @"CONTENT.INFO.isSign",
             @"msgCount": @"CONTENT.INFO.msgCount",
             @"name": @"CONTENT.INFO.name",
             @"receiveOrderCount": @"CONTENT.INFO.receiveOrderCount",
             @"serviceCount": @"CONTENT.INFO.serviceCount",
             @"list": @"CONTENT.LIST",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"list": [HZHomeListModel class]};
}


@end

@implementation HZHomeListModel

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




