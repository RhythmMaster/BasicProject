//
//  HZPicNetManager.h
//  dddd
//
//  Created by tang on 16/11/30.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZPicNetManager : NSObject

+ (id)getCertificatesViewCompletionHandler:(void(^)(id model, NSError *error))completionHandler;

@end
