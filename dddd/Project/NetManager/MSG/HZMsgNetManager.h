//
//  HZMsgNetManager.h
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZHomeModel.h"
#import "HZMsgModel.h"

@interface HZMsgNetManager : NSObject

//消息
+ (id)getMsgWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

//home
+ (id)getHomeWithPage:(NSString *)page rows:(NSString *)rows completionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
