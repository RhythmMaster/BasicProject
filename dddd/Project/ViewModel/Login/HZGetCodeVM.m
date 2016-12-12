//
//  HZGetCodeVM.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZGetCodeVM.h"

@implementation HZGetCodeVM

- (void)getRandomCodeWithCode:(NSString *)uniqueCode phoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(NSError *))completionHandler {
    [HZGetCodeNM getRandomCodeWithUUID:uniqueCode phoneNumber:phoneNumber completionHandler:^(id model, NSError *error) {
        if (!error) {
            
        }
    }];
}
@end
