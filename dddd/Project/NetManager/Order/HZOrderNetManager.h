//
//  HZOrderNetManager.h
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderModel.h"

typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeAll,
    OrderTypeOn,
    OrderTypeOver
};


@interface HZOrderNetManager : NSObject

+ (id)getOrderWithOrderType:(OrderType)orderType page:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;


@end
