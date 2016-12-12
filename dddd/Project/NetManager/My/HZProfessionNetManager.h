//
//  HZProfessionNetManager.h
//  dddd
//
//  Created by tang on 16/11/22.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZProfessionNetManager : NSObject


+ (id)getMedicPostCompletionHandler:(void(^)(id model, NSError *error))completionHandler;
+ (id)getSelectMedicPostWithID:(NSString *)ID completionHandler:(void(^)(id model, NSError *error))completionHandler;






@end
