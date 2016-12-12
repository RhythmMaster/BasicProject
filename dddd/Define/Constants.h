//
//  Constants.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#ifndef Constants_h
#define Constants_h



// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

//屏幕宽度 高度
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

//三原色的设置
#define kRGBA(R,G,B,A) ([UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A])

#define kGrayColor kRGBA(179, 179, 179, 1.0)
#define kBlueColor kRGBA(38, 107, 255, 1.0)

//把self转化为 __weak __block的方式, 方便的在block中使用而不导致内存循环应用问题
//在宏中使用 \ 可以换行
#define WK(weakSelf) \
__block __weak __typeof(&*self)weakSelf = self;\

//获取当前应用程序AppDelegate对象
#define kAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#endif /* Constants_h */
