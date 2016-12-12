//
//  HZMsgViewModel.h
//  dddd
//
//  Created by NSX443 on 16/11/21.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMsgNetManager.h"

typedef NS_ENUM(NSUInteger, VMRequestMode) {
    VMRequestModeRefresh,
    VMRequestModeMore,
};


@interface HZMsgViewModel : NSObject

@property(nonatomic) HZMsgModel *msgModel;
@property(nonatomic) NSInteger rowNumber;
@property(nonatomic) NSInteger page;
@property(nonatomic) NSMutableArray<HZMsgContentModel *> *msgConent;


- (void)getMsgWithRequestMode:(VMRequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;


- (HZMsgContentModel *)getMsgContentModelForRow:(NSInteger)row;
- (NSString *)getMsgTypeForRow:(NSInteger)row;
- (NSString *)getMsgTypeNameForRow:(NSInteger)row;
- (NSString *)getMsgContentForRow:(NSInteger)row;
- (NSString *)getCreateTimeForRow:(NSInteger)row;
- (BOOL)getIsReadForRow:(NSInteger)row;
//- (NSString *)getReadTimeForRow:(NSInteger)row;


@end
