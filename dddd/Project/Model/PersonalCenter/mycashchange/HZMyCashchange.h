//
//  HZMyCashchange.h
//  dddd
//
//  Created by NSX443 on 16/11/16.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HZMyCashchangeContent;
@interface HZMyCashchange : NSObject

//ALLCOUNT
@property(nonatomic) NSInteger acccount;

@property(nonatomic) NSArray<HZMyCashchangeContent *> *content;
//MSG
@property(nonatomic) NSString *msg;
//RETTYPE
@property(nonatomic) NSInteger retype;
//STATE
@property(nonatomic) BOOL state;

@end

@interface HZMyCashchangeContent : NSObject

//change_type
@property(nonatomic) NSString *changeType;
//cash_reserve
@property(nonatomic) NSString *cashReserve;
//reality_money
@property(nonatomic) NSString *realityMoney;
//create_date
@property(nonatomic) NSString *createDate;

@end