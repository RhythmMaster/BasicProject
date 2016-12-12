//
//  HZMyEvaluateModel.h
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZMyEvaluateContentModel;
@interface HZMyEvaluateModel : NSObject

@property(nonatomic) NSInteger allCount;
@property(nonatomic) NSArray<HZMyEvaluateContentModel *> *content;
@property(nonatomic) NSString *msg;
@property(nonatomic) NSInteger retype;
@property(nonatomic) BOOL state;


@end
@interface HZMyEvaluateContentModel : NSObject
//evaluate_reason
@property(nonatomic) NSString *evaluateReason;
//evaluate_time
@property(nonatomic) NSString *evaluateTime;

@property(nonatomic) NSString *head;
//id
@property(nonatomic) NSString *ID;
//medic_id
@property(nonatomic) NSString *medicID;

@property(nonatomic) NSString *name;
//nickname
@property(nonatomic) NSInteger nickName;
//order_id
@property(nonatomic) NSString *orderId;

@property(nonatomic) NSString *phone;
//synthesize_score
@property(nonatomic) NSInteger synthesizeScore;


@end
