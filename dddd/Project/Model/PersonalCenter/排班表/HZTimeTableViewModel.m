//
//  HZTimeTableViewModel.m
//  dddd
//
//  Created by tang on 16/11/23.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZTimeTableViewModel.h"

@implementation HZTimeTableViewModel

+(NSDictionary *)replacedKeyFromPropertyNameJSON {
    return @{@"allCount": @"ALLCOUNT",
             @"content": @"CONTENT",
             @"msg": @"MSG",
             @"retype": @"RETTYPE",
             @"state": @"STATE"};
}
+ (NSDictionary *)getInnerClassFromArray {
    return @{@"content": [HZTimeTableViewContentModel class]};
}

@end

@implementation HZTimeTableViewContentModel



@end
