//
//  HZOrderDetailViewModel.h
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZOrderDetailNetManager.h"

@interface HZOrderDetailViewModel : NSObject

@property(nonatomic) HZOrderDetailModel *orderModel;

@property(nonatomic) NSArray<HZOrderDetailListModel *> *listModel;

@property(nonatomic) NSInteger numberRow;


//- (instancetype)initWithID:(NSString *)ID;

- (void)getModelsWithID:(NSString *)ID completionHandler:(void(^)(NSError *error))completionHandler;

//- (HZOrderDetailModel *)getModelDataForIndex:(NSInteger)index;

//- (NSString *)getCountDownForIndex:(NSInteger)index;
//
//
//- (NSString *)getOrderRevenueForIndex:(NSInteger)index;
//- (NSString *)getAppointmentTimeForIndex:(NSInteger)index;
//
//
//- (NSString *)getPersonNameForIndex:(NSInteger)index;
//- (NSString *)getSexForIndex:(NSInteger)index;
//- (NSInteger)getAgeForIndex:(NSInteger)index;
//- (NSString *)getIdCardForIndex:(NSInteger)index;
//- (NSString *)getMedicareCardForIndex:(NSInteger)index;
//- (NSURL *)getHeadForIndex:(NSInteger)index;
//
//- (NSString *)getNameForIndex:(NSInteger)index;
//- (NSInteger)getTelForIndex:(NSInteger)index;
//
//- (NSString *)getAddressInfoForIndex:(NSInteger)index;
//- (NSString *)getItemClassifyNameForIndex:(NSInteger)index;
//- (NSString *)getDescriptionForIndex:(NSInteger)index;
//
//
//
//- (NSString *)getItemCaseForIndex:(NSInteger)index;
//- (NSInteger)getItemServiceCaseForIndex:(NSInteger)index;
//- (NSInteger)getPlatformServicePriceForIndex:(NSInteger)index;
//
//
//- (NSInteger)getOrderCodeForIndex:(NSInteger)index;
//- (NSString *)getCreateTimeForIndex:(NSInteger)index;
//- (NSString *)getReceiveTimeForIndex:(NSInteger)index;
//- (NSString *)getServiceTimeForIndex:(NSInteger)index;


- (HZOrderDetailListModel *)getListModelIndex:(NSInteger)index;
- (NSString *)getListNameForIndex:(NSInteger)index;
- (NSInteger)getListQuantityForIndex:(NSInteger)index;
- (NSInteger)getListPriceForIndex:(NSInteger)index;
- (NSInteger)getLisrSmallCountForIndex:(NSInteger)index;

//- (NSString *)getOrderMoneyForIndex:(NSInteger)index;
//- (NSString *)getPayMoneyForIndex:(NSInteger)index;






@end
