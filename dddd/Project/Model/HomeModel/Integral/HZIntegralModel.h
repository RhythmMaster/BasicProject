//
//  HZIntegralModel.h
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZIntegralListModel;

@interface HZIntegralModel : NSObject
@property(nonatomic) NSInteger allCount;
@property(nonatomic) NSInteger integralReserve;

@property(nonatomic) NSArray<HZIntegralListModel *> *list;

@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger reType;
@property(nonatomic) BOOL state;
@end


@interface HZIntegralListModel : NSObject

@property(nonatomic) NSString *changeType;
@property(nonatomic) NSString *createTime;
@property(nonatomic) NSInteger integralNumber;


@end
