//
//  HZPersonalCenterModel.m
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZPersonalCenterModel.h"

@implementation HZPersonalCenterModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allcount": @"ALLCOUNT",
             @"address": @"CONTENT.address",
             @"addressInfo": @"CONTENT.addressInfo",
             @"alipay": @"CONTENT.alipay",
             @"birthday": @"CONTENT.birthday",
             @"goodAtField": @"CONTENT.goodAtField",
             @"ID": @"CONTENT.id",
             @"idCard": @"CONTENT.idCard",
             @"serviceArea": @"CONTENT.serviceArea",
             @"sex": @"CONTENT.sex",
             @"cashReserve": @"CONTENT.cashReserve",
             @"head": @"CONTENT.head",
             @"integralReserve": @"CONTENT.integralReserve",
             @"isSign": @"CONTENT.isSign",
             @"medicPostId": @"CONTENT.medicPostId",
             @"medicPostName": @"CONTENT.medicPostName",
             @"name": @"CONTENT.name",
             @"serviceHotline": @"CONTENT.serviceHotline",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"
             };
}

@end
