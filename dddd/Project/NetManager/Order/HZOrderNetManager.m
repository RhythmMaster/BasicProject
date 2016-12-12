//
//  HZOrderNetManager.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderNetManager.h"

@implementation HZOrderNetManager


+ (id)getOrderWithOrderType:(OrderType)orderType page:(NSString *)page rows:(NSString *)rows completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = nil;
    switch (orderType) {
        case OrderTypeAll: {
            path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyAllOrderPath   ];
            break;
        }
        case OrderTypeOn: {
            path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyOnOrderPath];
            break;
        }
        case OrderTypeOver: {
            path = [NSString stringWithFormat:@"%@%@", kBasePath, kMyOverOrderPath];
            break;
        }
    }
    NSDictionary *parameters = @{@"page": page, @"rows": rows};
    return [self POST:path parameters:parameters downloadProgress:nil completionHandler:^(id jsonObj, NSError *error) {
        !completionHandler ?: completionHandler([HZOrderModel parseJSON:jsonObj], error);
    }];
    
}



@end
