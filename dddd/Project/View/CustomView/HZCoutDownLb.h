//
//  HZCoutDownLb.h
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZCoutDownLb : UILabel

@property (nonatomic,assign)NSInteger second;
@property (nonatomic,assign)NSInteger minute;
@property (nonatomic,assign)NSInteger hour;

@property (nonatomic,assign)NSString *secondStr;
@property (nonatomic,assign)NSString *minuteStr;
@property (nonatomic,assign)NSString *hourStr;

@end
