//
//  HZIntegralNetManager.h
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZIntegralModel.h"

typedef NS_ENUM(NSUInteger, IntegralType) {
    IntegralTypeAll,
    IntegralTypeOn,
    IntegralTypeOver
};

@interface HZIntegralNetManager : NSObject

+ (id)getMyIntegralWithIntegralType:(IntegralType)integralType page:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

+ (id)getIntegrationRuleWithCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
