//
//  HZMyCashchange.m
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyCashchange.h"

@implementation HZMyCashchange

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"acccount": @"ALLCOUNT",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}

+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZMyCashchangeContent class]};
}

@end


@implementation HZMyCashchangeContent

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"changeType": @"change_type",
             @"cashReserve": @"cash_reserve",
             @"realityMoney": @"reality_money",
             @"createDate": @"create_date"};
}

@end