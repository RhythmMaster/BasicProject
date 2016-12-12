//
//  HZCoutDownLb.m
//  dddd
//
//  Created by tang on 16/11/29.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCoutDownLb.h"

@interface HZCoutDownLb()

@property(nonatomic) NSTimer *timer;

@end


@implementation HZCoutDownLb
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeHeadle{
    
    self.second--;
    if (self.second==-1) {
        self.second=59;
        self.minute--;
        if (self.minute==-1) {
            self.minute=59;
            self.hour--;
        }
    }
    if (_second < 10) {
        _secondStr = [NSString stringWithFormat:@"0%ld", _second];
    } else {
        _secondStr = [NSString stringWithFormat:@"%ld", _second];
    }
    if (_minute < 10) {
        _minuteStr = [NSString stringWithFormat:@"0%ld", _minute];
    } else {
        _minuteStr = [NSString stringWithFormat:@"%ld", _minute];
    }
    if (_hour < 10) {
        _hourStr = [NSString stringWithFormat:@"0%ld", _hour];
    } else {
        _hourStr = [NSString stringWithFormat:@"%ld", _hour];
    }
    
    self.text = [NSString stringWithFormat:@"%@: %@: %@",self.hourStr, self.minuteStr, self.secondStr];
    if (self.second==0 && self.minute==0 && self.hour==0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
