//
//  HZLoginAndRegisterModel.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZLoginAndRegisterModel.h"

@implementation HZLoginAndRegisterModel

+ (NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allcount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}


@end
