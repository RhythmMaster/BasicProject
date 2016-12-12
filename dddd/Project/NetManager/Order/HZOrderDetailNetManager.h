//
//  HZOrderDetailNetManager.h
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderDetailModel.h"

@interface HZOrderDetailNetManager : NSObject

+ (id)getOrderDetatilWithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;
+ (id)getOrderDetatil11111WithId:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;
@end
