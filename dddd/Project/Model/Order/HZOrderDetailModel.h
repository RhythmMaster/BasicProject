//
//  HZOrderDetailModel.h
//  dddd
//
//  Created by NSX443 on 16/11/19.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZOrderDetailListModel;

@interface HZOrderDetailModel : NSObject
//ALLCOUNT
@property(nonatomic) NSInteger allCount;
//CONTENT.INFO.address_info
@property(nonatomic) NSString *addressInfo;
//CONTENT.INFO.
@property(nonatomic) NSInteger age;
//CONTENT.INFO.appointment_time
@property(nonatomic) NSString *appointmentTime;
//CONTENT.INFO.
@property(nonatomic) NSString *countDown;
//CONTENT.INFO.create_time
@property(nonatomic) NSString *createTime;
//CONTENT.INFO.description
@property(nonatomic) NSString *desc;
//CONTENT.INFO.evaluateTime
@property(nonatomic) NSString *evaluateTime;
//CONTENT.INFO.
@property(nonatomic) NSString *finishServiceTime;
//CONTENT.INFO.id
@property(nonatomic) NSString *ID;
//CONTENT.INFO.idcard
@property(nonatomic) NSString *idCard;
//CONTENT.INFO.
@property(nonatomic) NSString *head;
//CONTENT.INFO.isEvaluate
@property(nonatomic) BOOL isEvaluate;
//CONTENT.INFO.itemCase
@property(nonatomic) NSString *itemCase;
//CONTENT.INFO.itemServiceCase
@property(nonatomic) NSInteger itemServiceCase;
//CONTENT.INFO.item_classify_name
@property(nonatomic) NSString *itemClassifyName;
//CONTENT.INFO.item_name
@property(nonatomic) NSString *itemName;
//CONTENT.INFO.medicare_card
@property(nonatomic) NSString *medicareCard;
//CONTENT.INFO.name
@property(nonatomic) NSString *name;
//CONTENT.INFO.orderRevenue
@property(nonatomic) NSString *orderRevenue;
//CONTENT.INFO.order_code
@property(nonatomic) NSInteger orderCode;
//CONTENT.INFO.order_money
@property(nonatomic) NSInteger orderMoney;
//CONTENT.INFO.order_status
@property(nonatomic) NSInteger orderStatus;
//CONTENT.INFO.patientConfirmTime
@property(nonatomic) NSString *patientConfirmTime;
//CONTENT.INFO.pay_money
@property(nonatomic) NSString *payMoney;
//CONTENT.INFO.person_name
@property(nonatomic) NSString *personName;
//CONTENT.INFO.person_sex
@property(nonatomic) NSString *personSex;
//CONTENT.INFO.platformServicePrice
@property(nonatomic) NSString *platformServicePrice;
//CONTENT.INFO.receive_time
@property(nonatomic) NSString *receiveTime;
//CONTENT.INFO.serviceHotline
@property(nonatomic) NSInteger serviceHotline;
//CONTENT.INFO.serviceTime
@property(nonatomic) NSString *serviceTime;
//CONTENT.INFO.sex
@property(nonatomic) NSString *sex;
//CONTENT.INFO.tel
@property(nonatomic) NSInteger tel;
//CONTENT
@property(nonatomic) NSArray<HZOrderDetailListModel *> *list;
//MSG
@property(nonatomic) NSString *msg;
//RETTYPE
@property(nonatomic) NSInteger retype;
//STATE
@property(nonatomic) BOOL state;


@end

@interface HZOrderDetailListModel : NSObject

@property(nonatomic) NSString *name;
@property(nonatomic) NSInteger price;
@property(nonatomic) NSInteger quantity;
@property(nonatomic) NSInteger smallCount;

@end






