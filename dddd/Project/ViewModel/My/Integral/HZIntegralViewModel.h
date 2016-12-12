//
//  HZIntegralViewModel.h
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZIntegralNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode) {
    VMRequestModeRefresh,
    VMRequestModeMore,
};

@interface HZIntegralViewModel : NSObject

@property(nonatomic) NSInteger page;
@property(nonatomic) NSMutableArray<HZIntegralListModel *> *integralList;
@property(nonatomic) HZIntegralModel *ingegralModel;
@property(nonatomic) IntegralType integralType;
- (instancetype)initWithIntegralType:(IntegralType)integralType;


- (void)getIntegralAFWithRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;



@property(nonatomic) NSInteger number;

- (NSInteger)getIntegralReserve;

- (HZIntegralListModel *)getIntegralListModelWithIndex:(NSInteger)index;
- (NSString *)getChangeTypeWithIndex:(NSInteger)index;
- (NSString *)getCreateDateWithIndex:(NSInteger)index;
- (NSInteger)getIntegralNumberWithIndex:(NSInteger)index;



- (void)getIntegralRuleWithCompletionHandler:(void(^)(NSError *error))completionHandler;
@property(nonatomic) id integralRuleModel;

- (NSString *)getIntegralRule;



@end
