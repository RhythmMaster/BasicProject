//
//  HZOrderDetailModel.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderDetailModel.h"

@implementation HZOrderDetailModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allCount": @"ALLCOUNT",
             @"addressInfo": @"CONTENT.INFO.address_info",
             @"age": @"CONTENT.INFO.age",
             @"appointmentTime": @"CONTENT.INFO.appointment_time",
             @"countDown": @"CONTENT.INFO.countDown",
             @"createTime": @"CONTENT.INFO.create_time",
             @"desc": @"CONTENT.INFO.description",
             @"evaluateTime": @"CONTENT.INFO.evaluateTime",
             @"finishServiceTime": @"CONTENT.INFO.finishServiceTime",
             @"ID": @"CONTENT.INFO.id",
             @"idCard": @"CONTENT.INFO.idcard",
             @"isEvaluate": @"CONTENT.INFO.isEvaluate",
             @"itemCase": @"CONTENT.INFO.itemCase",
             @"itemServiceCase": @"CONTENT.INFO.itemServiceCase",
             @"itemClassifyName": @"CONTENT.INFO.item_classify_name",
             @"itemName": @"CONTENT.INFO.item_name",
             @"medicareCard": @"CONTENT.INFO.medicare_card",
             @"payMoney": @"CONTENT.INFO.pay_money",
             @"name": @"CONTENT.INFO.name",
             @"orderRevenue": @"CONTENT.INFO.orderRevenue",
             @"orderCode": @"CONTENT.INFO.order_code",
             @"orderMoney": @"CONTENT.INFO.order_money",
             @"orderStatus": @"CONTENT.INFO.order_status",
             @"patientConfirmTime": @"CONTENT.INFO.patientConfirmTime",
             @"payMoney": @"CONTENT.INFO.pay_money",
             @"personName": @"CONTENT.INFO.person_name",
             @"personSex": @"CONTENT.INFO.person_sex",
             @"platformServicePrice": @"CONTENT.INFO.platformServicePrice",
             @"receiveTime": @"CONTENT.INFO.receive_time",
             @"serviceHotline": @"CONTENT.INFO.serviceHotline",
             @"serviceTime": @"CONTENT.INFO.serviceTime",
             @"sex": @"CONTENT.INFO.sex",
             @"tel": @"CONTENT.INFO.tel",
             @"list": @"CONTENT.LIST",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE",
             @"head": @"CONTENT.INFO.head"};
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{@"list": [HZOrderDetailListModel class]};
}

@end

@implementation HZOrderDetailListModel


@end