//
//  HZOrderDetailViewModel.m
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZOrderDetailViewModel.h"

@implementation HZOrderDetailViewModel

- (NSArray<HZOrderDetailListModel *> *)listModel {
    if (!_listModel) {
        _listModel = [NSArray new];
    }
    return _listModel;
}
- (HZOrderDetailModel *)orderModel {
    if (!_orderModel) {
        
    }
    return _orderModel;
}



- (void)getModelsWithID:(NSString *)ID completionHandler:(void (^)(NSError * error))completionHandler {
    [HZOrderDetailNetManager getOrderDetatilWithId:ID completionHandler:^(HZOrderDetailModel *model, NSError *error) {
        if (!error) {
            self.listModel = model.list;
            self.orderModel = model;
            NSLog(@"--------2:%ld", self.orderModel.orderStatus);
            !completionHandler ?: completionHandler(error);
        }
    }];
}

- (HZOrderDetailListModel *)getListModelIndex:(NSInteger)index {
    return self.listModel[index];
}
- (NSInteger)numberRow {
    return self.listModel.count;
}


- (NSString *)getListNameForIndex:(NSInteger)index {
    return self.listModel[index].name;
}
- (NSInteger)getListQuantityForIndex:(NSInteger)index {
    return self.listModel[index].quantity;
}
- (NSInteger)getListPriceForIndex:(NSInteger)index {
    return self.listModel[index].price;
}
- (NSInteger)getLisrSmallCountForIndex:(NSInteger)index {
    return self.listModel[index].smallCount;
}








@end
