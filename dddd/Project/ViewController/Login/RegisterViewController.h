//
//  RegisterViewController.h
//  dddd
//
//  Created by NSX443 on 16/11/7.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "ViewController.h"
#import "LogoView.h"
#import "HZGetCodeNM.h"


typedef void (^phoneBlock)(NSString *);

@interface RegisterViewController : ViewController


@property(nonatomic, copy) phoneBlock block;
- (void)phone:(phoneBlock)block;


@end
