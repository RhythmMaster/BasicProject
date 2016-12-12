//
//  HZMyEvaluateViewModel.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZMyEvaluateViewModel.h"

@implementation HZMyEvaluateViewModel

- (NSMutableArray<HZMyEvaluateContentModel *> *)myEvaluateContent {
    if (!_myEvaluateContent) {
        _myEvaluateContent = [NSMutableArray new];
    }
    return _myEvaluateContent;
}
- (void)getMyEvaluateModelWithVMRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler {
    NSInteger tmpPage = 1;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
    }
    [HZMyevaluateNetManager getMyevaluateWithPage:[NSString stringWithFormat:@"%ld", tmpPage] rows:@"10" completionHandler:^(HZMyEvaluateModel *model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            if (requestMode == VMRequestModeRefresh) {
                [self.myEvaluateContent removeAllObjects];
            }
            [_myEvaluateContent addObjectsFromArray:model.content];
            _page = tmpPage + 1;
            self.myEvaluateModel = model;
        }
        
        !completionHandler ?: completionHandler(error);
    }];
}

- (NSInteger)rowNumber {
    NSLog(@"%ld", self.myEvaluateContent.count);
    return self.myEvaluateContent.count;
}
- (HZMyEvaluateContentModel *)getContentModelWithIndex:(NSInteger)index {
    return self.myEvaluateContent[index];
}
- (NSString *)getHeadWithIndex:(NSInteger)index {
    return [self getContentModelWithIndex:index].head;
}
- (NSString *)getNameWithIndex:(NSInteger)index {
    return [self getContentModelWithIndex:index].name;
}
- (NSString *)getEvaluateTimeWithIndex:(NSInteger)index {
    return [self getContentModelWithIndex:index].evaluateTime;
}
- (NSString *)getEvaluateReasonWithIndex:(NSInteger)index {
    return [self getContentModelWithIndex:index].evaluateReason;
}
- (NSInteger)getSynthesizeScoreWithIndex:(NSInteger)index {
    return [self getContentModelWithIndex:index].synthesizeScore;
}







@end
