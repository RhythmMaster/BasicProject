//
//  HZOrderViewModel.m
//  dddd
//
//  Created by NSX443 on 16/11/17.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderViewModel.h"

@implementation HZOrderViewModel

- (instancetype)initWithOrderType:(OrderType)orderType {
    if (self = [super init]) {
        self.orderType = orderType;
    }
    return self;
}

- (NSMutableArray<HZOrderContentModel *> *)orderContent {
    if (!_orderContent) {
        _orderContent = [NSMutableArray new];
    }
    return _orderContent;
}

- (void)getContentWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError * error))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZOrderNetManager getOrderWithOrderType:self.orderType page:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"10" completionHandler:^(HZOrderModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.orderContent removeAllObjects];
            }
            [self.orderContent addObjectsFromArray:model.content];
            _page = tmpPage;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSInteger)rowNumber {
    return self.orderContent.count;
}



- (HZOrderContentModel *)getContentWithRow:(NSInteger)row {
    return self.orderContent[row];
}



- (NSString *)getOrderStatusNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderStatusName;
}
- (NSString *)getItemNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].itemName;
}
- (NSString *)getItemClassifyNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].itemClassifyName;
}



- (NSURL *)getHeadWithRow:(NSInteger)row {
    return [self getContentWithRow:row].head.tzl_URL;
}
- (NSString *)getPersonNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].personName;
}
- (NSInteger)getAgeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].age;
}
- (NSString *)getSexWithRow:(NSInteger)row {
    return [self getContentWithRow:row].sex;
}
- (NSString *)getOrderServicesWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderServices;
}
- (NSString *)getAppointmentTimeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].appointmentTime;
}




- (NSString *)getNameWithRow:(NSInteger)row {
    return [self getContentWithRow:row].name;
}
- (NSInteger)getTelWithRow:(NSInteger)row {
    return [self getContentWithRow:row].tel;
}
- (NSString *)getAddressInfoWithRow:(NSInteger)row {
    return [self getContentWithRow:row].addressInfo;
}
- (NSString *)getCreateTimeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].createTime;
}



- (NSInteger)getOrderStatusCodeWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderStatusCode;
}
- (NSString *)getOrderRevenueWithRow:(NSInteger)row {
    return [self getContentWithRow:row].orderRevenue;
}



- (NSString *)getIdWithRow:(NSInteger)row {
    return [self getContentWithRow:row].ID;
}




@end
