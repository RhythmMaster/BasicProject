//
//  HZGetCodeVM.h
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZGetCodeNM.h"

@interface HZGetCodeVM : NSObject


@property(nonatomic) NSString *randomCode;


- (void)getRandomCodeWithCode:(NSString *)uniqueCode phoneNumber:(NSString *)phoneNumber completionHandler:(void(^)(NSError *error))completionHandler;;

@end
