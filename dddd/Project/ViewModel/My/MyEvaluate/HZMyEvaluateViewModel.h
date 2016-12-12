//
//  HZMyEvaluateViewModel.h
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMyevaluateNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode){
    VMRequestModeRefresh,
    VMRequestModeMore,
};

@interface HZMyEvaluateViewModel : NSObject

- (void)getMyEvaluateModelWithVMRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;

@property(nonatomic) NSMutableArray<HZMyEvaluateContentModel *> *myEvaluateContent;
@property(nonatomic) NSInteger rowNumber;
@property(nonatomic) NSInteger page;
@property(nonatomic) HZMyEvaluateModel *myEvaluateModel;

- (HZMyEvaluateContentModel *)getContentModelWithIndex:(NSInteger)index;
- (NSString *)getHeadWithIndex:(NSInteger)index;
- (NSString *)getNameWithIndex:(NSInteger)index;
- (NSString *)getEvaluateReasonWithIndex:(NSInteger)index;
- (NSString *)getEvaluateTimeWithIndex:(NSInteger)index;
- (NSInteger)getSynthesizeScoreWithIndex:(NSInteger)index;





@end
