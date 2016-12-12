//
//  HZPersonalCenterModel.h
//  dddd
//
//  Created by NSX443 on 16/11/15.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZPersonalCenterModel : NSObject

//ALLCOUNT
@property(nonatomic) NSString *allcount;
//CONTENT.
@property(nonatomic) NSString *address;
//CONTENT.
@property(nonatomic) NSString *addressInfo;
//CONTENT.
@property(nonatomic) NSString *alipay;
//CONTENT.
@property(nonatomic) NSString *birthday;
//CONTENT.
@property(nonatomic) NSString *goodAtField;
//CONTENT.id
@property(nonatomic) NSString *ID;
//CONTENT.idcard
@property(nonatomic) NSString *idCard;
//CONTENT.
@property(nonatomic) NSString *cashReserve;
//CONTENT.
@property(nonatomic) NSString *head;
//CONTENT.
@property(nonatomic) NSInteger integralReserve;
//CONTENT.
@property(nonatomic) BOOL isSign;
//CONTENT.
@property(nonatomic) NSString *medicPostId;
//CONTENT.
@property(nonatomic) NSString *medicPostName;
//CONTENT.
@property(nonatomic) NSString *name;
//CONTENT.
@property(nonatomic) NSInteger serviceHotline;
//CONTENT.
@property(nonatomic) NSString *serviceArea;
//CONTENT.
@property(nonatomic) NSString *sex;
//MSG
@property(nonatomic) NSString *msg;
//RETTYPE
@property(nonatomic) BOOL retype;
//STATE
@property(nonatomic) BOOL state;

@end
