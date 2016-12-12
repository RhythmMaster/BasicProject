//
//  HZHomeModel.h
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZHomeListModel;
@interface HZHomeModel : NSObject

@property(nonatomic) NSInteger allcount;
//CONTENT.INFO.
@property(nonatomic) NSInteger caseCount;
//CONTENT.INFO.
@property(nonatomic) NSString *head;
//CONTENT.INFO.
@property(nonatomic) BOOL isSign;
//CONTENT.INFO.
@property(nonatomic) NSInteger msgCount;
//CONTENT.INFO.
@property(nonatomic) NSString *name;
//CONTENT.INFO.
@property(nonatomic) NSInteger receiveOrderCount;
//CONTENT.INFO.
@property(nonatomic) NSInteger serviceCount;
//CONTENT.LIST
@property(nonatomic) NSArray<HZHomeListModel *> *list;
//MSG
@property(nonatomic) NSString *msg;
//RETTYPE
@property(nonatomic) NSInteger retype;
//STATE
@property(nonatomic) BOOL state;


@end


@interface HZHomeListModel : NSObject

//address_info
@property(nonatomic) NSString *addressInfo;

@property(nonatomic) NSInteger age;
//appointment_time
@property(nonatomic) NSString *appointmentTime;

@property(nonatomic) NSString *birthday;
//create_time
@property(nonatomic) NSString *createTime;
//evaluateTime
@property(nonatomic) NSString *evaluateTime;
//head
@property(nonatomic) NSString *head;
//id
@property(nonatomic) NSString *ID;
//isEvaluate
@property(nonatomic) BOOL isEvaluate;
//item_classify_name
@property(nonatomic) NSString *itemClassifyName;
//item_id
@property(nonatomic) NSString *itemId;
//item_name
@property(nonatomic) NSString *itemName;

@property(nonatomic) NSString *name;

@property(nonatomic) NSString *orderRevenue;

@property(nonatomic) NSString *orderServices;
//order_money
@property(nonatomic) NSInteger orderMoney;
//order_status
@property(nonatomic) NSInteger orderStatus;
//order_statusCode
@property(nonatomic) NSInteger orderStatusCode;
//order_statusName
@property(nonatomic) NSString *orderStatusName;
//person_name
@property(nonatomic) NSString *personName;

@property(nonatomic) NSString *sex;

@property(nonatomic) NSInteger tel;

@end









