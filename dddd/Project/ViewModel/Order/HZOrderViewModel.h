//
//  HZOrderViewModel.h
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode){
    VMRequestModeRefresh,
    VMRequestModeMore,
};


@interface HZOrderViewModel : NSObject


@property(nonatomic) NSMutableArray<HZOrderContentModel *> *orderContent;


@property(nonatomic) NSInteger rowNumber;
@property(nonatomic) NSInteger page;
@property(nonatomic) OrderType orderType;


- (instancetype)initWithOrderType:(OrderType)orderType;

- (void)getContentWithRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;
- (HZOrderContentModel *)getContentWithRow:(NSInteger)row;


- (NSString *)getOrderStatusNameWithRow:(NSInteger)row;
- (NSString *)getItemNameWithRow:(NSInteger)row;
- (NSString *)getItemClassifyNameWithRow:(NSInteger)row;


- (NSURL *)getHeadWithRow:(NSInteger)row;
- (NSString *)getPersonNameWithRow:(NSInteger)row;
- (NSInteger)getAgeWithRow:(NSInteger)row;
- (NSString *)getSexWithRow:(NSInteger)row;
- (NSString *)getOrderServicesWithRow:(NSInteger)row;
- (NSString *)getAppointmentTimeWithRow:(NSInteger)row;



- (NSString *)getNameWithRow:(NSInteger)row;
- (NSInteger)getTelWithRow:(NSInteger)row;
- (NSString *)getAddressInfoWithRow:(NSInteger)row;
- (NSString *)getCreateTimeWithRow:(NSInteger)row;



- (NSString *)getOrderRevenueWithRow:(NSInteger)row;
- (NSInteger)getOrderStatusCodeWithRow:(NSInteger)row;

//传到详细页的参数
- (NSString *)getIdWithRow:(NSInteger)row;


@end
