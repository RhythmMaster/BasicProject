//
//  HZMyevaluateNetManager.h
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMyEvaluateModel.h"

@interface HZMyevaluateNetManager : NSObject

+ (id)getMyevaluateWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
