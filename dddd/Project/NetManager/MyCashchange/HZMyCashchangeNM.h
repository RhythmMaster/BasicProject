//
//  HZMyCashchangeNM.h
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMyCashchange.h"

@interface HZMyCashchangeNM : NSObject

//余额
+ (id)getMyCashchangeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
