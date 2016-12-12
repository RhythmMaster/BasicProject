//
//  HZCustomLabel.m
//  dddd
//
//  Created by NSX443 on 16/11/18.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZCustomLabel.h"

@implementation HZCustomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.textInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.textInsets.left;
    rect.origin.y -= self.textInsets.top;
    rect.size.width += self.textInsets.left + self.textInsets.right;
    rect.size.height += self.textInsets.top + self.textInsets.bottom;
    return rect;
}


//重写drawTextInRect
- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

@end
