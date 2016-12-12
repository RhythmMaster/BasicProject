//
//  HZIntegralViewModel.m
//  dddd
//
//  Created by tang on 16/11/24.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZIntegralViewModel.h"

@implementation HZIntegralViewModel

- (instancetype)initWithIntegralType:(IntegralType)integralType {
    if (self = [super init]) {
        self.integralType = integralType;
    }
    return self;
}

- (NSMutableArray<HZIntegralListModel *> *)integralList {
    if (!_integralList) {
        _integralList = [NSMutableArray new];
    }
    return _integralList;
}

- (void)getIntegralAFWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    
    [HZIntegralNetManager getMyIntegralWithIntegralType:_integralType page:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"10" completionHandler:^(HZIntegralModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.integralList removeAllObjects];
            }
            self.ingegralModel = model;
            [self.integralList addObjectsFromArray:model.list];
            _page = tmpPage;
        }
        !completionHandler ?: completionHandler(error);
    }];
    
}

- (NSInteger)getIntegralReserve {
    return self.ingegralModel.integralReserve;
}
- (NSInteger)number {
    return self.integralList.count;
}
- (HZIntegralListModel *)getIntegralListModelWithIndex:(NSInteger)index {
    return self.integralList[index];
}
- (NSString *)getChangeTypeWithIndex:(NSInteger)index {
    return [self getIntegralListModelWithIndex:index].changeType;
}
- (NSString *)getCreateDateWithIndex:(NSInteger)index {
    return [self getIntegralListModelWithIndex:index].createTime;
}
- (NSInteger)getIntegralNumberWithIndex:(NSInteger)index {
    return [self getIntegralListModelWithIndex:index].integralNumber;
}







- (void)getIntegralRuleWithCompletionHandler:(void (^)(NSError *))completionHandler {
    [HZIntegralNetManager getIntegrationRuleWithCompletionHandler:^(id model, NSError *error) {
        if (!error) {
            self.integralRuleModel = model;
        }
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSString *)getIntegralRule {
    return [self.integralRuleModel objectForKey:@"CONTENT"];
}


@end
