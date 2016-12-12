//
//  StarView.h
//  CZHH
//
//  Created by 成长护航 on 16/4/13.
//  Copyright © 2016年 chengzhanghuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView * bottomView;
    UIView *clipView;
}

//设置星星进度条
-(void)setStarProgress:(double)level;

@end
